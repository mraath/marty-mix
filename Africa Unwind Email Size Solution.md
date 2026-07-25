---
tags:
  - email
  - africa-unwind
  - reference
created: 2026-07-24T00:00
updated: 2026-07-24T00:00
---

# Africa Unwind Email Size Solution

Problem: my wife has ~5 years of Africa Unwind company email piled up — big on the mailbox (Outlook/Exchange quota) and, where it's also synced into Thunderbird locally (`mail.africaunwind-1.com`, `mail.africaunwind-2.com`), big on local disk too (`africaunwind-2` alone was 4.2 GB in a 2026-07-23 scan, see [[HDD Cleanup 2026-07]] if that note exists, otherwise the SDLC project memory). Goal: get old mail off the live mailbox / off the machine, but keep it backed up and accessible somewhere safe.

Two options discussed, not mutually exclusive — could do A now (quick, native) and B later (better long-term format).

## ⚠️ Before doing anything: check company policy

Africa Unwind may have retention/legal-hold requirements on business email (compliance, e-discovery). Moving mail out of the live mailbox into a local-only archive, or deleting it outright, can conflict with that even though Outlook/Exchange lets you do it technically. **Check with whoever handles IT/compliance for the company before archiving or deleting 5 years of business mail at scale.**

Also: Exchange doesn't delete instantly. Deleted items sit in **Recoverable Items** for ~14–30 days (longer if a legal hold is active) before a real, permanent purge. Don't assume "deleted from Outlook" means "gone from Microsoft's backend" the same day.

---

## Option A — Outlook AutoArchive → local .pst (quick, native, no scripting)

Keeps old mail off the live mailbox (frees Outlook/Exchange quota) but still fully browsable in Outlook via a separate local data file.

1. Outlook → File → Options → Advanced → **AutoArchive Settings** (or right-click a folder → Properties → AutoArchive tab for per-folder rules)
2. Set "Clean out items older than X months/years" → "Move old items to" → a local path, e.g. `Archive-AfricaUnwind.pst`
3. Run it (or let the schedule run) — old mail moves out of the live mailbox into the local `.pst`, which Outlook auto-mounts as an "Archive" data file — still searchable/readable in Outlook, no longer synced to the server.

Manual one-shot alternative (same result, immediate): File → Open & Export → Import/Export → **Export to a file** → Outlook Data File (.pst) → pick folders → save locally.

**Backing up the resulting .pst:** treat it like any important file — copy to an external drive + cloud storage (3-2-1 rule: multiple copies, not all on one disk). PST files can corrupt on improper shutdown or at large size — periodically run Microsoft's `SCANPST.EXE` (ships with Office, under `Program Files\Microsoft Office\root\OfficeXX`) to check integrity. Keep Outlook closed while copying the file elsewhere so you don't copy a locked/mid-write file.

---

## Option B — Full export to Markdown + attachments (future-proof, greppable, no PST corruption risk)

No native Outlook feature does this — needs a script using Outlook's COM automation. **Requires classic desktop Outlook** on the machine doing the export (the new Outlook / web-only client doesn't support COM automation).

```powershell
param(
    [string]$OutlookFolderPath = "Inbox",       # e.g. "Inbox\Archive\2020"
    [string]$BackupRoot        = "D:\EmailBackup"
)

$outlook   = New-Object -ComObject Outlook.Application
$namespace = $outlook.GetNamespace("MAPI")

function Get-FolderByPath($ns, $path) {
    $parts  = $path -split '\\'
    $folder = $ns.Folders.Item(1)          # first account/store — adjust index if multiple
    foreach ($p in $parts) { $folder = $folder.Folders.Item($p) }
    return $folder
}

function Sanitize-FileName($name) {
    $invalid = [IO.Path]::GetInvalidFileNameChars() -join ''
    $pattern = "[{0}]" -f [Regex]::Escape($invalid)
    $clean = ($name -replace $pattern, '_')
    $clean.Substring(0, [Math]::Min(120, $clean.Length))
}

function Export-MailItem($item, $destFolder) {
    $date        = $item.ReceivedTime.ToString("yyyy-MM-dd_HHmmss")
    $subjectSafe = Sanitize-FileName($item.Subject)
    $baseName    = "${date}_$subjectSafe"
    $mdPath      = Join-Path $destFolder "$baseName.md"
    $attDirName  = "${baseName}_attachments"
    $attDir      = Join-Path $destFolder $attDirName

    $attLinks = @()
    if ($item.Attachments.Count -gt 0) {
        New-Item -ItemType Directory -Path $attDir -Force | Out-Null
        foreach ($att in $item.Attachments) {
            $attName = Sanitize-FileName($att.FileName)
            $att.SaveAsFile((Join-Path $attDir $attName))
            $attLinks += "- [$attName]($attDirName/$attName)"
        }
    }

    $md = @"
---
from: $($item.SenderName)
to: $($item.To)
cc: $($item.CC)
date: $($item.ReceivedTime)
subject: $($item.Subject)
---

$($item.Body)

## Attachments
$($attLinks -join "`n")
"@
    Set-Content -Path $mdPath -Value $md -Encoding UTF8
}

$folder = Get-FolderByPath $namespace $OutlookFolderPath
New-Item -ItemType Directory -Path $BackupRoot -Force | Out-Null

$count = 0
foreach ($item in @($folder.Items)) {
    if ($item.Class -eq 43) {   # olMail
        Export-MailItem $item $BackupRoot
        $count++
        if ($count % 50 -eq 0) { Write-Host "$count exported..." }
    }
}
Write-Host "Done. $count emails exported to $BackupRoot"
```

Run once per folder to archive (`-OutlookFolderPath "Inbox\2020"` etc.), pointed at an external drive or a folder that gets synced elsewhere for `-BackupRoot`. For 5 years of company mail this will take a while, and Outlook/antivirus may pop a security prompt on repeated programmatic access — run it in a visible PowerShell window so prompts can be approved, not headless/unattended.

**Before deleting anything: spot-check a handful of the generated `.md` files and confirm attachments actually saved and open correctly.** Don't proceed on faith that the export worked.

### Deleting after export

- **Local:** once spot-checked and copied to at least one more backup location (not just one folder on one drive) — delete the exported items from Outlook (Shift+Delete to skip Deleted Items, or delete then empty Deleted Items). Local `.ost` cache shrinks after the next sync (Cached Exchange Mode).
- **Online:** against Exchange/M365 there's no separate "local-only" mailbox — deleting the item deletes it from both simultaneously. Emptying Deleted Items starts the Recoverable Items countdown mentioned above. This is exactly why the compliance check above needs to happen *before* this step, not after.

---

## Decision status

Not yet decided/started as of 2026-07-24 — this note captures the options discussed so the plan doesn't need re-deriving from scratch later. Revisit once she's checked Africa Unwind's retention policy.
