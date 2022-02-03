Function Get-WebsiteLinks
{
    [CmdletBinding()]
    PARAM 
    (
        [parameter(Mandatory=$true,
        ParameterSetName= "Website URL")]
        $URL,

        [Switch]
        $https,

        [Switch]
        $http
    )

    PROCESS
    {
        $Webpage = (Invoke-WebRequest -uri $URL)
        
        $AllLinks = $Webpage.Links.Href | Where-Object {$_ -like "http*"}


        foreach ($Link in $AllLinks)
        {
            $HTTPSCol = $AllLinks | Where-Object {$_ -like "https:*"}
            
        }

        foreach ($link in $AllLinks)
        {
            $HTTPCol = $AllLinks | Where-Object {$_ -like "http:*"}
        }

        $Properties  = @{  
            HTTPSLINKS = $HTTPSCol
            HTTPLINKS = $HTTPCol
        }

    }

    END
    {
        if($https.IsPresent)
        {
            New-object -TypeName PSObject -Property $Properties | select HTTPSLINKS | Format-Table -Wrap 
        }
        elseif($http.IsPresent)
        {
            New-object -TypeName PSObject -Property $Properties | select HTTPLINKS | Format-Table -Wrap 
        }
        else
        {
            New-object -TypeName PSObject -Property $Properties | Format-Table -Wrap -GroupBy Properties
        }
    }

}


#Testing
echo "Get-WebsiteLinksV2 -URL www.twitch.tv -https"
Get-WebsiteLinksV2 -URL www.twitch.tv -https
echo "Get-WebsiteLinksV2 -URL www.twitch.tv -http"
Get-WebsiteLinksV2 -URL www.twitch.tv -http
echo "Get-WebsiteLinksV2 -URL www.twitch.tv"
Get-WebsiteLinksV2 -URL www.twitch.tv



