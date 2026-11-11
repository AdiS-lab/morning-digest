# Morning Wire — Daily Digest Generator
# Runs on login via Windows Task Scheduler.
# Catches up on any missed days since the last digest.

$ErrorActionPreference = "Stop"
$ProjectDir = "C:\01-Projects\RealProjects\morning-digest"
Set-Location $ProjectDir

# Find the last digest date from manifest
$manifest = Get-Content "digests\manifest.json" -Raw | ConvertFrom-Json
$lastDate = ($manifest.digests | Select-Object -Last 1).date
$today = Get-Date -Format "yyyy-MM-dd"

if ($lastDate -eq $today) {
    Write-Host "Already up to date."
    exit 0
}

# Build list of missing dates
$missing = @()
$current = ([datetime]::ParseExact($lastDate, "yyyy-MM-dd", $null)).AddDays(1)
$todayDt = [datetime]::ParseExact($today, "yyyy-MM-dd", $null)
while ($current -le $todayDt) {
    $missing += $current.ToString("yyyy-MM-dd")
    $current = $current.AddDays(1)
}

Write-Host "Last digest: $lastDate"
Write-Host "Missing dates: $($missing -join ', ')"
Write-Host "Generating..."

foreach ($day in $missing) {
    $dayDt = [datetime]::ParseExact($day, "yyyy-MM-dd", $null)
    $dayDisplay = $dayDt.ToString("MMMM d, yyyy")
    $month = $dayDt.ToString("yyyy-MM")

    Write-Host "--- Generating $day ---"

    # Step 1: Search + digest + manifest (haiku)
    $prompt1 = @"
Today is ${dayDisplay}. MONTH=${month}. TODAY=${day}.
Read guidelines/generation-instructions.md, then do steps 1-2 and 4-6.
Create the digest page and update index/manifest.
Do NOT create story pages yet.
"@
    claude --print --model haiku -p $prompt1 --allowedTools "WebSearch,Read,Write,Edit,Bash,Glob"

    # Step 2: Story pages with diagrams (sonnet)
    $prompt2 = @"
Read guidelines/generation-instructions.md and guidelines/diagram-guidelines.md.
Read the digest at digests/${month}/${day}.html.
Do step 3 only: create story pages in digests/${month}/${day}/ for every story linked from the digest.
Every page MUST have at least one rough.js diagram. Follow diagram guidelines exactly.
Check digests/manifest.json for cross-links by tag.
"@
    claude --print --model sonnet -p $prompt2 --allowedTools "Read,Write,Edit,Bash,Glob"

    Write-Host "--- Done $day ---"
}

# Push to GitHub
git add digests/
$null = git diff --staged --quiet
if ($LASTEXITCODE -ne 0) {
    git commit -m "digest: $($missing -join ' ')"
}
git push

# Open today's digest
$month = Get-Date -Format "yyyy-MM"
Start-Process "$ProjectDir\digests\$month\$today.html"

Write-Host "All done."
