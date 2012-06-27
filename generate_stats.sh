#!/bin/bash

GITSTATS_SCRIPT_PATH="/Users/inza/Projects/Tools/gitstats/gitstats"
GOURCE_SCRIPT_PATH="/Users/inza/Projects/Tools/scripts/run_gource.sh"
STATS_OUTPUT_PATH="DartHackPrague_stats"
VIDEO_OUTPUT_PATH="DartHackPrague_visualization"

# Update Submodules
git submodule update

# Checkout master branches
find . -type d -mindepth 1 -maxdepth 1 -exec bash -c "cd '{}' && git pull origin master && git checkout master" \;

# Clean stats
find . -type d -mindepth 1 -maxdepth 1 -exec bash -c "cd '{}' && rm -Rf ./$STATS_OUTPUT_PATH" \;

# Generate stats
find . -type d -mindepth 1 -maxdepth 1 -exec bash -c "cd '{}' && $GITSTATS_SCRIPT_PATH . ./$STATS_OUTPUT_PATH" \;

# Add, Commit and Push generated stats
#find . -type d -maxdepth 1 -exec bash -c "cd '{}' && git add -A && git commit -m 'Generated git repository statistics' && git pull origin master && git push origin master" \;

# Update Submodules
#git submodule update

# Generate TOP Night Coder results
rm -f "top_night_coder.txt"
find . -type d -mindepth 1 -maxdepth 1 -exec bash -c "cd '{}/$STATS_OUTPUT_PATH' && cat activity.html | grep '%' | ../../parse_commits.rb >> ../../top_night_coder.txt" \;
echo
echo
cat "top_night_coder.txt"
./calculate.rb > "top_night_coder_results.txt"
cat "top_night_coder_results.txt"

# Clean stats
#find . -type d -mindepth 1 -maxdepth 1 -exec bash -c "cd '{}' && rm -Rf ./$VIDEO_OUTPUT_PATH" \;

# Generate gource
#find . -type d -mindepth 1 -maxdepth 1 -exec bash -c "cd '{}' && $GOURCE_SCRIPT_PATH $VIDEO_OUTPUT_PATH" \;

# Add, Commit and Push generated videos
#find . -type d -maxdepth 1 -exec bash -c "cd '{}' && git add -A && git commit -m 'Generated git repository visualization' && git pull origin master && git push origin master" \;

# Copy all videos to one folder
#mkdir -p videos
#cp -f "*/$VIDEO_OUTPUT_PATH/*.mp4" "./videos/"
