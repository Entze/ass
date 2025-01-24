get_line_range_flags() {

  for range in "$@"; do
    if [ "$range" = ":" ] || [[ ! "$range" =~ ^[0-9]*(:\+?[0-9]*)?$ ]]; then
      gum log --structured --level "error" -- "get_line_range_flags: range does have invalid syntax" "range" "$range"
      exit 1
    fi
    printf -- "--line-range %s " "$range"
  done
  
}
