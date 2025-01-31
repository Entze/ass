todotxt_file="${args[--todotxt-file]:-$TODOTXT_FILE}"
field="${args[field]}"
eval "range=(${args[range]})"
verbosity="${args[--verbose]:-0}"

if [ "$verbosity" -ge 1 ]; then
  gum log --structured --level "debug" -- "todo delete-field: Parsing input" "TODOTXT_FILE" "$TODOTXT_FILE" "--todotxt-file" "${args[--todotxt-file]}" "todotxt_file" "$todotxt_file" "FIELD" "${args[field]}" "field" "$field" "VALUE" "${args[value]}" "value" "$value" "RANGE" "${args[range]}" "range" "${range[*]}" "--verbose" "${args[--verbose]}" "verbosity" "$verbosity"
fi

if ! [ -w "$todotxt_file" ]; then
  gum log --structured --level "error" -- "todo put-field: Cannot write to todotxt_file" "todotxt_file" "$todotxt_file"
  exit 1
fi

expression="p"
issue="false"
explanation=""
completion_expression="[xo]"
priority_expression="\([A-Z]\)"
date_expression="[0-9]{4}-[0-9]{2}-[0-9]{2}"

if [ "$field" = "completion" ]; then
  expression="s/^(${completion_expression}\s)?//"
else
  issue="true"
  explanation="todo delete-field: Unknown field" "field" "$field"
fi

