#!/bin/bash

# Output file
output_file="firebase_urls.txt"
> "$output_file"

# Loop through all APK files in the directory
for apk in *.apk; do
    # Decompile the APK
    apktool d -f "$apk" -o "${apk%.apk}_decompiled"
    
    # Search for Firebase URLs
    firebase_urls=$(grep -iR 'firebaseio.com' "${apk%.apk}_decompiled" 2>/dev/null)

    # Check if any Firebase URL was found
    if [ -n "$firebase_urls" ]; then
        echo "APK: $apk" >> "$output_file"
        echo "$firebase_urls" >> "$output_file"
        echo "" >> "$output_file"
    fi
    
    # Clean up decompiled folder
    rm -rf "${apk%.apk}_decompiled"
done

echo "Firebase URL extraction completed. Results are stored in $output_file"
