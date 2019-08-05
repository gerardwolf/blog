#####################################################
# Creates a new AAD Application and Service Principal
#####################################################

# Sign in as a user that is allowed to create an app.
Connect-AzureAD

# Set variable values
$DisplayName = "<yourDisplayName>"
$Homepage = "<yourUrl>"
$ReplyUrls = "<yourUrl>"

# Create a new AAD web application
$app = New-AzureADApplication -DisplayName $DisplayName -Homepage $Homepage -ReplyUrls $ReplyUrls

# Creates a service principal and displays the Application Id
$sp = New-AzureADServicePrincipal -AppId $app.AppId
Write-Host ("`nService Principal Application Id = " + $app.AppId)

# Get the service principal key
$key = New-AzureADServicePrincipalPasswordCredential -ObjectId $sp.ObjectId

#Display principal object id
Write-Host ("`nService Principal Object Id = " + $sp.ObjectId)

# Display principal key
Write-Host ("Service Principal Key = " + $key.value)

# Display tenant info
$tenantId = Get-AzureADTenantDetail
Write-Host ("Tenant Id = " + $tenantId.ObjectId + "`n")
