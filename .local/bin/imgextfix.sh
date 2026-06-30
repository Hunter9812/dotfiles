#!/usr/bin/env bash

declare -a src_list
declare -a dst_list
declare -a mime_list

shopt -s nullglob

# Collect all mismatched files first
for f in *; do
    [[ -f "$f" ]] || continue

    # Detect actual MIME type from file content
    mime=$(file --mime-type -b "$f")

    # Extract file extension
    ext="${f##*.}"
    ext=$(echo "$ext" | tr '[:upper:]' '[:lower:]')

    case "$mime" in
        image/jpeg) real="jpg" ;;
        image/png)  real="png" ;;
        image/webp) real="webp" ;;
        *) continue ;;
    esac

    # Compare extension with real file type
    if [[ "$ext" != "$real" ]]; then
        new_name="${f%.*}.$real"

        src_list+=("$f")
        dst_list+=("$new_name")
        mime_list+=("$mime")
    fi
done

# Exit if no mismatches found
if [[ ${#src_list[@]} -eq 0 ]]; then
    echo "No mismatched files found."
    exit 0
fi

# Display planned operations
echo "Planned changes:"
echo "----------------------------------------"

for i in "${!src_list[@]}"; do
    printf "%-30s -> %s (%s)\n" \
        "${src_list[$i]}" \
        "${dst_list[$i]}" \
        "${mime_list[$i]}"
done

echo "----------------------------------------"

# Batch confirmation before applying changes
read -rp "Apply all changes? [y/N]: " ans

# Execute changes only if confirmed
if [[ "$ans" =~ ^[Yy]$ ]]; then
    for i in "${!src_list[@]}"; do
        mv -- "${src_list[$i]}" "${dst_list[$i]}"
    done
    echo "Completed."
else
    echo "Aborted."
fi
