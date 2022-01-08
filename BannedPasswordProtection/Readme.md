# Azure AD banned Password Protection Scripts

This repository contains various scripts for penetration testers and red teams. Its a work in progress. 

## BadPass.ps1
Usage: This script can be ran against a wordlist to test weak passwords with Azure AD Banned Password Protection turned on in a on prim Active Directory tenant. This is useful for penetration testers and red teams when evaluating password security on low and slow password spray approaches on valid active directory user accounts.  Make sure you run this in a elevated administrative PowerShell session. RSAT tools and password reset capability is required. 

**Active Directory Configuration:**

Password History Minumum and Maximum age should be disabled or not configured. In a Server 2022 AD Domain the default password length is 7 characters.

Insert Screenshot
  
**Banned Password Configuration**



**Software and Domain Requirements:**

Active Directory Domain controller 

Azure Active Directory Connect syncing user accounts to Azure

Azure AD Password Proctection DC Agent

Azure AD Password Protection Proxy

End user account licensed with Azure AD Premium P1 or P2

Windows 10 Workstation or newer with RSAT tools installed.

**Mandatory Arguments and Usage:**
-File

-User

-User requires a samaccountname user id. 

```
Import-Module C:\Users\userid\BadPass.ps1
Invoke-BadPass -File Wordlist.txt -user userid
```
**Troubleshooting:**

Issue: Access is Denied message when spraying different passwords at a user account. 

Solution: Run PowerShell in administrative mode. Verify you can reset the target password manually. Sometimes you may need to wait a few minutes before you run Set-ADAccountPassword. 

Issue: 

I need to output success and failures to a text file.

Solution: 

Before running Invoke-BadPass, run Start-Transcript -Path C:\Path\to\file.txt. 

Make sure to run a stop-transcript when finished. 
