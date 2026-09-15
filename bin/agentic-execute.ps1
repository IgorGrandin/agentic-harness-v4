[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][string]$SourcePath,
    [string]$ProjectRoot=(Get-Location).Path,
    [string[]]$RequiredGuarantees=@(),
    [switch]$AsJson
)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
$project=[IO.Path]::GetFullPath($ProjectRoot)
if(-not(Test-Path -LiteralPath $project -PathType Container)){throw "ProjectRoot not found: $project"}
$source=[IO.Path]::GetFullPath((Join-Path $project $SourcePath))
$prefix=$project.TrimEnd('\','/')+[IO.Path]::DirectorySeparatorChar
if(-not $source.StartsWith($prefix,[StringComparison]::OrdinalIgnoreCase)){throw 'SourcePath escapes ProjectRoot'}
if(-not(Test-Path -LiteralPath $source -PathType Leaf)){throw "Execute source not found: $source"}
$overlay=[ordered]@{schemaVersion=1;kind='constraints-overlay';active=$true;sourcePath=$source;projectRoot=$project;requiredGuarantees=@($RequiredGuarantees);root='host-selected';kernel='v4-single';authorizationBoundaries=@('source is authoritative','same base harness','no automatic commit')}
if($AsJson){$overlay|ConvertTo-Json -Compress}else{$overlay}
