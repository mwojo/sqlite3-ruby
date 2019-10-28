#!/usr/bin/env bash

here="$(dirname "$(realpath "$0")")"

if [ ! -d "$1" ]; then
  echo "Provide path to sqlite3 amalgamation"
  exit 1
fi

version="$(awk '/^#define SQLITE_VERSION / { print $3 }' "$1/sqlite3.h")"

cp "$1/sqlite3.h" "$1/sqlite3ext.h" "$here/ext/sqlite3/"
cp "$1/sqlite3.c" "$here/ext/sqlite3/sqlite3_core.c"

sed -Ei '' "s/^  s.version = \"[^\"]+\"$/  s.version = $version/;s/^  s.date = \"[^\"]+\"$/  s.date = \"$(date +%F)\"/" "$here/sqlite3-static.gemspec"
