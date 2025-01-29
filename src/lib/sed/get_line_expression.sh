get_line_expression() {
  expression="$1"
  length="$2"
  shift 2

  for range in "$@"; do
    if [ "$range" = ":" ] || [[ ! "$range" =~ ^[0-9]*(:\+?[0-9]*)?$ ]]; then
      gum log --structured --level "error" -- "get_line_expression: range does have invalid syntax" "range" "$range"
      exit 1
    fi

    exp="${range/\:/,}"
    if [[ "$range" =~ ^:[0-9]+$ ]]; then
      exp="1${exp}"
    elif [[ "$range" =~ ^[0-9]+:$ ]]; then
      exp="${exp}${length}"
    fi

    printf "%s{ %s }; " "$exp" "$expression"
  done

}
