---
description: 產出今天的工作報告（日報）
---
今天是：!`date "+%Y-%m-%d %A"`

補充說明（可能為空）：$ARGUMENTS

今天的記憶變動：
!`git log --since=midnight --date=short --pretty=format:"%ad %s"`

請照以下步驟：

1. 從上面的 git 紀錄找出今天有變動的專案，讀這些專案檔今天的進度日誌。再讀 `memory/work/index.md` 掌握全貌。
2. 在 `memory/boss/preferences.md` 找「日報」或「週報」的顆粒度設定和圖表偏好。沒有顆粒度設定時，參考 `references/communication/stakeholder-update/SKILL.md` 的 Executive / Leadership Update 模板（狀態燈號、一句話總結、風險附對策、需要的決策附建議和期限），並在最後提醒使用者這是通用模板，還沒有這位主管的資料。
3. 依金字塔結構寫日報：
   - **L1**：一句話總結今天（最重要的進展或最需要他知道的事）
   - **L2**：依專案分點，每個專案一兩行，帶必帶項目；需要主管決策或協助的事放最前面
   - **明天計畫**：最多 3 項
   - **L3 備用**：不寫進報告本文，另列在報告下方的「備用細節」區塊，供追問時用
   - **圖**：圖表偏好要求日報附圖時才畫，用 Mermaid 直接寫進報告；需要寄出的圖片照 AGENTS.md 用 draw.io 匯出到 `reports/diagrams/`
   - 有延期或風險時，壞消息放在 L1 或 L2 的最前面，不要排在好消息後面
4. 寫入 `reports/daily/<今天日期>.md`（這個資料夾不需要確認）。
5. 提交 git：`report: <日期> 日報`。
6. 最後在對話中直接給出可以複製貼上的報告本文（不含備用細節）。

若今天沒有任何進度紀錄，不要編造。告訴使用者今天沒有 `/log` 紀錄，請他先口頭補充今天做了什麼。
