pkd="${args[--pkd-dir]:-$PKD_DIR}"
projects="${args[--projects-subdir]:-$PROJECTS_SUBDIR}"
verbosity="${args[--verbose]:-0}"

if [[ $verbosity -ge 1 ]]; then
  gum log --structured --level "debug" -- "personal knowledge database project list: Parsing input" "PKD_DIR" "$PKD_DIR" "--pkd-dir" "${args[--pkd-dir]}" "pkd" "$pkd" "PROJECTS_SUBDIR" "$PROJECTS_SUBDIR" "--projects-subdir" "${args[--projects-subdir]}" "projects" "$projects" "--verbose" "${args[--verbose]}" "verbosity" "$verbosity"
fi

export -f get_title

# List level 1 heading's or titles of markdown files that start with +
# Disable SC2016, because we don't need expansion of expressions.
# shellcheck disable=SC2016
fdfind --search-path "${pkd}/${projects}" --type file --extension md --exec bash -c 'get_title "$0" "$1"' "{}" "$verbosity" | sort
