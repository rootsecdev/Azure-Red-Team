# Install the AzureAD PowerShell module
Install-Module AzureAD
# Authenticate to the tenant
$username = "username@domain.com"
$password = 'YourVeryStrongPassword'
$SecurePassword = ConvertTo-SecureString “$password” -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential($username, $SecurePassword)
Connect-AzureAD -Credential $Credential
# Build our users and roles object
$UserRoles = Get-AzureADDirectoryRole | ForEach-Object {
        
    $Role = $_
    $RoleDisplayName = $_.DisplayName
        
    $RoleMembers = Get-AzureADDirectoryRoleMember -ObjectID $Role.ObjectID
        
    ForEach ($Member in $RoleMembers) {
    $RoleMembership = [PSCustomObject]@{
            MemberName      = $Member.DisplayName
            MemberID        = $Member.ObjectID
            MemberOnPremID  = $Member.OnPremisesSecurityIdentifier
            MemberUPN       = $Member.UserPrincipalName
            MemberType      = $Member.ObjectType
            RoleID          = $Role.RoleTemplateId
            RoleDisplayName = $RoleDisplayName
     }
        
        $RoleMembership
        
    }    
}
$UserRoles | ?{$_.MemberType -eq "ServicePrincipal"}
