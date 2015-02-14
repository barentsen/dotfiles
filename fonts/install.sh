#!/bin/bash
# Set source and target directories
font_dir="$HOME/.fonts"
mkdir -p $font_dir
find_command="find . -name '*.[o,t]tf' -type f -print0"
eval $find_command | xargs -0 -I % cp "%" "$font_dir/"
# Reset font cache on Linux
if [[ -n `which fc-cache` ]]; then
    fc-cache -f $font_dir
fi
echo "Fonts installed to $font_dir"