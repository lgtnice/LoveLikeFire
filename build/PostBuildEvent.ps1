Param(
    [string]$ProjectName = "",
    [string]$OutDir = "",
    [string]$Platform = "",
    [string]$Configuration = ""
)

if ($ProjectName -eq "MainWPF")
{
    $srcDir = Join-Path -Path $PSSCRIPTROOT -ChildPath ".\..\src\ShowPages\"
    $srcDir = Resolve-Path $srcDir

    $showPagesDir = Join-Path -Path $OutDir -ChildPath "ShowPages"
    if (Test-Path -Path $showPagesDir) {
        Remove-Item -Path $showPagesDir -Recurse -Force
    }

    Copy-Item -Path $srcDir -Destination $OutDir -Recurse -Force
}