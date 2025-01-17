pkd="${args[--pkd-dir]:-$PKD_DIR}"
areas="${args[--areas-subdir]:-$AREAS_SUBDIR}"
verbosity="${args[--verbose]:-0}"

if [ "$verbosity" -ge 1 ]; then
  gum log --structured --level "debug" -- "personal-knowledge-database area-of-focus list: Parsing input" "PKD_DIR" "$PKD_DIR" "--pkd-dir" "${args[--pkd-dir]}" "pkd" "$pkd" "AREAS_SUBDIR" "$AREAS_SUBDIR" "--areas-subdir" "${args[--areas-subdir]}" "areas" "$areas" "--verbose" "${args[--verbose]}" "verbosity" "$verbosity"
fi

if ! [ -d "$pkd/$areas" ]; then
  gum log --structured --level "error" -- "personal-knowledge-database area-of-focus list: pkd/areas is not a directory" "pkd" "$pkd" "areas" "$areas"
  exit 1
fi

# List all directories at level 1 of $pkd/$areas, only show the basename, then sort
fdfind --search-path "${pkd}/${areas}" --exact-depth 1 --type directory --exec printf "%s\n" "{/}" | sort
