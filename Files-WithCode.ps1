Function Files-WithCode {
    Param(
        [Parameter(Mandatory=$true)][string]$path
        , [Parameter(Mandatory=$true)][string]$code
    )
    Process
    {
        $gcipath = Get-ChildItem -Path $path -Filter *.sql -Recurse 

        foreach ($file in $gcipath)
        {
            $full = Get-Content $file.FullName
            [string]$full = $full.ToString().ToLower()

            if ($full -like "*$code*")
            {
                $file.FullName
            }
        }
    }
}


Files-WithCode -path "" -code ""
