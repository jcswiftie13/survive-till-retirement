# 來源與修改紀錄

- 來源：https://github.com/jgraph/drawio-mcp （draw.io 開發商 JGraph Ltd. 官方維護）
- 版本：commit `1202e16`（2026-11-16）
- 授權：Apache License 2.0，全文見同資料夾的 `LICENSE`。Copyright 2025 JGraph Ltd.

## 收錄的檔案

| 本 repo 路徑 | 原始路徑 |
|---|---|
| `SKILL.md` | `plugins/claude-code/skills/drawio/SKILL.md` |
| `scripts/find-shapes.js` | `plugins/claude-code/skills/drawio/scripts/find-shapes.js`（未修改） |
| `references/mermaid-reference.md` | `shared/mermaid-reference.md`（未修改） |
| `references/xml-essentials.md` | `shared/xml-essentials.md`（未修改） |
| `references/xml-reference.md` | `shared/xml-reference.md`（未修改） |

## 修改內容

依 Apache License 2.0 第 4(b) 條註明：

- `SKILL.md`：原本要求執行時從 `raw.githubusercontent.com` 下載三份參考文件，改成讀取同資料夾 `references/` 裡的副本，讓公司網路擋住 GitHub 時也能用。第 379 行多加一句：參考文件說「MCP server 會自動加上」的屬性，要自己加。

其餘內容與原版相同。

## 更新方式

```bash
git clone --depth 1 https://github.com/jgraph/drawio-mcp /tmp/drawio-mcp
cp /tmp/drawio-mcp/plugins/claude-code/skills/drawio/SKILL.md .opencode/skills/drawio/SKILL.md
cp /tmp/drawio-mcp/plugins/claude-code/skills/drawio/scripts/* .opencode/skills/drawio/scripts/
cp /tmp/drawio-mcp/shared/{mermaid-reference.md,xml-essentials.md,xml-reference.md} .opencode/skills/drawio/references/
```

更新後要重新套用上面的 `SKILL.md` 修改，並更新這份檔案的 commit 編號。
