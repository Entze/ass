describe "todo append"
it "can append 'Append test'"

testtodo="$(mktemp --directory --tmpdir='/tmp' 'ass_todo_append.XXXX')"
cp test/resources/todo/* "$testtodo/."
export TODOTXT_FILE="$testtodo/todo.txt"
$cli todo append "Append test ENV"
unset TODOTXT_FILE
approve "cat $testtodo/todo.txt" "ass_todo_append_env"

cp test/resources/todo/* "$testtodo/."
$cli todo append --todotxt-file "$testtodo/todo.txt" "Append test FLAG"
approve "cat $testtodo/todo.txt" "ass_todo_append_flag"

it "exits early if todo.txt is not writeable"
testtodotxt="$(mktemp --tmpdir='/tmp' -- 'todo.txt.XXXX')"
chmod -w $testtodotxt
allow_diff '[0-9A-Za-z]{4}$'
approve "$cli todo append --todotxt-file $testtodotxt 'Append not possible FLAG'" "ass_todo_append_flag_notwriteable"
