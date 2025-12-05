---
created: 2025-11-24T09:34
updated: 2025-11-24T09:34
---

I can finally pull repos.... this line in the terminal did it for me.... if you ever get to a certificate issue.... I THINK mine started after upgrading VS - but not sure...

```cmd
git config --global http.sslBackend schannel
```

This forces git to use my windows certificates - as I could reach the repo via browser
