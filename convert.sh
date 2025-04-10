#!/bin/bash 

#!/bin/bash

mkdir -p content

for file in _posts/*.md; do
    filename=$(basename -- "$file")
    slug="${filename}"
    # slug="${filename##*-}"
    slug="${slug%.md}"
    outfile="content/$slug.md"

    echo "Converting $file -> $outfile"

    # Extract YAML front matter
    yaml=$(awk '/^---/{flag=flag+1; next} flag==1 {print}' "$file" | sed '/^---/q')

    # Extract fields
    title=$(echo "$yaml" | yq -r '.title // ""')
    date=$(echo "$yaml" | yq -r '.date // ""')
    tags=$(echo "$yaml" | yq -r '.tags // [] | join(", ")')
    desc=$(echo "$yaml" | yq -r '.description // .excerpt // ""')

    # Write Pelican header
    {
        echo "Title: $title"
        echo "Date: $date"
        echo "Slug: $slug"
        [ -n "$tags" ] && echo "Tags: $tags"
        [ -n "$desc" ] && echo "Summary: $desc"
        echo ""
    } > "$outfile"

    # Append Markdown body (after YAML front matter)
    awk '/^---/{flag+=1; next} flag>=2 {print}' "$file" >> "$outfile"
done
