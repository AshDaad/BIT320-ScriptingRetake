$SMTPServer = "smtp.gmail.com"
$SMTPPort = "587"
$Username = "XXX@gmail.com"
$Password = "XXXXXXXXX"  <#  <--- https://myaccount.google.com/security  #>

$to = "XXX@XXX.com"
$subject = "Powershell Mail Test"
$body = "This is a test message from your General2016 server. "
<#$attachment = ""#>

$message = New-Object System.Net.Mail.MailMessage
$message.subject = $subject
$message.body = $body
$message.to.add($to)
$message.from = $username
<#$message.attachments.add($attachment)#>

$smtp = New-Object System.Net.Mail.SmtpClient($SMTPServer, $SMTPPort);
$smtp.EnableSSL = $true
$smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
$smtp.send($message)

write-host "We Good Fam!"