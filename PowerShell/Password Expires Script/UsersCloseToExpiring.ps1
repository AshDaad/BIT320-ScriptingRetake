Import-Module ActiveDirectory
Import-Module GroupPolicy


$Output = @()
$Days = 10

Foreach ($ADUsers in Get-ADuser -filter {(Enabled -eq $true) -and (PasswordNeverExpires -eq $false)})
{
$ADUser = Get-ADUser -Identity $ADUsers.SAMAccountName -Properties *


$DaysToExpire = ((get-date $aduser.passwordlastset).AddDays($days) - (get-date)).Days
#Print out the days to expire and see if that is what you want.
#$DaysToExpire


$Output += New-Object PSObject -Property @{DisplayName=$ADUser.DisplayName; PasswordLastSet=$aduser.passwordlastset; DaysLeft=$DaysToExpire; EmailAddress=$ADUser.EmailAddress}
}

$Output | Out-GridView