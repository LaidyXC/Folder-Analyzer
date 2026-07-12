Clear-Host

Write-Host @"
 ________  ________     ___      ___    _____        ________     
|\  _____\|\   __  \   |\  \    /  /|  / __  \      |\   __  \    
\ \  \__/ \ \  \|\  \  \ \  \  /  / / |\/_|\  \     \ \  \|\  \   
 \ \   __\ \ \   __  \  \ \  \/  / /  \|/ \ \  \     \ \  \\\  \  
  \ \  \_|  \ \  \ \  \  \ \    / /        \ \  \  ___\ \  \\\  \ 
   \ \__\    \ \__\ \__\  \ \__/ /          \ \__\|\__\\ \_______\
    \|__|     \|__|\|__|   \|__|/            \|__|\|__| \|_______|
                                                                     
                                                                                                                                               
"@ -ForegroundColor DarkRed
Write-Host ""
Write-Host "Folder Analyzer V1.0" -ForegroundColor DarkGreen
Write-Host "-made by LaidyXC" -ForegroundColor Gray

$aValue = Read-Host "Enter File path"


if (Test-Path $aValue) {
    Write-Host "$aValue exists"  

}
else {
    Write-Host "$aValue does not exist"
    $pathVerified = $false
    do { 
        $path = Read-Host "Please Re-enter File path"
        Write-Host "$path does not exist"
        if (Test-Path $path) {
            $pathVerified = $true
            $aValue = $path
        }
    } while ($pathVerified -eq $false)
} Write-Host ""    
Write-Host "             20 Largest files"
Write-Host "                      |"
Write-Host "                      v"
 $files = Get-ChildItem $aValue -Recurse -File -ErrorAction SilentlyContinue
    $files | 
    Sort-Object Length -Descending |
    Select-Object -First 20 |
    Select-Object Name, @{
    Name = "Size"
   Expression = {
    if ($_.Length -ge 1GB) {
       ([math]::Round($_.Length / 1GB, 1)).ToString() + " GB"
    }
    elseif ($_.Length -ge 1MB) {
        ([math]::Round($_.Length / 1MB, 1)).ToString() + " MB"
    }
    elseif ($_.Length -ge 1KB) {
        ([math]::Round($_.Length / 1KB, 1)).ToString() + " KB"
    }
    else {
        $_.Length.ToString() + " Bytes"
     }
    }
}, @{
        Name = "Creation-Date"
        Expression = {
        $_.CreationTime
    }
    
} | Format-Table -AutoSize


Write-Host ""
$TotalSize = $files | Measure-Object -Property Length -Sum    
$Bytes = $TotalSize.Sum
    if ($Bytes -ge 1GB) { 
        $Calc = ([math]::Round($Bytes / 1GB, 1)).ToString() + " GB"
    }
    elseif ($Bytes -ge 1MB) {
        $Calc = ([math]::Round($Bytes / 1MB, 1)).ToString() + " MB"
    }
    elseif ($bytes -ge 1KB) {
        $Calc = ([math]::Round($Bytes / 1KB, 1)).ToString() + " KB"
    }
    else {
        $Calc = $Bytes.ToString() + " Bytes"
    }
    Write-Host "Summery:"
    Write-Host ""
    Write-Host "File Amount: $($Files.count)"
    Write-Host  "Total Size: $Calc"

    $Exit = Read-Host "Press Enter to exit"