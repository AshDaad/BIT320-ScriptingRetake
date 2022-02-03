Assignment:

Create a script that notifies users via email (using your gmail account) when their domain password is about to expire starting at day 10.  
Days 10-6 should use the same language each day just changing how many days are left until it expires.  Days 5-2 should have more urgent language, and Day 1 should let them know time has run out and they need to do it now!!.  

You will need to setup small Server 2012 DC as a VM on your laptop.

Use GPO's to adjust the maximum time a password is valid (to simulate days 6-1)

$msg = new-object Net.Mail.MailMessage

$SMTP.Credentials = Nre-Object System.Net.NetworkCredential("$email", "$pass")
$smtp.Send($msg)
