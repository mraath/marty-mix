# Configure the batch size
$BATCH_SIZE = 5

# Get the list of changed files
$files = git ls-files --others --modified --exclude-standard

# Initialize the batch counter
$counter = 0

foreach ($file in $files) {
    git add $file
    $counter++

    if ($counter -ge $BATCH_SIZE) {
        git commit -m "Batch commit of $BATCH_SIZE files"
        git push origin v4PlanC
        $counter = 0
    }
}

# Commit and push any remaining files
if ($counter -gt 0) {
    git commit -m "Final batch commit"
    git push origin v4PlanC
}
