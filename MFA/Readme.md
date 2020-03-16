# MFA Deployment Guidance

This area is a complete MFA deployment refrence. This repo will give reference links to Microsoft documentation as well as my notes on deployment best practices and procedures. 

**Planning a cloud-based Azure Multi-Factor Authentication deployment**

https://docs.microsoft.com/en-us/azure/active-directory/authentication/howto-mfa-getstarted

Notes: This is pretty much where to get started. Look over pre-requisites. My advice is to start with Cloud or Hybrid identity deployments. While looking at other things such as Azure MFA with radius authentication (Which is great if you are thinking on switching up you MFA provider such as RSA..etc) It will complicate your MFA roll outs. Stick with doing the basics first by providing protection your Office/M365 users out of the gate. Communication templates provided in the URL were interesting but in the Phishing landscape of things these candid emails look alot like what we deter end users from clicking on. They were unfortunately of little value to me. 

**Before you begin MFA Deployments**

Notes: Set up MFA Trusted IP's first. 

Reference URL Link: https://docs.microsoft.com/en-us/azure/active-directory/authentication/howto-mfa-mfasettings#mfa-service-settings

Steps to set up trusted IP's:

Azure Active Directory > Security > MFA > Getting started > Configure > Additional cloud-based MFA settings

**General Rollout schedule of MFA**

This is a list of prioritizing 
