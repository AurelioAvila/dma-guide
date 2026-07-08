Param(
    [string]$Branch = 'master',
    [switch]$Force
)

function Write-Log { param($m) Write-Output "[push-banner] $m" }

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "git non trovato in PATH. Installa Git o aggiungilo al PATH e riprova."
    exit 2
}

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..') -ErrorAction SilentlyContinue
if ($repoRoot) { Set-Location $repoRoot } else { Write-Log "Working directory: $((Get-Location).Path)" }

try {
    Write-Log "Repository root: $((Get-Location).Path)"

    Write-Log "Git status (short):"
    git status --short | ForEach-Object { Write-Output "  $_" }

    Write-Log "Staging assets/cover-v2.svg and README.md"
    git add assets/cover-v2.svg README.md 2>$null

    Write-Log "Committing (se ci sono modifiche)..."
    $commitOutput = git commit -m "Add cover-v2 and update README to force banner refresh" 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Log "Nessun nuovo commit (niente da commitare) oppure commit fallito. Output: $commitOutput"
    } else {
        Write-Log "Commit creato: $commitOutput"
    }

    Write-Log "Eseguo push su origin/$Branch";
    if ($Force.IsPresent) {
        git push origin $Branch --force 2>&1 | ForEach-Object { Write-Output "  $_" }
    } else {
        git push origin $Branch 2>&1 | ForEach-Object { Write-Output "  $_" }
    }

    Write-Log "Confronto local e remote HEAD"
    $local = (git rev-parse HEAD 2>$null)
    $remote = (git ls-remote origin HEAD 2>$null | ForEach-Object { $_.Split()[0] })
    Write-Log "LOCAL_HEAD: $local"
    Write-Log "REMOTE_HEAD: $remote"

    $rawUrl = "https://raw.githubusercontent.com/AurelioAvila/dma-guide/$Branch/assets/cover-v2.svg"
    Write-Log "Controllo raw URL: $rawUrl"
    try {
        $resp = Invoke-WebRequest -Uri $rawUrl -Method Head -ErrorAction Stop
        Write-Log "Raw URL status: $($resp.StatusCode)"
    } catch {
        Write-Log "Raw URL non disponibile ancora: $($_.Exception.Message)"
    }

    if ($local -and ($local -eq $remote)) {
        Write-Log "Successo: remote coincide con local HEAD. Se il raw è in cache, prova Ctrl+F5 sulla pagina GitHub."
        exit 0
    } else {
        Write-Log "Attenzione: remote non coincide con local HEAD. Il push potrebbe non essere riuscito."
        exit 3
    }
}
catch {
    Write-Error "Errore durante l'esecuzione: $($_.Exception.Message)"
    exit 4
}
finally {
    # non cambiare la directory dell'utente
}
