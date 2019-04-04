$RequiredModules = @(
    @{ModuleName="Configuration"; ModuleVersion="1.3.1"},
    @{ModuleName="InvokeBuild"; ModuleVersion="5.4.6"}
)

Foreach ($module in $RequiredModules) {
    If (-not (Get-Module -FullyQualifiedName $module -ListAvailable)) {
        Install-Module -Name $module.ModuleName -MinimumVersion $Module.ModuleVersion -Force -AllowClobber -Scope 'CurrentUser' -SkipPublisherCheck
    }
}

Invoke-Build