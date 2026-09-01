[CmdletBinding()]
param(
    [string]$CodexHome = (Join-Path $HOME '.codex'),
    [string]$ClaudeHome = (Join-Path $HOME '.claude'),
    [string]$Target,
    [switch]$WhatIf
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-BundleDefinition {
    param([Parameter(Mandatory)][string]$Name)
    switch ($Name) {
        'Codex' {
            [pscustomobject]@{
                Name          = 'Codex'
                Source        = Join-Path $PSScriptRoot '.codex'
                Destination   = $CodexHome
                ManagedPaths  = @(
                    'AGENTS.md', 'rules.md', 'jarvis-runtime.json', 'engram-instructions.md',
                    'incident-reporting.md', 'bundled-skills.md', 'agents', 'skills'
                )
                RequiredFiles = @(
                    'AGENTS.md', 'rules.md', 'jarvis-runtime.json', 'engram-instructions.md',
                    'incident-reporting.md', 'bundled-skills.md'
                )
            }
        }
        'Claude' {
            [pscustomobject]@{
                Name          = 'Claude'
                Source        = Join-Path $PSScriptRoot '.claude'
                Destination   = $ClaudeHome
                ManagedPaths  = @(
                    'CLAUDE.md', 'rules.md', 'jarvis-runtime.json', 'engram-instructions.md',
                    'incident-reporting.md', 'bundled-skills.md', 'agents', 'skills'
                )
                RequiredFiles = @(
                    'CLAUDE.md', 'rules.md', 'jarvis-runtime.json', 'engram-instructions.md',
                    'incident-reporting.md', 'bundled-skills.md'
                )
            }
        }
        default { throw "Unknown target: $Name" }
    }
}

if ([string]::IsNullOrWhiteSpace($Target)) {
    do {
        Write-Host ''
        Write-Host 'Which configuration do you want to install?'
        Write-Host '  1) Codex'
        Write-Host '  2) Claude'
        Write-Host '  3) Both'
        $choice = Read-Host 'Enter 1, 2, or 3'
        $Target = switch ($choice) {
            '1' { 'Codex' }
            '2' { 'Claude' }
            '3' { 'Both' }
            default { $null }
        }
    } while ([string]::IsNullOrWhiteSpace($Target))
}

$normalizedTarget = @('Codex', 'Claude', 'Both') | Where-Object { $_ -eq $Target }
if (-not $normalizedTarget) {
    throw "Invalid -Target '$Target'. Use one of: Codex, Claude, Both."
}
$Target = $normalizedTarget

$targetNames = if ($Target -eq 'Both') { @('Codex', 'Claude') } else { @($Target) }
$bundles = $targetNames | ForEach-Object { Get-BundleDefinition $_ }

foreach ($bundle in $bundles) {
    if (-not (Test-Path -LiteralPath $bundle.Source -PathType Container)) {
        throw "Bundle source not found: $($bundle.Source)"
    }
    foreach ($relativePath in $bundle.RequiredFiles) {
        if (-not (Test-Path -LiteralPath (Join-Path $bundle.Source $relativePath) -PathType Leaf)) {
            throw "Incomplete $($bundle.Name) bundle; missing: $relativePath"
        }
    }
}

if ($WhatIf) {
    foreach ($bundle in $bundles) {
        Write-Host "WhatIf: clean install would copy '$($bundle.Source)' into '$($bundle.Destination)'."
    }
    Write-Host 'WhatIf: config.toml / settings.json would remain untouched.'
    return
}

foreach ($bundle in $bundles) {
    if (-not (Test-Path -LiteralPath $bundle.Destination)) {
        New-Item -ItemType Directory -Path $bundle.Destination -Force | Out-Null
    }
    $resolvedDestination = (Resolve-Path -LiteralPath $bundle.Destination).Path
    $bundle | Add-Member -NotePropertyName ResolvedDestination -NotePropertyValue $resolvedDestination
    $existing = @($bundle.ManagedPaths | Where-Object { Test-Path -LiteralPath (Join-Path $resolvedDestination $_) })
    if ($existing.Count -gt 0) {
        throw "Clean-install only: $($bundle.Name) target already contains managed path(s): $($existing -join ', '). Use a new $($bundle.Name) home or remove them manually after backup; this installer does not migrate, overwrite, or prune existing installations."
    }
}

foreach ($bundle in $bundles) {
    Get-ChildItem -LiteralPath $bundle.Source -Force | ForEach-Object {
        Copy-Item -LiteralPath $_.FullName -Destination (Join-Path $bundle.ResolvedDestination $_.Name) -Recurse
    }
    foreach ($relativePath in $bundle.RequiredFiles) {
        if (-not (Test-Path -LiteralPath (Join-Path $bundle.ResolvedDestination $relativePath) -PathType Leaf)) {
            throw "Installation verification failed for $($bundle.Name): $relativePath"
        }
    }
    Write-Host "Clean installation completed ($($bundle.Name)): $($bundle.ResolvedDestination)"
}

if ($targetNames -contains 'Codex') {
    Write-Host 'Codex config.toml was not changed. Configure runtime instruction wiring separately.'
}
if ($targetNames -contains 'Claude') {
    Write-Host 'Claude Code settings.json was not changed. Wire up hooks or other runtime settings separately if needed.'
}
