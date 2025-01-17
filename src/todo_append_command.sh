todotxt_file="${args[--todotxt-file]:-$TODOTXT_FILE}"
text="${args[text]}"
verbosity="${args[--verbose]:-0}"

if [ "$verbosity" -ge 1 ]; then
  gum log --structured --level "debug" -- "todo append: Parsing input" "TODOTXT_FILE" "$TODOTXT_FILE" "--todotxt-file" "${args[--todotxt-file]}" "todotxt_file" "$todotxt_file" "TEXT" "${args[text]}" "text" "$text" "--verbose" "${args[--verbose]}" "verbosity" "$verbosity"
fi

if ! [ -w "$todotxt_file" ]; then
 gum log --structured --level "error" -- "todo append: Cannot not write to todotxt_file" "todotxt_file" "$todotxt_file"
 exit 1
fi

if [ -z "$text" ]; then
  gum log --structured --level "info" -- "todo append: TEXT is empty"
fi

printf "%s\n" "$text" >> "$todotxt_file"
