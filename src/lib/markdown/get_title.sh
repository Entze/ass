
get_title() {

  file="$1"
  verbosity="$2"

  if [[ $verbosity -ge 1 ]]; then
    gum log --structured --level "debug" -- "get_title: Parsing input" "file" "$file" "verbosity" "$verbosity"
  fi  


  if ! [ -r $file ]; then
    gum log --structured --level "error" -- "Could not read" "file" "$file"
  fi

  level_1_heading="$(rg --no-line-number '^# \+' "$file")"
  has_level_1_heading="$?"

  if [[ $verbosity -ge 1 ]]; then
    gum log --structured --level "debug" -- "get_title: Searching level 1 heading" "has_level_1_heading" "$has_level_1_heading" "level_1_heading" "$level_1_heading"
  fi

  if [ "$has_level_1_heading" -eq 0 ]; then
    printf "%s\n" "${level_1_heading:2}" | head --lines 1
    exit 0
  fi

  title="$(yq --front-matter extract '.title' $file 2> /dev/null | rg --no-line-number '^\+')"
  has_title="$?"

  if [[ $verbosity -ge 1 ]]; then
    gum log --structured --level "debug" -- "get_title: Searching title" "has_title" "$has_title" "title" "$title"
  fi

  if [ "$has_title" -eq 0 ]; then
    printf "%s\n" "$title" | head --lines 1
    exit 0
  fi  

  exit 1
}
