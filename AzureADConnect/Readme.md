# Decrypting MSOL Password from Azure AD Connect Servers

Note: This is a small and very minor modification to the work @xpn did in his blog:

https://blog.xpnsec.com/azuread-connect-for-redteam/

His orinal POC Can be found here:

https://gist.github.com/xpn/f12b145dba16c2eebdd1c6829267b90c


So why is @rootsecdev making another POC? Interesting and fun story.... Azure AD Connect 1.x will be retired by Microsoft on 8/22. If this is news to you then feel free to review the Azure AD Connect history logs: https://docs.microsoft.com/en-us/azure/active-directory/hybrid/reference-connect-version-history#retiring-azure-ad-connect-1x-versions


So what does this slightly new version do? Well it decrypts the MSOL password running on any server version running azure ad connect 2.x. So if you find yourself on a Azure AD connect server with administrative rights. You should be able to run this powershell script interactively and decrypt the password. Defender AV is totally cool with it. 

