#!/usr/bin/env bash
# Makes a blinded copy of a finished run for the oracle check.
# Usage: experiment/blind.sh <run folder> <output folder> <key file>
# The key file maps each code to its run. Keep it away from the scorer until the oracle check is done.
set -euo pipefail

if [[ $# -ne 3 ]]; then
  echo "Usage: $0 <run folder> <output folder> <key file>" >&2
  exit 1
fi

run=$1
out=$2
key=$3
code=$(openssl rand -hex 3)
target="$out/$code"

mkdir -p "$target"
tar -C "$run" --exclude .git --exclude target --exclude node_modules --exclude docs --exclude CLAUDE.md \
  --exclude session-log.md --exclude src/main/frontend -cf - . | tar -C "$target" -xf -

# The artifact id and the specification ids in code and test names give the variant away.
sed -i.bak -E 's#<artifactId>(us|usf|uc)-courses</artifactId>#<artifactId>courses</artifactId>#' "$target/pom.xml"
rm "$target/pom.xml.bak"
grep -rlIE '(UC|FR|BR|NFR)-?[0-9]{3}' "$target" | while IFS= read -r file; do
  perl -pi -e 's/\b(?:UC|FR|NFR|BR)-?\d{3}\b/REF/g; s/\bUC\d{3}(?=[A-Z])/REF/g' "$file"
done

find "$target" -depth -name 'UC[0-9][0-9][0-9]*' | while IFS= read -r file; do
  name=$(basename "$file")
  mv "$file" "$(dirname "$file")/REF${name:5}"
done

echo "$code $run" >> "$key"
echo "$target"
