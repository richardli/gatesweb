#!/usr/bin/env bash

TAG="v2025.11.24"
DIR="docs/assets"

echo "Uploading all HTML files from $DIR to GitHub Release tag $TAG..."

FILES=$(find "$DIR" -type f -name "*.html")

for f in $FILES; do
  # 提取国家代码
  country=$(echo "$f" | sed -E 's#.*images/([^/]+)/.*#\1#')
  filename=$(basename "$f")
  safe_name="${country}__${filename}"

  echo "Uploading: $f   as   $safe_name"
  cp "$f" "$safe_name"
  gh release upload "$TAG" "$safe_name" --clobber
  rm "$safe_name"
done

echo "Done!"
