. '.\..\..\..\~Script\Enable-Dsc.ps1'

Remove-Item ($outputPath = ".\..\..\..\@Template\$(Get-StreamPath)") -Recurse -Confirm:$false -Force -EA Silent

. '.\..\..\..\~Config\BizTalk.ps1'

$configParams = @{
    ConfigurationData = (Import-PowerShellDataFile '.\..\Node.psd1')
    OutputPath = $outputPath
    SetupCredential = (New-Secret -Account '*******\pinn' -Password 'Vi9021Ty')
    SetupLog = 'C:\Temp\BtsSetup.log'
    PatchLog = 'C:\Temp\BtsPatch.log'
    ConfigurationFile = ((Get-ChildItem -Path '.\Configuration.xml').FullName)
    ConfigurationLog = 'C:\Temp\BtsConfig.log'
}

BizTalk @configParams
# TODO: Merge other node roles
    
# Set-DscLocalConfigurationManager -Path $outputPath -Force -Verbose #-Computer Node1,Node2 #PUSH
# Start-DscConfiguration -Path $outputPath -Force -Wait -Verbose #-Computer Node1,Node2 #PUSH
# Get-DscConfigurationStatus | select -ExpandProperty ResourcesNotInDesiredState # On each node use this command to check status of DSC
# Get-ChildItem Env:GIT_* # To find where configuration came from
