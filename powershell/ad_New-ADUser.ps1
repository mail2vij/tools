
# ad_New-ADUser
#   The goal of this script is to take only the `SamAccountName` in the format of `firstname.lastname` and infer all other values

#Import-Module ActiveDirectory

#$AD_Creds = Get-Credential

#Get-ADUser -Filter * -SearchBase "OU=Users,OU=demo,DC=DEMO,DC=COM" | FT SamAccountName -A

Start-Transcript ($MyInvocation.MyCommand.Source + ".log") # -Append

$AD_DOMAIN = "demo.com"
$MAIL_DOMAIN = "mail.demo.com"
# the following is to turn `demo.com` into `DC=DEMO,DC=COM`
$AD_DC_PATH = ("DC=" + $AD_DOMAIN).ToUpper().Split(".")
$AD_DC_PATH = $AD_DC_PATH -join ",DC="
Write-Host $AD_DC_PATH # DC=DEMO,DC=COM

$AD_USER_OU_PATH_ADDRESS = "OU=Users,OU=demo," + $AD_DC_PATH
Write-Host $AD_USER_OU_PATH_ADDRESS

# TODO: get this from a file, loop:
$new_SamAccountName = "firstName.TESTName".ToLower()


# split SamAccountName into FirstName LastName and force first character to uppercase
$pos = $new_SamAccountName.IndexOf(".")
# https://stackoverflow.com/questions/22694582/capitalize-the-first-letter-of-each-word-in-a-filename-with-powershell 
$FirstName = (Get-Culture).TextInfo.ToTitleCase( $new_SamAccountName.Substring(0, $pos) )
$LastName = (Get-Culture).TextInfo.ToTitleCase( $new_SamAccountName.Substring($pos+1) )
$FullName = $FirstName + " " + $LastName

$UserPrincipalName = $new_SamAccountName + "@" + $AD_DOMAIN
$UserEmailAddress = $new_SamAccountName + "@" + $MAIL_DOMAIN

Write-Host $new_SamAccountName
Write-Host $FullName
Write-Host $UserPrincipalName
Write-Host $UserEmailAddress

# New-ADUser -Name $FullName -GivenName $FirstName -Surname $LastName -SamAccountName $new_SamAccountName -EmailAddress $UserEmailAddress -UserPrincipalName $UserPrincipalName -Path $AD_USER_OU_PATH_ADDRESS -AccountPassword(Read-Host -AsSecureString "Input Password") -Enabled $True -ChangePasswordAtLogon $False -PassThru

Stop-Transcript

# References:
# - https://blog.netwrix.com/2018/06/07/how-to-create-new-active-directory-users-with-powershell/ 
# - https://docs.microsoft.com/en-us/powershell/module/addsadministration/new-aduser?view=win10-ps 
# - https://stackoverflow.com/questions/22694582/capitalize-the-first-letter-of-each-word-in-a-filename-with-powershell 
