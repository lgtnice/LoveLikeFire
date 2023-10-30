Param(
    [string]$PublishDir = '.\..\publish'
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition


$PublishDir = Join-Path -Path $ScriptDir -ChildPath $PublishDir
New-Item -ItemType Directory -Force -Path $PublishDir
$PublishDir = Resolve-Path $PublishDir


$OutputDir = Join-Path -Path $ScriptDir -ChildPath '.\..\src\MainWPF\bin\x64\Release'
$OutputDir = Resolve-Path $OutputDir

Copy-Item -Path $OutputDir\* -Destination $PublishDir -Recurse -Force
