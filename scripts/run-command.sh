#!/usr/bin/env bash
# 不開介面，直接執行一個自訂指令並印出結果。給 cron 等排程使用。
# 用法：scripts/run-command.sh <指令名稱> [參數...]
# 例子：scripts/run-command.sh plan > reports/plan-$(date +%F).md
#
# 同時支援 opencode 1.x（run --command）和 2.x（透過背景服務的 API）。
# 只適合不需要寫入 memory/ 的指令（plan、brief、report 等）：
# 無人值守時沒有人能核准 diff，寫入 memory/ 的動作會被自動拒絕。
set -euo pipefail

cd "$(dirname "$0")/.."
[ -f .env ] && { set -a; . ./.env; set +a; }

name="${1:?用法：scripts/run-command.sh <指令名稱> [參數...]}"
shift
args="$*"

if opencode run --help 2>&1 | grep -q -- '--command'; then
  # opencode 1.x
  exec opencode run --command "$name" "$args"
fi

# opencode 2.x：run 不會展開斜線指令，改用 API 呼叫 session.command
opencode service start >/dev/null

body=$(python3 -c 'import json,sys; print(json.dumps({"location":{"directory":sys.argv[1]}}))' "$PWD")
sid=$(opencode api session.create -d "$body" | python3 -c 'import json,sys; print(json.load(sys.stdin)["data"]["id"])')

body=$(python3 -c 'import json,sys; print(json.dumps({"name":sys.argv[1],"text":sys.argv[2]}))' "$name" "$args")
opencode api session.command --param "sessionID=$sid" -d "$body" >/dev/null

# 等這個 session 跑完（最多 15 分鐘），印出最後一則助理回覆
for _ in $(seq 1 180); do
  if out=$(opencode api session.message.list --param "sessionID=$sid" | python3 -c '
import json, sys
msgs = json.load(sys.stdin)["data"]
if not any(m.get("type") == "idle" for m in msgs):
    sys.exit(1)
for m in msgs:
    if m.get("type") == "assistant":
        print("".join(p.get("text", "") for p in m.get("content", []) if p.get("type") == "text"))
        break
'); then
    printf '%s\n' "$out"
    exit 0
  fi
  sleep 5
done
echo "逾時：session $sid 15 分鐘內沒有完成" >&2
exit 1
