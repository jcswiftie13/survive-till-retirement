# boss-copilot

一個用 git repo 當記憶、用 opencode 當介面的工作助理。它記得主管的偏好、公司知識和你手上的工作，幫你排序、提醒，並用主管喜歡的顆粒度（由粗到細）回答。

沒有程式碼。整個「agent」由三樣東西組成：

- `AGENTS.md`：助理的規則，opencode 每次都會讀
- `memory/`：所有記憶，都是 Markdown，可以直接打開改
- `.opencode/commands/`：自訂指令，每個指令是一份固定流程的 prompt

git 歷史就是記憶的修改紀錄：記錯了可以 `git revert`，也能用 `git log` 看主管偏好怎麼變過來的。

## 開始使用

1. 安裝 opencode（參考 https://opencode.ai/docs ）。
2. 設定模型端點。複製 `.env.example` 成 `.env`，填入你的 OpenAI 相容端點，然後在啟動前載入：

   ```bash
   cp .env.example .env    # 編輯填入
   set -a; source .env; set +a
   ```

3. 把 `opencode.json` 裡的 `your-model-id`（兩處）改成實際的模型名稱。
4. 初始化 git 並啟動：

   ```bash
   git init && git add -A && git commit -m "init"
   opencode
   ```

## 指令

### 餵資料（學習）

| 指令 | 用途 | 例子 |
|---|---|---|
| `/teach` | 直接告訴它主管的偏好 | `/teach 他看週報只看第一段，數字一定要有上週對比` |
| `/debrief` | 回報一次和主管的互動，讓它學 | `/debrief 今天報告延遲，我講到第二句他就打斷說先講什麼時候好…` |
| `/log` | 回報工作進度（短期記憶） | `/log A 專案測試卡在供應商樣品，延到下週三，良率 92%` |
| `/kb` | 寫入公司知識（長期記憶） | `/kb 7 月起採購超過 50 萬要處級簽核` |
| `/done` | 結案：留下有價值的部分，專案封存或刪除 | `/done A 專案` 或 `/done A 專案 刪除` |

### 拿結果（輸出）

| 指令 | 用途 |
|---|---|
| `/plan` | 排出今天的工作順序和主管提醒 |
| `/brief` | 準備怎麼報告某件事，輸出 L1／L2／L3 |
| `/report` | 產出今天的日報，存到 `reports/daily/` |
| `/reply` | 草擬回覆主管的訊息 |
| `/prep` | 準備會議，列出他可能問的問題和答案 |
| `/drill` | 模擬主管一題一題問你，結束後給回饋 |
| `/review` | 每週整併記憶，順便清掉佔上下文的舊資料 |

不用指令也可以直接問，例如「主管問 B 案為什麼延期，我該怎麼回？」。它會照 `AGENTS.md` 的規則去讀記憶、搜尋相關的公司知識再回答。

## 學習迴路

`/brief`、`/reply`、`/prep`、`/drill` 的產出會自動存到 `reports/briefs/`。之後你用 `/debrief` 回報實際和主管的對話，助理會找出同主題的那份建議，對照「它預測的」和「實際發生的」：哪些追問猜中了、哪些沒料到、照建議講之後主管反應如何。這些差異會變成偏好和顆粒度設定的修改提案。

`/drill` 裡助理扮演的主管只是推測，不會被當成偏好的證據。只有你回報的真實互動才會改變它對主管的認識。

## 記憶怎麼載入、怎麼移除

`opencode.json` 的 `instructions` 會在每次對話開始時，自動把這五份檔案放進上下文：主管偏好、應對守則、術語表、組織與人、工作索引。它們每次都佔空間，所以要精簡。`/review` 會把作廢的偏好移到 `memory/boss/history.md`，並刪掉過時的術語和人員。

其他記憶（專案細節、事件、知識主題檔）只在需要時才搜尋讀取。

專案完成後用 `/done`。它會先把結果、決策、踩過的坑整理進公司知識，再依你的選擇處理專案檔：

- **封存**：移到 `archive/`。`.ignore` 讓它的內容不會出現在搜尋結果，不佔上下文；之後問到過去的專案還找得到。
- **刪除**：`git rm` 掉，只剩 git 歷史可以找回。

## 寫入怎麼確認

`opencode.json` 的權限設定：

- 修改 `memory/` 等檔案：每次都先顯示 diff 讓你核准。這是防止它記錯的最後一道關卡，建議不要關掉。
- 寫入 `reports/`：不用確認，因為那裡只放產出，不是記憶。
- 執行 `rm`、`mv`、`git rm`、`git mv`：要你確認，避免記憶被默默移走。

核准的修改會自動 commit。

## 由粗到細是怎麼運作的

`memory/boss/preferences.md` 的「顆粒度設定」記錄每種任務類型：預設講到哪一層、必帶項目、主管習慣的追問路徑、長度上限。所有輸出指令都依這個設定產出：

- **L1**：一句結論
- **L2**：兩三個重點，含必帶項目
- **L3**：備用細節，照追問路徑排好，主管問了再拿出來

一開始這份設定是空的，靠 `/debrief` 慢慢累積。回報互動時，記得描述主管在哪裡打斷你、追問了什麼。

## 接公司系統（MCP）

`opencode.json` 的 `mcp` 區塊有一個停用中的範例。把 `url` 換成公司系統的 MCP server、`enabled` 改成 `true` 即可。本地執行的 MCP server 改用：

```json
"my-server": {
  "type": "local",
  "command": ["npx", "-y", "<mcp-server-package>"],
  "enabled": true
}
```

注意：

- 讓模型自己呼叫 MCP 工具，端點必須支援 function calling。opencode 本身也靠 function calling 讀寫檔案，所以你選的模型本來就要支援。
- 只開唯讀工具（搜尋、讀頁面）。公司系統的內容不要整批複製進 `memory/`，只存結論和連結。

## 換模型

整個 repo 只依賴 OpenAI 相容的端點。要換成本地模型（Ollama、vLLM、LM Studio），只要改 `.env` 的 `LLM_BASE_URL`，例如 Ollama 是 `http://localhost:11434/v1`。

選模型時，**工具呼叫的穩定度比寫作能力重要**：這個流程需要模型可靠地讀檔、搜尋、編輯。太小的本地模型常會亂改檔案格式。

## 隱私

主管的言行和公司資料會送到你設定的模型供應商。使用前請確認公司對外部 AI 服務的規範；敏感內容建議用本地模型。這個 repo 若要推到遠端，請用私人 repo。

## 已知限制

- 排序、偏好升級等規則寫在 prompt 裡，由模型遵守，不是程式強制。大多時候會照做，但 diff 確認仍然是必要的。
- 記憶增加到數百個事件檔以後，靠 grep 搜尋可能不夠準。到時再考慮加向量檢索。
- 每天早上自動產出排序需要另外設排程，例如 cron 加一行 `0 8 * * 1-5 /path/to/boss-copilot/scripts/run-command.sh plan > /path/to/boss-copilot/reports/plan-$(date +\%F).md`。這支腳本需要 python3。無人值守時沒有人能核准 diff，所以只適合 `/plan`、`/brief` 這類不寫入 `memory/` 的指令。
- opencode 很舊的版本（1.0 以前），指令資料夾叫 `.opencode/command/`（單數）。若指令沒出現，把資料夾改名試試。

## opencode 版本

已實測 opencode 1.19.3 和 2.0.32，所有功能都能用：

- `opencode.json` 用的是 1.x 格式，2.0 會自動轉換（`permission` 轉成 `permissions`、`bash` 轉成 `shell`、`provider` 轉成 `providers`），不會出現警告。兩個版本共用同一份設定，不用改。
- 2.0 的套件名稱是 `@opencode/cli`，和 1.x 的 `opencode-ai` 不同。
- 2.0 的 `opencode run` 不會展開斜線指令，`--command` 參數也拿掉了。在介面裡打 `/plan` 照常可用；排程請用 `scripts/run-command.sh`，它會自動判斷版本，2.0 時改走 opencode 的背景服務 API。
- 2.0 官方文件說 `instructions` 目前「接受但不載入」，但 2.0.32 實測會載入。若之後的版本真的不載入，就把這五份檔案的路徑寫進 `AGENTS.md`，請它每次開始時先讀。
