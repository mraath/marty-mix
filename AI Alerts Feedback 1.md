---
created: 2025-04-04T11:09
updated: 2025-04-04T11:12
---
==I seemed to have fixed this myself== and checked in the files. NOW I am busy looking at the differences. There are a few. I think the best would be to go function by function and try to fix or resolve the differences. For now the most important two would be the two main alert ones. However, I am not sure if the original or refactored ones are correct. I will take one at a time... LEts start with the first Alerts one, having to do with messages

API Request

$0.0000

Okay, great that you got the comparison script working and have checked in the refactored files. It's common to find subtle differences after a complex refactoring like this. Analyzing them function by function is a good approach.

Let's start with the message-related alerts (the first two digits of the `Alerts` code), which correspond to the logic now encapsulated in `[state].[udfGetMobileUnitMessageAlerts]`.

**Refactored Logic (`udfGetMobileUnitMessageAlerts`):**

1. **Identify Relevant Messages:** It looks for the latest message (`ROW_NUMBER() OVER (PARTITION BY mum.MessageSubType ORDER BY mum.CreationDateUtc DESC) as RowNum = 1`) for the specific `@MobileUnitId` where the `MessageSubType` is one of `254` (SendConfig), `103` (SendFirmware), or `255` (SendSettings).
2. **Check Config/Settings Outdated (Alert 1):** It checks if the latest message of type `254` or `255` has a `MessageStatus` of `22` (Created) or `23` (SentAwaitingResponse) **AND** its `CreationDateUtc` is older than 5 days (`< DATEADD(day, -5, GETUTCDATE())`). If true, this alert is '1', otherwise '0'.
3. **Check Firmware Outdated (Alert 2):** It checks if the latest message of type `103` has a `MessageStatus` of `22` or `23` **AND** its `CreationDateUtc` is older than 3 days (`< DATEADD(day, -3, GETUTCDATE())`). If true, this alert is '1', otherwise '0'.
4. **Combine:** It concatenates the results of steps 2 and 3 to form the two-digit `MessageAlertCode` (e.g., '00', '10', '01', '11').

**Potential Differences & Areas to Investigate:**

1. **`GETDATE()` vs `GETUTCDATE()`:** The original SP used `GETDATE()`, while the refactored function uses `GETUTCDATE()`. If your `CreationDateUtc` column is truly UTC, then `GETUTCDATE()` is correct. If `CreationDateUtc` is actually storing local time despite its name, or if the server's local time differs significantly from UTC, this could cause discrepancies in the date comparisons. **Which function is appropriate depends on how `CreationDateUtc` is populated and the server's time zone.**
2. **Missing `MessageStatus` Check in Original:** The original logic that populates `@messageStatuses` **does not** seem to filter by `MessageStatus IN (22, 23)`. It only checks the date. The refactored function _does_ include this status check. This is a significant difference. If a message is old but has already completed (e.g., status 'Acknowledged'), the original logic might flag it as an alert, while the refactored function would not. **Which behavior is correct?**
3. **Handling of No Messages:** The refactored function explicitly handles cases where no relevant messages exist for a MobileUnitId (using `LEFT JOIN OutdatedMessages om ON 1=1` and `ISNULL` in the final `CONCAT`). The original logic relies on the `LEFT JOIN @alertByAssets aa` in the final select and the `CASE WHEN ISNULL(aa.Alerts,'') = '' THEN '00' ...` to produce '00' if no matching rows were inserted into `@messageStatuses`. This _should_ result in the same outcome but is structured differently.

To pinpoint the issue, could you:

- Confirm if `state.MobileUnitMessage.CreationDateUtc` stores UTC time or local time?
- Verify if the alert should only trigger for messages with status 22 or 23?
- Provide an example `MobileUnitId` where the first two digits of the `Alerts` code differ between the original and refactored procedures, along with the differing alert codes? Knowing the specific difference (e.g., original is '10', refactored is '00') would be very helpful.

Let's analyze the message alert logic based on this information.

- ==I will get back to you about the date==, however, I do think it is UTC - The alert statusses... 22, 23.... I think there were two sections... the first just gets ALL messages in the last few days... and THEN I look for those: 22, 23... however, I think I might have to check for even more. I will give you the list in a bit. - Examples: 1096950484704075776, 1360022093041086464, 1519091697465741312

API Request

$0.0000

Okay, thanks for the feedback and the example MobileUnitIds.

- **Date:** We'll proceed assuming `GETUTCDATE()` is correct for now. If it turns out `CreationDateUtc` isn't true UTC, we can adjust later.
- **Status Codes:** That makes sense. It seems my initial analysis was correct – the original procedure's logic for populating `@messageStatuses` was missing the filter for specific message statuses (like 22, 23), only checking the date. The refactored function `udfGetMobileUnitMessageAlerts` _does_ include a status check (`MessageStatus IN (22, 23)`). This difference in filtering is almost certainly the cause of the discrepancies you're seeing for the message alerts (the first two digits).

I will wait for you to provide the definitive list of `MessageStatus` values that should trigger the Config/Settings alert (currently checking `22, 23` and older than 5 days) and the Firmware alert (currently checking `22, 23` and older than 3 days).

Once you provide that list, I can update the `udfGetMobileUnitMessageAlerts` function. After updating, you can re-run the comparison test, focusing on those example MobileUnitIds, to see if the message alert differences are resolved.

==OK, I will give you the full list later==. I think, lets first get the current results to look the same, else we change too many things. SO for now, the first part of the messages must be like the old one, only look for all messages older... etc.... THEN later look for the status. Will that make a difference?

API Request

$0.0000

Okay, I understand. You want to temporarily modify the `udfGetMobileUnitMessageAlerts` function to exactly mirror the original logic's behavior (checking only the message age, not the status) to see if that aligns the results for the first two alert digits. Then, once confirmed, we can re-introduce the correct status filtering later.

Yes, removing the `MessageStatus IN (22, 23)` check from the function will make it behave like the original logic's intermediate step (`INSERT INTO @messageStatuses`). This should resolve the discrepancies you're seeing in the first two digits of the `Alerts` code between the original and refactored outputs.

Here is the modified code for `[state].[udfGetMobileUnitMessageAlerts]` with the status checks removed:

I COPIED THE CODE into the function....

