todotxt_file="${args[--todotxt-file]:-$TODOTXT_FILE}"
field="${args[field]}"
eval "range=(${args[range]})"
verbosity="${args[--verbose]:-0}"

if [ "$verbosity" -ge 1 ]; then
  gum log --structured --level "debug" -- "todo get-field: Parsing input" "TODOTXT_FILE" "$TODOTXT_FILE" "--todotxt-file" "${args[--todotxt-file]}" "todotxt_file" "$todotxt_file" "FIELD" "${args[field]}" "field" "$field" "RANGE" "${args[range]}" "range" "${range[*]}" "--verbose" "${args[--verbose]}" "verbosity" "$verbosity"
fi

if ! [ -r "$todotxt_file" ]; then
  gum log --structured --level "error" -- "todo get-field: Cannot read todotxt_file" "todotxt_file" "$todotxt_file"
  exit 1
fi

expression="p"

if [ "$field" = "completion" ]; then
  expression='s/^[^x].*$/false/; s/^x.*$/true/'
elif [ "$field" = "priority" ]; then
  expression='s/^.*\(([A-Z])\).*$/\1/; s/^..+$//'
elif [ "$field" = "completion-date" ]; then
  expression='s/^[^x].*$//; s/x\s*(\([A-Z]\))?\s*([0-9]{4}-[0-9]{2}-[0-9]{2})\s*([0-9]{4}-[0-9]{2}-[0-9]{2}).*/\2/; s/^[^0-9].*$//'
elif [ "$field" = "creation-date" ]; then
  expression='s/x\s*(\([A-Z]\))?\s*([0-9]{4}-[0-9]{2}-[0-9]{2})\s*([0-9]{4}-[0-9]{2}-[0-9]{2}).*$/\3/; s/[xo]?\s*(\([A-Z]\))?\s*([0-9]{4}-[0-9]{2}-[0-9]{2}).*$/\2/; s/^[^0-9].*$//'
elif [ "$field" = "description" ]; then
  expression='s/[xo]?\s*(\([A-Z]\))?\s*([0-9]{4}-[0-9]{2}-[0-9]{2})?\s*([0-9]{4}-[0-9]{2}-[0-9]{2})?\s*(.*)$/\4/'
elif [ "$field" = "project" ]; then
  expression='s/^.*(\+[^ ]+).*$/\1/; s/^[^+].*$//'
elif [ "$field" = "context" ]; then
  expression='s/^.*(@[^ ]+).*$/\1/; s/^[^@].*$//'
else
  gum log --structured --level "warn" "todo get-field: Unknown field" "field" "$field"
fi


if [ "$verbosity" -ge 1 ]; then
  gum log --structured --level "debug" -- "todo get-field: determined expression" "expression" "$expression"
fi

line_ranges=$(get_line_range_flags "${range[@]}")

sed --regexp-extended "$expression" "$todotxt_file" | bat $line_ranges --file-name "$todotxt_file ($field)"
