Param(
    [string]$Branch = 'master',
    [switch]$Force
)

function Write-Log { param($m) Write-Output "[push-banner] $m" }

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "git was not found in PATH. Install Git or add it to PATH, then try again."
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

    Write-Log "Committing (if there are changes)..."
    $commitOutput = git commit -m "Add cover-v2 and update README to force banner refresh" 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Log "No new commit was created (nothing to commit), or the commit failed. Output: $commitOutput"
    } else {
        Write-Log "Commit created: $commitOutput"
    }

    Write-Log "Pushing to origin/$Branch";
    if ($Force.IsPresent) {
        git push origin $Branch --force 2>&1 | ForEach-Object { Write-Output "  $_" }
    } else {
        git push origin $Branch 2>&1 | ForEach-Object { Write-Output "  $_" }
    }

    Write-Log "Comparing local and remote HEAD"
    $local = (git rev-parse HEAD 2>$null)
    $remote = (git ls-remote origin HEAD 2>$null | ForEach-Object { $_.Split()[0] })
    Write-Log "LOCAL_HEAD: $local"
    Write-Log "REMOTE_HEAD: $remote"

    $rawUrl = "https://raw.githubusercontent.com/AurelioAvila/dma-guide/$Branch/assets/cover-v2.svg"
    Write-Log "Checking raw URL: $rawUrl"
    try {
        $resp = Invoke-WebRequest -Uri $rawUrl -Method Head -ErrorAction Stop
        Write-Log "Raw URL status: $($resp.StatusCode)"
    } catch {
        Write-Log "Raw URL is not available yet: $($_.Exception.Message)"
    }

    if ($local -and ($local -eq $remote)) {
        Write-Log "Success: remote matches local HEAD. If the raw asset is cached, press Ctrl+F5 on the GitHub page."
        exit 0
    } else {
        Write-Log "Warning: remote does not match local HEAD. The push may have failed."
        exit 3
    }
}
catch {
    Write-Error "Execution failed: $($_.Exception.Message)"
    exit 4
}
finally {
    # Do not change the user's working directory again here.
}
