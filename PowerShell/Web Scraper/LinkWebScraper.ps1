Function Get-WebsiteLinks
{
    [CmdletBinding()]  
    Param
    (
        [parameter(Mandatory=$true,
        ParameterSetName= "Website URL")]
        $WEBURL,

        [Switch]
        $https,

        [Switch]
        $http
    )

    (Invoke-WebRequest $WEBURL).Links.Href | Where-Object {$_ -like "http*"}

    New-Object -TypeName PSobject -ArgumentList $WEBURL

}