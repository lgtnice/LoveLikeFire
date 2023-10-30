Param(
    [string]$PublishDir = '.\..\publish'
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$ProjConfigFilePath = Join-Path -Path $ScriptDir -ChildPath ".\..\src\MainWPF\MainWPF.csproj"
$ProjConfigFilePath = Resolve-Path $ProjConfigFilePath

$PublishDir = Join-Path -Path $ScriptDir -ChildPath $PublishDir
New-Item -ItemType Directory -Force -Path $PublishDir
$PublishDir = Resolve-Path $PublishDir

$ProjConfigFileDir = Split-Path -Parent $ProjConfigFilePath
Set-Location $ProjConfigFileDir



$net6_winx64_ConfigFile = @"
<Project>
  <PropertyGroup>
    <Configuration>Release</Configuration>
    <Platform>Any CPU</Platform>
    <PublishDir>$PublishDir</PublishDir>
    <PublishProtocol>FileSystem</PublishProtocol>
    <TargetFramework>net6.0-windows</TargetFramework>
    <RuntimeIdentifier>win-x64</RuntimeIdentifier>
    <SelfContained>true</SelfContained>
    <PublishSingleFile>false</PublishSingleFile>
    <PublishReadyToRun>false</PublishReadyToRun>
  </PropertyGroup>
</Project>
"@


Set-Content -Path "$ScriptDir\publish_net6_winx64.pubxml" -Value $net6_winx64_ConfigFile


$PostBuildScriptDir = Join-Path -Path $ScriptDir -ChildPath 'PostBuildEvent.ps1'
$PostBuildScriptDir = Resolve-Path $PostBuildScriptDir

# Reference: https://learn.microsoft.com/zh-cn/dotnet/core/tools/dotnet-publish

dotnet publish $ProjConfigFilePath -f net6.0-windows -c Release -p:PublishProfileFullPath=$ScriptDir\publish_net6_winx64.pubxml
& $PostBuildScriptDir -ProjectName 'MainWPF' -OutDir "$PublishDir" -Platform "x64" -Configuration "Release"


Remove-Item -Path "$ScriptDir\publish_net6_winx64.pubxml"
