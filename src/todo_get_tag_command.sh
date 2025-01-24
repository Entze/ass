todotxt_file="${args[--todotxt-file]:-$TODOTXT_FILE}"
tag="${args[tag]}"
eval "range=(${args[range]})"
verbosity="${args[--verbose]:-0}"

if [ "$verbosity" -ge 1 ]; then
  gum log --structured --level "debug" -- "todo get-tag: Parsing input" "TODOTXT_FILE" "$TODOTXT_FILE" "--todotxt-file" "${args[--todotxt-file]}" "todotxt_file" "$todotxt_file" "TAG" "${args[tag]}" "tag" "$tag" "RANGE" "${args[range]}" "range" "${range[*]}" "--verbose" "${args[--verbose]}" "verbosity" "$verbosity"
fi

if ! [ -r "$todotxt_file" ]; then
  gum log --structured --level "error" -- "todo get-tag: Cannot read todotxt_file" "todotxt_file" "$todotxt_file"
  exit 1
fi

expression="/$tag:/! s/^.*$//; s/^.*$tag:([^ ]+).*$/\1/"

line_ranges=$(get_line_range_flags "${range[@]}")

sed --regexp-extended "$expression" "$todotxt_file" | bat $line_ranges --file-name "$todotxt_file (tag: $tag)"
