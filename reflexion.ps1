$gpkernel = [appdomain]::currentdomain.GetAssemblies() | where { $_ -and $_.Location -and $_.Location.Contains("gpkernel") }
$gpkernel.GetExportedTypes() | % { $_.FullName }
$app = New-Object [ArobasMusic.GuitarPro.GPApplicationWrapper] 

Register-ObjectEvent -InputObject $app.StartEvent -EventName Executing -Action { Write-Host "<StartEvent>" }