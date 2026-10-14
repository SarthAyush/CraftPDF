<#
.SYNOPSIS
  Builds CraftPDF release binary and creates the Windows Desktop Installer (.exe).
.EXAMPLE
  pwsh packaging/windows/build-installer.ps1 -Version "0.7.1"
#>
[CmdletBinding()]
param(
    [string]$Version = "0.7.1"
)

$ErrorActionPreference = 'Stop'
$Root = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path

Write-Host "==> Step 1: Compiling CraftPDF (Release build)..." -ForegroundColor Cyan
Push-Location $Root
try {
    cargo build --release -p pdfcraft
} finally {
    Pop-Location
}

Write-Host "==> Step 2: Locating Inno Setup Compiler..." -ForegroundColor Cyan
$Candidates = @(
    "C:\Program Files (x86)\Inno Setup 6\ISCC.exe",
    "C:\Program Files\Inno Setup 6\ISCC.exe",
    "$env:LOCALAPPDATA\Programs\Inno Setup 6\ISCC.exe",
    (Get-Command ISCC.exe -ErrorAction SilentlyContinue).Source
) | Where-Object { $_ -and (Test-Path $_) }

if ($Candidates.Count -eq 0) {
    throw "Inno Setup compiler (ISCC.exe) not found. Please install Inno Setup 6."
}
$ISCC = $Candidates[0]
Write-Host "Found ISCC at: $ISCC" -ForegroundColor Gray

Write-Host "==> Step 3: Compiling Installer with $ISCC (Version: $Version)..." -ForegroundColor Cyan
$IssPath = Join-Path $PSScriptRoot 'craftpdf.iss'
& $ISCC "/DMyAppVersion=$Version" $IssPath

$DistDir = Join-Path $Root 'dist'
New-Item -ItemType Directory -Force -Path $DistDir | Out-Null

$VersionedExe = Join-Path $DistDir "CraftPDF-Setup-v$Version-x64.exe"
$StandardSetup = Join-Path $DistDir "CraftPDF-Setup.exe"
$PortableExe = Join-Path $DistDir "CraftPDF.exe"

if (Test-Path $VersionedExe) {
    Copy-Item $VersionedExe $StandardSetup -Force
    Copy-Item (Join-Path $Root 'target\release\pdfcraft.exe') $PortableExe -Force
    $size = [math]::Round((Get-Item $VersionedExe).Length / 1MB, 2)
    Write-Host "==> Success! Installer created at: $VersionedExe ($size MB)" -ForegroundColor Green
    Write-Host "Staged: $StandardSetup and $PortableExe" -ForegroundColor Green
}
