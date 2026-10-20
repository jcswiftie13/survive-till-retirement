---
description: 每週整併記憶：合併重複、找出衝突、改寫應對守則
---
今天是：!`date "+%Y-%m-%d %A"`

過去一週的記憶變動：
!`git log --since="7 days ago" --date=short --pretty=format:"%ad %s"`

補充說明（可能為空）：$ARGUMENTS

請照以下步驟：

1. 讀 `memory/boss/preferences.md`、`memory/boss/playbook.md`，以及過去一週新增的事件檔。
2. 找出並提議處理：
   - 重複或幾乎相同的偏好 → 合併，證據合在一起
   - 互相矛盾但都沒作廢的偏好 → 問使用者哪個是現在的狀況
   - 證據已足但仍是 `暫定` 的偏好 → 升為 `生效`
   - 超過兩個月沒有新證據的 `暫定` 偏好 → 提醒使用者確認是否還成立
   - 可以歸納成新守則的模式 → 新增或改寫 `playbook.md`
3. **瘦身自動載入的檔案。** 這幾份每次都佔上下文：
   - `preferences.md` 裡 `已作廢` 的條目 → 整筆移到 `memory/boss/history.md`
   - `glossary.md`、`people.md` 裡過時的列 → 刪除（git 歷史會保留）
   - `index.md` 裡已經完成的專案 → 提醒使用者用 `/done`
4. 檢查 `memory/work/`：卡住超過一週的專案、過期的任務、L1 太久沒更新的專案，列出來提醒。
5. 檢查 `memory/knowledge/`：有沒有和最近事件矛盾的知識。
6. 檢查 `reports/briefs/`：超過一個月的建議，對應的互動都已經 `/debrief` 過，就提議刪除。
7. 先列出所有提案，說明理由；再逐一編輯。
8. 核准後提交 git：`review: <日期> 每週整併`。
9. 最後用三五句話總結：這週對主管的理解有什麼變化。
