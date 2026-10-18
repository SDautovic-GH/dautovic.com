# SyncGit-dautovic.com.ps1
# PowerShell 7 Compatible
# Sync dautovic.com + OneDrive Mirror
# ============================================

# -------------------------------------------
# Load WinForms safely for PowerShell 7
# -------------------------------------------
try {
    Add-Type -AssemblyName System.Windows.Forms -ErrorAction Stop
}
catch {
    $winForms = Join-Path $env:WINDIR "Microsoft.NET\Framework64\v4.0.30319\System.Windows.Forms.dll"
    if (Test-Path $winForms) {
        Add-Type -Path $winForms
    }
}

# -------------------------------------------
# Configuration
# -------------------------------------------
$RepoPath = "C:\.Developer\dautovic.com"
$OneDrivePath = "C:\Users\21968\OneDrive - WilmerHale\.Developer\dautovic.com"
$MainBranch = "main"
$RemoteName = "origin"

# -------------------------------------------
# Helper Functions
# -------------------------------------------

function Write-Section {
    param([string]$Text)
    Write-Host ""
    Write-Host $Text
    Write-Host ""
}

function Stop-WithError {
    param(
        [string]$Message,
        [int]$Code = 1
    )
    Write-Host ""
    Write-Host "ERROR: $Message" -ForegroundColor Red
    Write-Host ""
    try {
        [System.Windows.Forms.MessageBox]::Show(
            $Message,
            "Git Sync Error - dautovic.com",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Error
        ) | Out-Null
    }
    catch {}
    exit $Code
}

function Invoke-GitChecked {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Arguments,
        [string]$ActionDescription = "Git command"
    )

    $output = & git @Arguments 2>&1 | Where-Object {
        $_ -notmatch "^Already on " -and
        $_ -notmatch "^Switched to branch " -and
        $_ -notmatch "^From https?://" -and
        $_ -notmatch "^To https?://" -and
        $_ -notmatch "^\s*\* branch\s+" -and
        $_ -notmatch "^\s+[0-9a-f]+\.\.[0-9a-f]+\s+" -and
        $_ -notmatch "^Everything up-to-date"
    }
    $exitCode = $LASTEXITCODE

    if ($exitCode -ne 0) {
        $outputText = ($output | Out-String).Trim()
        if ([string]::IsNullOrWhiteSpace($outputText)) {
            $outputText = "No additional error output returned by git."
        }
        throw "$ActionDescription failed.`nCommand: git $($Arguments -join ' ')`n$outputText"
    }

    return $output
}

function Test-GitInstalled {
    $gitCmd = Get-Command git -ErrorAction SilentlyContinue
    return [bool]$gitCmd
}

function Test-IsGitRepo {
    $gitDir = & git rev-parse --git-dir 2>$null
    return ($LASTEXITCODE -eq 0 -and $gitDir -eq ".git")
}

function Set-GitIgnoreEntries {
    param(
        [string]$GitIgnorePath,
        [string[]]$Patterns
    )

    if (-not (Test-Path $GitIgnorePath)) {
        New-Item -Path $GitIgnorePath -ItemType File -Force | Out-Null
    }

    $content = @()
    if (Test-Path $GitIgnorePath) {
        $content = Get-Content $GitIgnorePath -ErrorAction SilentlyContinue
    }

    $updated = $false
    foreach ($pattern in $Patterns) {
        if ($content -notcontains $pattern) {
            Add-Content -Path $GitIgnorePath -Value $pattern
            $updated = $true
        }
    }

    return $updated
}

# -------------------------------------------
# Validation
# -------------------------------------------

if (-not (Test-Path $RepoPath)) {
    Stop-WithError -Message "Repo path not found: $RepoPath"
}

if (-not (Test-GitInstalled)) {
    Stop-WithError -Message "Git is not installed or not available in PATH."
}

Set-Location $RepoPath

if (-not (Test-IsGitRepo)) {
    Stop-WithError -Message "Path is not a valid Git repository: $RepoPath"
}

$configuredRemotes = & git remote 2>$null
if ($configuredRemotes -notcontains $RemoteName) {
    Stop-WithError -Message "Remote '$RemoteName' is not configured. Run: git remote add $RemoteName [repo-url]"
}

# Ensure OneDrive target exists
if (-not (Test-Path $OneDrivePath)) {
    New-Item -Path $OneDrivePath -ItemType Directory -Force | Out-Null
}

# -------------------------------------------
# Sync dautovic.com repo
# -------------------------------------------

try {
    Write-Section "Syncing dautovic.com repo..."

    $GitIgnorePath = Join-Path $RepoPath ".gitignore"
    $GitIgnorePatterns = @(
        ".DS_Store",
        "Thumbs.db",
        "*.log",
        "node_modules/",
        ".wrangler/",
        "dist/",
        ".env",
        "*.local"
    )
    $ignoreUpdated = Set-GitIgnoreEntries -GitIgnorePath $GitIgnorePath -Patterns $GitIgnorePatterns
    if ($ignoreUpdated) {
        Write-Host "Updated dautovic.com .gitignore."
    }

    # Abort any in-progress merge or rebase before checkout
    $mergeHead = Join-Path $RepoPath ".git\MERGE_HEAD"
    if (Test-Path $mergeHead) {
        Write-Host "Unresolved merge detected - aborting before checkout."
        & git merge --abort 2>$null
    }
    $rebaseMergeDir = Join-Path $RepoPath ".git\rebase-merge"
    $rebaseApplyDir = Join-Path $RepoPath ".git\rebase-apply"
    if ((Test-Path $rebaseMergeDir) -or (Test-Path $rebaseApplyDir)) {
        Write-Host "Unresolved rebase detected - aborting before checkout."
        & git rebase --abort 2>$null
    }

    Invoke-GitChecked -Arguments @("checkout", $MainBranch) -ActionDescription "Checkout $MainBranch"

    # COMMIT-FIRST flow: stage and commit local changes before pulling
    Invoke-GitChecked -Arguments @("add", "-A") -ActionDescription "Stage dautovic.com changes"
    $TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $committedThisRun = $false
    $localChanges = & git status --porcelain 2>$null
    if ($localChanges) {
        Invoke-GitChecked -Arguments @("commit", "-m", "Auto sync Windows $TimeStamp") -ActionDescription "Commit dautovic.com changes"
        $committedThisRun = $true
    }

    Invoke-GitChecked -Arguments @("fetch", $RemoteName, $MainBranch) `
        -ActionDescription "Fetch $MainBranch from $RemoteName"

    # Fast-forward or rebase onto origin
    $null = & git merge --ff-only -q "$RemoteName/$MainBranch" 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Histories diverged - replaying local commits on top of $RemoteName/$MainBranch..."
        $rebaseOutput = & git rebase "$RemoteName/$MainBranch" 2>&1
        if ($LASTEXITCODE -ne 0) {
            & git rebase --abort 2>$null
            throw ("Local commits can't be replayed onto $RemoteName/$MainBranch automatically.`n" +
                   "Your work is safe in a local commit on $MainBranch ('git log -1').`n" +
                   "To resolve: git rebase $RemoteName/$MainBranch, resolve conflicts, git rebase --continue, then sync again.`n" +
                   "Rebase output:`n$($rebaseOutput | Out-String)")
        }
        Write-Host "Replayed - local commits now sit on top of $RemoteName/$MainBranch."
    }

    # Push whenever local main is ahead
    $unpushed = @(& git log "$RemoteName/$MainBranch..$MainBranch" --oneline 2>$null)
    if ($unpushed.Count -gt 0) {
        try {
            Invoke-GitChecked -Arguments @("push", $RemoteName, $MainBranch) -ActionDescription "Push dautovic.com to $RemoteName"
        }
        catch {
            throw "Push failed; your commits are safe on local $MainBranch ('git log -$($unpushed.Count)').`n$($_.Exception.Message)"
        }
        Write-Host "dautovic.com updated on GitHub."
    }
    else {
        Write-Host "dautovic.com sync completed successfully. (Up to date)"
    }
}
catch {
    Stop-WithError -Message $_.Exception.Message
}

# -------------------------------------------
# Mirror to OneDrive
# -------------------------------------------

Write-Section "Mirroring dautovic.com to OneDrive..."

$ExcludedDirs = @(
    ".git",
    "node_modules",
    ".wrangler",
    "dist"
)
$ExcludedFiles = @(
    "*.log",
    "Thumbs.db",
    ".DS_Store"
)

$RobocopyArgs = @(
    $RepoPath,
    $OneDrivePath,
    "/MIR",
    "/FFT",
    "/Z",
    "/W:5",
    "/R:3",
    "/XD"
) + $ExcludedDirs + @("/XF") + $ExcludedFiles + @(
    "/NDL",
    "/NFL",
    "/NJH",
    "/NJS",
    "/NP"
)

$null = & robocopy @RobocopyArgs
$roboExit = $LASTEXITCODE

if ($roboExit -ge 8) {
    Stop-WithError -Message "Robocopy mirror to OneDrive failed with exit code $roboExit."
}

Write-Host "dautovic.com mirrored to OneDrive successfully."

# -------------------------------------------
# Repo Size
# -------------------------------------------

Write-Section "Calculating repository size..."

$WorkingSize = (Get-ChildItem $RepoPath -Recurse -File -Force | Measure-Object -Property Length -Sum).Sum
if (-not $WorkingSize) { $WorkingSize = 0 }
$WorkingSizeMB = [math]::Round($WorkingSize / 1MB, 2)

$GitFolder = Join-Path $RepoPath ".git"
$GitSize = (Get-ChildItem $GitFolder -Recurse -File -Force | Measure-Object -Property Length -Sum).Sum
if (-not $GitSize) { $GitSize = 0 }
$GitSizeMB = [math]::Round($GitSize / 1MB, 2)

Write-Host "Repo Working Size : $WorkingSizeMB MB"
Write-Host "Git History Size  : $GitSizeMB MB"
Write-Host ""
Write-Host "Sync complete."
Write-Host ""
