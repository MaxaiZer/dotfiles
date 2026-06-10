[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::InputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/onehalf.minimal.omp.json" | Invoke-Expression
Invoke-Expression (& { (zoxide init powershell | Out-String) })

Import-Module posh-git
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key Ctrl+u -Function BackwardDeleteLine

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t'
Invoke-Expression (&starship init powershell)
Invoke-Expression (&atuin init powershell --disable-up-arrow | Out-String)

function yy {
    $tmp = New-TemporaryFile | Rename-Item -NewName { $_ -replace 'tmp$', 'txt' } -PassThru
    yazi @args --cwd-file="$tmp"
    if ($cwd = Get-Content -Raw -Path $tmp) {
        if ($cwd -and $cwd -ne $PWD.Path) {
            Set-Location -LiteralPath $cwd
        }
    }
    Remove-Item -Force -ErrorAction SilentlyContinue $tmp
}

$extraProfilePath = Join-Path $PSScriptRoot "extra.ps1"
if (Test-Path $extraProfilePath) {
    . $extraProfilePath
}

if (Test-Path ~/.config/powershell/completions) {
    Get-ChildItem ~/.config/powershell/completions/*.ps1 | ForEach-Object {
        . $_
    }
}

