pkd="${args[--pkd-dir]:-$PKD_DIR}"
areas="${args[--areas-subdir]:-$AREAS_SUBDIR}"
verbosity="${args[--verbose]:-0}"

if [[ $verbosity -ge 1 ]]; then
  gum log --structured --level "debug" -- "Parsing input" "PKD_DIR" "$PKD_DIR" "--pkd-dir" "${args[--pkd-dir]}" "pkd" "$pkd" "AREAS_SUBDIR" "$AREAS_SUBDIR" "--areas-subdir" "${args[--areas-subdir]}" "areas" "$areas" "--verbose" "${args[--verbose]}" "verbosity" "$verbosity"
fi

# List all directories at level 1 of $pkd/$areas, only show the basename, then sort
fdfind --search-path "${pkd}/${areas}" --exact-depth 1 --type directory --exec printf "%s\n" {/} | sort
