#!/bin/bash

GITSTATS_SCRIPT_PATH="/Users/inza/Projects/Tools/gitstats/gitstats"
GOURCE_SCRIPT_PATH="/Users/inza/Projects/Tools/scripts/run_gource.sh"
STATS_OUTPUT_PATH="_stats"
VIDEO_OUTPUT_PATH="_visualization"

# Update Submodules
git submodule update

# Checkout master branches
find . -type d -mindepth 1 -maxdepth 1 -exec bash -c "cd '{}' && git pull origin master && git checkout master" \;

# Clean stats
find . -type d -mindepth 1 -maxdepth 1 -exec bash -c "cd '{}' && rm -Rf ./../export/$(basename {})$STATS_OUTPUT_PATH" \;

# Generate stats
find . -type d -mindepth 1 -maxdepth 1 -exec bash -c "cd '{}' && $GITSTATS_SCRIPT_PATH . ./../export/$(basename {})$STATS_OUTPUT_PATH" \;

# Remove ugly .git_stats
rm -Rf "export/.git_stats" "export/export_stats" "export/videos_stats"

# Add, Commit and Push generated stats
#find . -type d -maxdepth 1 -exec bash -c "cd '{}' && git add -A && git commit -m 'Generated git repository statistics' && git pull origin master && git push origin master" \;

# Update Submodules
#git submodule update

# Generate TOP Night Coder results
rm -f "top_night_coder.txt"
find . -type d -mindepth 1 -maxdepth 1 -exec bash -c "cd '{}/../export/$(basename {})$STATS_OUTPUT_PATH' && cat activity.html | grep '%' | ../../parse_commits.rb >> ../../top_night_coder.txt" \;
echo
echo
cat "top_night_coder.txt"
./calculate.rb > "top_night_coder_results.txt"
cat "top_night_coder_results.txt"

# Clean videos
find . -type d -mindepth 1 -maxdepth 1 -exec bash -c "cd '{}' && rm -Rf ./../export/$(basename {})$VIDEO_OUTPUT_PATH" \;

# Load GRavatars
find . -type d -mindepth 1 -maxdepth 1 -exec bash -c "cd '{}' && ../pull_images.pl" \;

# Generate gource
PWD="`pwd`"
find . -type d -mindepth 1 -maxdepth 1 -exec bash -c "cd '{}';WAY=$(basename {}) && $GOURCE_SCRIPT_PATH ./../export/$(basename {})$VIDEO_OUTPUT_PATH $(basename {}) $PWD${WAY##*/}" \;

#cd "Constimator/.git"
#$GOURCE_SCRIPT_PATH "./../export/Constimator$VIDEO_OUTPUT_PATH" "Constimator" "foo"
#cd "Doomify/.git"
#$GOURCE_SCRIPT_PATH "./../export/Doomify$VIDEO_OUTPUT_PATH" "Doomify" "foo"
#cd "Kanban-Board/.git"
#$GOURCE_SCRIPT_PATH "./../export/Kanban-Board$VIDEO_OUTPUT_PATH" "Kanban-Board" "foo"
#cd "SonicDroid/.git"
#$GOURCE_SCRIPT_PATH "./../export/SonicDroid$VIDEO_OUTPUT_PATH" "SonicDroid" "foo"

# Remove ugly .git_visualization
rm -Rf "export/.git_visualization" "export/export_visualization" "export/videos_visualization"

# Add, Commit and Push generated videos
#find . -type d -maxdepth 1 -exec bash -c "cd '{}' && git add -A && git commit -m 'Generated git repository visualization and statistics' && git pull origin master && git push origin master" \;

# Copy all videos to one folder
mkdir -p videos
rm -fR videos/*
cp -f ./export/*/*.mp4 "./videos/"

git add -A
git commit -m "Generated updated git repository visualization and statistics"
git push
