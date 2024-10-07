$ErrorActionPreference = "Stop"

function Invoke-Utility {
    $exe, $argsForExe = $Args
    # Workaround: Prevents 2> redirections applied to calls to this function
    #             from accidentally triggering a terminating error.
    #             See bug report at https://github.com/PowerShell/PowerShell/issues/4002
    $ErrorActionPreference = 'Continue'
    try { & $exe $argsForExe } catch { Throw } # catch is triggered ONLY if $exe can't be found, never for errors reported by $exe itself
    if ($LASTEXITCODE) { Throw "$exe indicated failure (exit code $LASTEXITCODE; full command: $Args)." }
}

Set-Alias iu Invoke-Utility

## Prepare
# Convert icon
iu magick -define "icon:auto-resize=256,128,64,48,32,16" "assets/logo@512.png" "crates/mizer/icon.ico"

## Build
# FFI/UI
Write-Output "Building FFI..."
try {
    Set-Location crates/ui
    iu make generate_bindings
    iu cargo build --release -p mizer-ui-ffi
}finally {
    Set-Location ../..
}

# Build app
Write-Output "Building Application..."
iu cargo build --no-default-features --features ui --release -p mizer

## Packaging
Write-Output "Packaging Application..."

# Create artifact
if (Test-Path -Path "artifact") {
    Remove-Item -Recurse -Force artifact
}
if (Test-Path -Path "mizer.zip") {
    Remove-Item -Force mizer.zip
}
iu cargo run -p mizer-package

# Bundle as Zip
try {
    Set-Location artifact
    iu 7z a -tzip ../mizer.zip *
}finally {
    Set-Location ..
}
