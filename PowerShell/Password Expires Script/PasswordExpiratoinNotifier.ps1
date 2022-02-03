Import-Module ActiveDirectory
Import-Module GroupPolicy



$SMTPServer = "smtp.gmail.com"
$SMTPPort = "587"
$Username = "XXX@gmail.com"
$Password = "XXXXXXXXX"
$Output = @()
$maxPasswordAgeTimeSpan = (Get-ADDefaultDomainPasswordPolicy).MaxPasswordAge

Write-Output $maxPasswordAgeTimeSpan


$subject = "Password Expirery Notice!"


$Users= Get-ADUser -filter "(Mail -like '*@*') -AND (PasswordNeverExpires -eq '$false' -AND Enabled -eq '$true')" �Properties DisplayName, msDS-UserPasswordExpiryTimeComputed, mail,samaccountname,GivenName,Surname 


Foreach ($user in $Users)
{
    
    $expirydate = [datetime]::FromFileTime($user.'msDS-UserPasswordExpiryTimeComputed')
    $daysleft = ($expirydate - (Get-Date))
    $days = $daysleft.days

    # Write-Output "Expiration date: $expirydate"
    # Write-Output "Max Password Age Timespan: $maxPasswordAgeTimeSpan"
    # Write-Output "Days left till expiration: $daysleft"

    if($daysleft -le $maxPasswordAgeTimeSpan -and $days -gt 0)
    {

        $to = $user.mail

        $body10to6days = "Dear $($user.DisplayName)
        Your password is expiring in $days days.
            Change it as soon as possible"

        $body5to2days = "Dear $($user.DisplayName)
        Your password is expiring in $days Days.
        You need to change this now, don't wait"

        $body1day = "Dear $($user.DisplayName)
        You have $days Day Left.
        Why have you not done this yet?"


        switch($days)
        {
            10 {$body = $body10to6days}
            9  {$body = $body10to6days}
            8  {$body = $body10to6days}
            7  {$body = $body10to6days}
            6  {$body = $body10to6days}
            5  {$body = $body5to2days}
            4  {$body = $body5to2days}
            3  {$body = $body5to2days}
            2  {$body = $body5to2days}
            1  {$body = $body1day}
        }

        $message = New-Object System.Net.Mail.MailMessage
        $message.subject = $subject
        $message.body = $body
        $message.to.add($to)
        $message.from = $username

    
        $smtp = New-Object System.Net.Mail.SmtpClient($SMTPServer, $SMTPPort);
        $smtp.EnableSSL = $true
        $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
        $smtp.send($message)

        # Write-Output "User: $($user.DisplayName) "
        # Write-Output "Email:"
        # Write-Output $message
    }
}

write-host "End Script"