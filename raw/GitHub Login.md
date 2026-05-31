# GitHub CLI Login - Powerfleet Enterprise

Authenticate `gh` CLI with Powerfleet's GitHub Enterprise instance.

## GitHub Enterprise Login

```powershell
gh auth login --hostname powerfleet.ghe.com
```

When prompted:
1. **Preferred protocol for Git operations:** HTTPS
2. **Authenticate Git with your GitHub credentials:** Yes
3. **How to authenticate GitHub CLI:** Login with a web browser

## Steps

1. Copy the one-time code shown (e.g. `2259-6573`)
2. Press Enter to open `https://powerfleet.ghe.com/login/device` in your browser
3. Paste the code and authorize
4. On completion, `gh` configures HTTPS git protocol and logs you in as `marthinus-raath`

## Verify

```powershell
gh auth status --hostname powerfleet.ghe.com
```

## Notes
- Username: `marthinus-raath`
- Host: `powerfleet.ghe.com`
- Protocol: HTTPS
- Token stored in gh CLI keyring (not in files)

## Under Personal Access
Previous (personal) account: `mraath` on `github.com`
