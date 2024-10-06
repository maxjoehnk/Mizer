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

## Build
# FFI/UI
Write-Output "Building FFI..."
try {
    cd crates/ui
    iu make generate_bindings
    iu cargo build --release -p mizer-ui-ffi
}finally {
    cd ../..
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
    cd artifact
    iu 7z a -tzip ../mizer.zip *
}finally {
    cd ..
}
