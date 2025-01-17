todotxt_file="${args[--todotxt-file]:-$TODOTXT_FILE}"
entry="${args[n]}"
verbosity="${args[--verbose]:-0}"

if [ "$verbosity" -ge 1 ]; then
  gum log --structured --level "debug" -- "todo delete: Parsing input" "TODOTXT_FILE" "$TODOTXT_FILE" "--todotxt-file" "${args[--todotxt-file]}" "todotxt_file" "$todotxt_file" "N" "${args[n]}" "entry" "$entry" "--verbose" "${args[--verbose]}" "verbosity" "$verbosity"
fi

if ! [ -w "$todotxt_file" ]; then
 gum log --structured --level "error" -- "todo delete: Cannot not write to todotxt_file" "todotxt_file" "$todotxt_file"
 exit 1
fi

len="$(wc -l $todotxt_file | rg --only-matching "^[0-9]+")"
if [ "$verbosity" -ge 1 ]; then
  gum log --structured --level "debug" -- "todo delete: Checking length of todo.txt" "len" "$len"
fi


if [ "$len" -lt "$entry" ]; then
  gum log --structured --level "warn" -- "todo delete: Cannot delete entry" "entry" "$entry" "len" "$len"
fi


sed --in-place "${entry}d" "$todotxt_file"
