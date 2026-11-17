# 溝通框架參考

這裡收錄四份別人整理好的溝通方法，都是從業界經驗或經典著作歸納出來的。它們是**通用**的做法，助理會在兩種情況下參考：

1. **冷啟動**：主管偏好檔裡還沒有這類任務的資料時，先用這些通用做法當預設值。
2. **寫作品質**：偏好檔已經決定「講什麼、講到哪一層」，這些參考負責「怎麼講清楚」，例如論點怎麼分組、壞消息怎麼開口。

## 優先順序

**主管偏好永遠優先。** 依序是：

1. `memory/boss/preferences.md` 裡狀態為 `生效` 的偏好
2. 同一份檔案裡狀態為 `暫定` 的偏好
3. `memory/boss/playbook.md` 的應對守則
4. 這個資料夾的通用框架

通用框架和偏好衝突時，照偏好做，並在輸出最後用一行說明：「通用做法建議 X，但依 [pref-xxx] 改成 Y」。例如通用的主管更新模板要求 200 字內，但這位主管的偏好是先看數字表格，那就照偏好。

## 各指令參考哪一份

| 情境 | 指令 | 參考 | 重點 |
|---|---|---|---|
| 任何要面對主管的說明 | `/brief`、`/reply` | `pyramid-principle/` | 結論先講；同一層的論點抽象程度要一致；論點的順序要有邏輯 |
| 日報、週報、進度更新 | `/report` | `stakeholder-update/` | 主管版更新模板：狀態燈號、一句話總結、風險附對策、需要的決策附建議和期限 |
| 壞消息、風險、延期 | `/brief`、`/reply`、`/report` | `stakeholder-update/` 的 Risk Communication、`difficult-workplace-conversations/references/delivery-scripts.md` | 壞消息先講，不要埋在好消息後面；每個風險都附對策；講清楚影響多大、多久 |
| 準備會議、預判追問 | `/prep` | `managing-up/references/artifacts.md` | 重排優先順序前的檢查清單：什麼會延、誰會不滿、你的建議 |
| 不同意主管、爭取資源 | `/reply`、`/prep` | `managing-up/` | 用「怎麼讓事情成功」來表達不同意，不要說成「反對」；請他在你的工作清單中選擇要換掉什麼 |
| 模擬練習 | `/drill` | `difficult-workplace-conversations/` | 被追問時爭取思考時間的說法；承認錯誤但不過度道歉 |
| 互動後學習 | `/debrief` | 全部 | 用這些框架的語彙描述主管的反應（例如「他要的是 SCR 結構裡的 Resolution」），方便歸納偏好 |

## 使用時要注意

- `stakeholder-update/` 是寫給產品經理的，提到的 `~~project tracker`、`~~chat` 等連接器和 `CONNECTORS.md` 在這個 repo 不存在，忽略那些段落。工作內容一律從 `memory/work/` 讀。
- `difficult-workplace-conversations/` 大多以「主管對部屬」的角度寫，套用時要換成「部屬對主管」。
- `managing-up/` 是從 Lenny's Podcast 來賓的訪談整理出來的，每條都有出處人名。少數說法要當成參考，不能當成結論：
  - 「覺得被微管理，多半是因為你表現不夠好」：這只是一種可能。不要用它來評斷使用者，要以事件紀錄為準。
  - 「主動接下別人不想做的維運工作來累積信用」：可能讓人過勞。只在使用者自己提出時才建議。
- 所有引用要標出處，例如 `[ref: managing-up / Wes Kao]`，和記憶的依據標示分開。

## 來源與授權

| 資料夾 | 來源 | 版本 | 授權 | 收錄時的修改 |
|---|---|---|---|---|
| `pyramid-principle/` | [applied-artificial-intelligence/claude-code-toolkit](https://github.com/applied-artificial-intelligence/claude-code-toolkit) `examples/writing/skills/pyramid-principle` | `efaacc1`（2026-07-07） | MIT，Copyright (c) 2025 Applied AI Consulting | 無 |
| `stakeholder-update/` | [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) `product-management/skills/stakeholder-update` | `e91a134`（2026-11-13） | Apache-2.0 | 無 |
| `managing-up/` | [refoundai/lenny-skills](https://github.com/refoundai/lenny-skills) `skills/managing-up` | `13598cc`（2026-07-15） | MIT，Copyright (c) 2025 Refound AI | `references/artifacts.md` 刪除一段電子報訂閱的推銷內容；`references/guest-insights.md` 刪除 7 筆內容空白或擷取失敗的條目 |
| `difficult-workplace-conversations/` | [softaworks/agent-toolkit](https://github.com/softaworks/agent-toolkit) `skills/difficult-workplace-conversations` | `3027f20`（2026-03-05） | MIT，Copyright (c) 2026 Leonardo Flores | 未收錄原資料夾的 `README.md` |

各資料夾都附有原始授權全文（`LICENSE`）。

這些檔案放在 `references/`，不在 `.opencode/skills/`，所以 opencode 不會把它們當成 skill 自動觸發，只有指令或 `AGENTS.md` 叫助理讀時才會用到。這是刻意的：避免通用模板在你沒注意時蓋過主管偏好。
