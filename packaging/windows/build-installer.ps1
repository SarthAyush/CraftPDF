<#
.SYNOPSIS
  Builds CraftPDF release binary and creates the Windows Desktop Installer (.exe).
.EXAMPLE
  pwsh packaging/windows/build-installer.ps1
#>
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
$ISCC = "C:\Users\Astrea\AppData\Local\Programs\Inno Setup 6\ISCC.exe"
if (-not (Test-Path $ISCC)) {
    $found = Get-Command ISCC.exe -ErrorAction SilentlyContinue
    if ($found) { $ISCC = $found.Source }
    else { throw "Inno Setup compiler (ISCC.exe) not found." }
}

Write-Host "==> Step 3: Compiling Installer with $ISCC..." -ForegroundColor Cyan
$IssPath = Join-Path $PSScriptRoot 'craftpdf.iss'
& $ISCC $IssPath

$OutputExe = Join-Path $Root 'dist\CraftPDF-Setup-v0.7.1-x64.exe'
if (Test-Path $OutputExe) {
    $size = [math]::Round((Get-Item $OutputExe).Length / 1MB, 2)
    Write-Host "==> Success! Installer created at: $OutputExe ($size MB)" -ForegroundColor Green
}
