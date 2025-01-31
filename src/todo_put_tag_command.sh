todotxt_file="${args[--todotxt-file]:-$TODOTXT_FILE}"
key="${args[key]}"
value="${args[value]}"
eval "range=(${args[range]})"
verbosity="${args[--verbose]:-0}"

if [ "$verbosity" -ge 1 ]; then
  gum log --structured --level "debug" -- "todo put-tag: Parsing input" "TODOTXT_FILE" "$TODOTXT_FILE" "--todotxt-file" "${args[--todotxt-file]}" "todotxt_file" "$todotxt_file" "KEY" "${args[key]}" "key" "$key" "VALUE" "${args[value]}" "value" "$value" "RANGE" "${args[range]}" "range" "${range[*]}" "--verbose" "${args[--verbose]}" "verbosity" "$verbosity"
fi

issue="false"

if ! [ -w "$todotxt_file" ]; then
  gum log --structured --level "error" -- "todo put-tag: Cannot write to todotxt_file" "todotxt_file" "$todotxt_file"
  issue="true"
fi


if [[ ! "$key" =~ ^[^[:space:]:]+$ ]]; then
  gum log --structured --level "error" -- "todo put-tag: Invalid key" "key" "$key"
  issue="true"
fi

if [[ ! "$value" =~ ^[^[:space:]:]+$ ]]; then
  gum log --structured --level "error" -- "todo put-tag: Invalid value" "value" "$value"
  issue="true"
fi

if [ "$issue" = "true" ]; then
  exit 1
fi

expression="/${key}:[^[:space:]:]+/! s/$/ ${key}:${value}/; s/${key}:[^[:space:]:]+/${key}:${value}/"

length="$(wc --lines $todotxt_file | rg --only-matching "^[0-9]+")"

line_expression="$(get_line_expression "$expression" "$length" "${range[@]}")"

if [ "$verbosity" -ge 1 ]; then
  gum log --structured --level "debug" -- "todo tag-field: determined line expression" "line_expression" "$line_expression"
fi

sed --regexp-extended --in-place "$line_expression" "$todotxt_file"

line_ranges=$(get_line_range_flags "${range[@]}")

bat $line_ranges $todotxt_file
