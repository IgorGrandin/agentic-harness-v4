Set-StrictMode -Version Latest

function Resolve-RepositoryPath {
    param(
        [Parameter(Mandatory = $true)][string]$RepositoryRoot,
        [Parameter(Mandatory = $true)][string]$RelativePath
    )

    $root = [IO.Path]::GetFullPath($RepositoryRoot).TrimEnd([IO.Path]::DirectorySeparatorChar, [IO.Path]::AltDirectorySeparatorChar)
    $path = [IO.Path]::GetFullPath((Join-Path $root ($RelativePath -replace '/', '\')))
    $prefix = $root + [IO.Path]::DirectorySeparatorChar
    if (-not $path.StartsWith($prefix, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Adapter path escapes repository: $RelativePath"
    }
    return $path
}

function Get-AdapterManifest {
    param(
        [Parameter(Mandatory = $true)][string]$RepositoryRoot,
        [Parameter(Mandatory = $true)][string]$Adapter
    )

    $path = Resolve-RepositoryPath -RepositoryRoot $RepositoryRoot -RelativePath "adapters/$($Adapter.ToLowerInvariant())/adapter.json"
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { throw "Missing adapter manifest: $path" }
    return Get-Content -Raw -LiteralPath $path | ConvertFrom-Json
}

function Get-AdapterInstructionContent {
    param(
        [Parameter(Mandatory = $true)][string]$RepositoryRoot,
        [Parameter(Mandatory = $true)]$AdapterManifest
    )

    $sources = [Collections.Generic.List[string]]::new()
    foreach ($source in $AdapterManifest.instructionSources) { $sources.Add([string]$source) }

    $parts = foreach ($relative in $sources) {
        $path = Resolve-RepositoryPath -RepositoryRoot $RepositoryRoot -RelativePath $relative
        if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { throw "Missing instruction source: $relative" }
        (Get-Content -Raw -LiteralPath $path).TrimEnd()
    }

    return (($parts -join "`n`n") + "`n")
}

function Get-RoleProjection {
    param([Parameter(Mandatory=$true)][string]$RepositoryRoot,[Parameter(Mandatory=$true)][string]$RoleFile,[Parameter(Mandatory=$true)][ValidateSet('Cursor','Claude','Antigravity')][string]$Provider)
    $raw = Get-Content -Raw (Resolve-RepositoryPath $RepositoryRoot "global/agents/$RoleFile")
    $name = [regex]::Match($raw,'(?m)^name\s*=\s*"([^"]+)"').Groups[1].Value
    $desc = [regex]::Match($raw,'(?m)^description\s*=\s*"([^"]+)"').Groups[1].Value
    $body = [regex]::Match($raw,'(?s)developer_instructions\s*=\s*"""\s*(.*?)\s*"""').Groups[1].Value.Trim()
    if (-not $name -or -not $body) { throw "Cannot project role $RoleFile" }
    if ($Provider -eq 'Cursor') { return "---`nname: $name`ndescription: $desc`nmodel: inherit`n---`n`n$body`n" }
    if ($Provider -eq 'Claude') {
        if ($name -eq 'architect_escalation') { $model='claude-opus-5'; $effort='low' } else { $model='claude-haiku-4-5-20251001'; $effort='medium' }
        return "---`nname: $name`ndescription: $desc`nmodel: $model`neffort: $effort`n---`n`n$body`n"
    }
    $model = if ($name -eq 'architect_escalation') { 'pro' } else { 'flash' }
    return "---`nname: $name`ndescription: $desc`nmodel: $model`n---`n`n$body`n"
}
