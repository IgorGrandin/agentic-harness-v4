[CmdletBinding(SupportsShouldProcess=$true)] param([ValidateSet('All','Codex','Cursor','Antigravity','Claude')][string]$Runtime='All')
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
$root=[IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..')); . (Join-Path $PSScriptRoot 'adapter-tools.ps1')
$targets=if($Runtime -eq 'All'){@('Codex','Cursor','Antigravity','Claude')}else{@($Runtime)}
foreach($name in $targets){$a=Get-AdapterManifest $root $name; $out=Resolve-RepositoryPath $root $a.instructionOutput; $content=Get-AdapterInstructionContent $root $a; if($PSCmdlet.ShouldProcess($out,'Materialize')){New-Item -ItemType Directory -Force (Split-Path $out)|Out-Null; [IO.File]::WriteAllText($out,$content,[Text.UTF8Encoding]::new($false))}}
Write-Host "Materialized: $($targets -join ', ')"
