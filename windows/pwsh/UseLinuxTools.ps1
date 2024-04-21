function EnableLinuxTools{
    $path=$ENV:PATH -split ';'
    $path=$path | Where-Object { $_ }
    $ENV:PATH=$path -join ';'
    if ($path.IndexOf("D:\Software\Git\usr\bin") -eq -1) {
        $ENV:PATH+=";D:\Software\Git\usr\bin"
    }
}

function DisableLinuxTools{
    $str=$ENV:PATH
    $str=$str -split ';'
    $str=$str | Where-Object { $_ -and ! ($_ -eq "D:\Software\Git\usr\bin") }
    $ENV:PATH=$str -join ';'
}
Set-Alias -Name "elt" -Value "EnableLinuxTools"
Set-Alias -Name "dlt" -Value "DisableLinuxTools"
