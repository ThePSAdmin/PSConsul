$script:ModuleName = "PSConsul"
$script:Source = "$BuildRoot\src"
$script:Output = "$BuildRoot\output\$ModuleName"
$script:ModuleFile = "$Output\$ModuleName.psm1"
$script:ModuleManifest = "$Output\$ModuleName.psd1"

Import-Module Configuration 
Task . Build

Task Clean {
    Remove-Item $BuildRoot\Output -Recurse -Force -ErrorAction SilentlyContinue
}

Task Build Clean, {

    New-Item $script:Output -ItemType Directory -Force
    New-Item $script:ModuleFile -ItemType File -Force
    $nonExported = @(
        "$script:Source\Classes\*.ps1",
        "$script:Source\private\*.ps1"
    )
    $files = Get-ChildItem -Path $nonExported

    foreach ($file in $files) {
        Get-Content $file.FullName | Add-Content -Path $script:ModuleFile -force                
    }
    
    $exported = "$script:Source\Public\*.ps1"
    
    $files = Get-ChildItem -Path $exported

    Copy-Item -Path "$script:Source\$script:ModuleName.psd1" -Destination $script:ModuleManifest
 
    $ExportedFunctions = @()
    foreach ($file in $files) {
        Get-Content $file.FullName | Add-Content -Path $script:ModuleFile -force                
        $parsedFile = [System.Management.Automation.Language.Parser]::ParseFile($file.FullName, [ref]$null, [ref]$null)
        $ExportedFunctions += $parsedFile.FindAll({
            $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst]
        }, $false) | Select-Object -ExpandProperty Name
    }

    Update-MetaData -Path $script:ModuleManifest -PropertyName FunctionsToExport -Value $ExportedFunctions

}

Task BumpModuleVersion {
    
}