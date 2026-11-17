# 來源與修改紀錄

- 來源：https://github.com/softaworks/agent-toolkit （`skills/mermaid-diagrams`）
- 版本：commit `3027f20`（2026-03-05）
- 授權：MIT，全文見同資料夾的 `LICENSE`。Copyright (c) 2026 Leonardo Flores

## 修改內容

收錄 `SKILL.md` 和 `references/` 全部檔案，未收錄原資料夾的 `README.md`（給人看的介紹，助理用不到）。

我用 mermaid-cli 12.2.0 把所有範例實際渲染過，修正了以下會畫壞的範例：

| 檔案 | 原本 | 修正 |
|---|---|---|
| `references/flowcharts.md` | 圓角矩形和膠囊形的範例對調了 | `B(...)` 是圓角，`C([...])` 是膠囊 |
| `references/flowcharts.md` | 二分搜尋範例的節點文字含 `( )`、`[ ]`，解析失敗 | 文字加上雙引號 |
| `references/erd-diagrams.md` | 「一或多」寫成 `}{`，解析失敗 | 改成 `}|` |
| `references/erd-diagrams.md` | 實線與虛線的說明寫反 | `--` 是 identifying，`..` 是 non-identifying |
| `references/erd-diagrams.md` | 欄位寫 `FK PK`，解析失敗 | 改成 `PK, FK` |
| `references/advanced-features.md` | 流程圖用了 `link A: ... @ url`，解析失敗 | 改成 `click A "url" "說明"` |
| `references/advanced-features.md` | `%%{init}%%` 寫在圖的結尾 | 移到圖的開頭 |
| `references/architecture-diagrams.md` | 服務被放進另一個服務（`in api`），解析失敗 | 改成放進 `group` |

修正後 142 段範例中 139 段可正常渲染，其餘 3 段是刻意的語法樣板（例如 `diagramType` 佔位字），不是完整的圖。
