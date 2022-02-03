Function Get-WebsiteLinksV3
{
    [CmdletBinding()]
    PARAM 
    (
        [parameter(Mandatory=$true,
        ParameterSetName= "Website URL")]
        $WEBURL,

        [Switch]
        $https,

        [Switch]
        $http
    )

    PROCESS
    {
        $Webpage = (Invoke-WebRequest $WEBURL)
        
        $AllLinks = $Webpage.Links.Href | Where-Object {$_ -like "http*"}
        $HTTPS = $AllLinks | Where-Object {$_ -like "https:*"}
        $HTTP = $AllLinks | Where-Object {$_ -like "http:*"}

        foreach ($Link in $AllLinks)
        {
        
            $Obj = New-Object -TypeName PSCustomObject -Property @{
                HTTPS = $SL
                HTTP = $USL
            }
        }
         
    }

    END
    {
        if($https.IsPresent)
        {
            Write-Host $SL
        }
        elseif($http.IsPresent)
        {
            Write-Host $obj | Select-Object $_.HTTP
        }
        else
        {
            ForEach-Object { Write-Host -Object $Obj -Separator ',' } 
        }
    }

}


#Testing
Get-WebsiteLinksV3 -WEBURL www.twitch.tv