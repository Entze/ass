todotxt_file="${args[--todotxt-file]:-$TODOTXT_FILE}"
field="${args[field]}"
value="${args[value]}"
eval "range=(${args[range]})"
verbosity="${args[--verbose]:-0}"

if [ "$verbosity" -ge 1 ]; then
  gum log --structured --level "debug" -- "todo put-field: Parsing input" "TODOTXT_FILE" "$TODOTXT_FILE" "--todotxt-file" "${args[--todotxt-file]}" "todotxt_file" "$todotxt_file" "FIELD" "${args[field]}" "field" "$field" "VALUE" "${args[value]}" "value" "$value" "RANGE" "${args[range]}" "range" "${range[*]}" "--verbose" "${args[--verbose]}" "verbosity" "$verbosity"
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

if [ "$field" = "completion" ];then
  replacement=""
  if [ "$value" = "true" ]; then
    replacement="x "
  elif [ "$value" != "false" ]; then
    issue="true"
    explanation="Unknown value for field"
  fi
  expression="s/^(${completion_expression}\s)?/$replacement/"
elif [ "$field" = "priority" ]; then
  if [[ ! "$value" =~ ^[A-Z]$ ]]; then
    issue="true"
    explanation="Unknown value for field"
  fi
  replacement="($value) "
  expression="s/^(${completion_expression}\s)?(\s*)(${priority_expression}\s)?/\1\2$replacement/"
elif [ "$field" = "completion-date" ]; then
  if [ -z "$value" ] || ! date --date "$value" 2>/dev/null 1>&2; then
    issue="true"
    explanation="Invalid date"
  fi
  replacement=""
  if [ "$issue" != "true" ]; then
    replacement="$(date --date "$value" +'%Y-%m-%d') "
  fi
  expression="s/^(x\s)(\s*)(${priority_expression}\s)?(\s*)(${date_expression}\s)(\s*)(${date_expression})/\1\2\3\4${replacement}\6\7/"
elif [ "$field" = "creation-date" ]; then
  if [ -z "$value" ] || ! date --date "$value" 2>/dev/null 1>&2; then
    issue="true"
    explanation="Invalid date"
  fi
  replacement=""
  if [ "$issue" != "true" ]; then
    replacement="$(date --date "$value" +'%Y-%m-%d') "
  fi
  expression="/${date_expression}\s+${date_expression}/! s/^(${completion_expression}\s)?(\s*)(${priority_expression}\s)?(\s*)(${date_expression}\s)?(\s*)(.*)$/\1\2\3\4${replacement}\6\7/; s/^(${completion_expression}\s)?(\s*)(${priority_expression}\s)?(\s*)(${date_expression}\s)(\s)*(${date_expression}\s)(.*)$/\1\2\3\4\5\6${replacement}\8/"
elif [ "$field" = "description" ]; then
  expression="s/^(${completion_expression}\s*)?(${priority_expression}\s*)?((${date_expression}\s*){0,2})(.*)$/\1\2\3${value}/"
elif [ "$field" = "project" ]; then
  if [ -z "$value" ] || ! [[ "$value" =~ ^[^[:space:]]+$ ]]; then
    issue="true"
    explanation="Invalid value"
  fi
  expression="s/\+[^([:space:])]+/+${value}/; /\+[^[:space:]]+/! s/$/ +${value}/"
elif [ "$field" = "context" ]; then
  if [ -z "$value" ] || ! [[ "$value" =~ ^[^[:space:]]+$ ]]; then
    issue="true"
    explanation="Invalid value"
  fi
  expression="s/@[^([:space:])]+/@${value}/; /@[^[:space:]]+/! s/$/ @${value}/"
fi


if [ "$issue" = "true" ]; then
  gum log --structured --level "error" -- "todo put-field: $explanation" "field" "$field" "value" "$value"
  exit 1
fi

if [ "$verbosity" -ge 1 ]; then
  gum log --structured --level "debug" -- "todo put-field: determined expression" "expression" "$expression"
fi

length="$(wc --lines $todotxt_file | rg --only-matching "^[0-9]+")"

line_expression="$(get_line_expression "$expression" "$length" "${range[@]}")"

if [ "$verbosity" -ge 1 ]; then
  gum log --structured --level "debug" -- "todo put-field: determined line expression" "line_expression" "$line_expression"
fi

sed --regexp-extended --in-place "$line_expression" "$todotxt_file"

line_ranges=$(get_line_range_flags "${range[@]}")

bat $line_ranges $todotxt_file
