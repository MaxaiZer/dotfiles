[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::InputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/onehalf.minimal.omp.json" | Invoke-Expression
Invoke-Expression (& { (zoxide init powershell | Out-String) })

Set-PSReadLineOption -HistorySaveStyle SaveIncrementally
Set-PSReadLineOption -HistorySavePath ~/.pwsh_history

Import-Module posh-git
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

Set-PSReadLineOption -AddToHistoryHandler {
    param([string]$line)
    return ![string]::IsNullOrWhiteSpace($line)
}

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Invoke-Expression (&starship init powershell)

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
