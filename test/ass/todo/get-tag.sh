
describe "todo get-tag"
it "returns the aof tag value"
export TODOTXT_FILE="$(readlink --canonicalize test/resources/todo/todo.txt)"
approve "$cli todo get-tag aof" "ass_todo_get_tag_aof_env"
unset TODOTXT_FILE
approve "$cli todo get-tag --todotxt-file 'test/resources/todo/todo.txt' aof" "ass_todo_get_tag_aof_flag"

it "returns the due tag value"
export TODOTXT_FILE="$(readlink --canonicalize test/resources/todo/todo.txt)"
approve "$cli todo get-tag due" "ass_todo_get_tag_due_env"
unset TODOTXT_FILE
approve "$cli todo get-tag --todotxt-file 'test/resources/todo/todo.txt' due" "ass_todo_get_tag_due_flag"

it "returns the t tag value"
export TODOTXT_FILE="$(readlink --canonicalize test/resources/todo/todo.txt)"
approve "$cli todo get-tag t" "ass_todo_get_tag_t_env"
unset TODOTXT_FILE
approve "$cli todo get-tag --todotxt-file 'test/resources/todo/todo.txt' t" "ass_todo_get_tag_t_flag"

it "returns the non-existent tag value"
export TODOTXT_FILE="$(readlink --canonicalize test/resources/todo/todo.txt)"
approve "$cli todo get-tag non-existent" "ass_todo_get_tag_non_existent_env"
unset TODOTXT_FILE
approve "$cli todo get-tag --todotxt-file 'test/resources/todo/todo.txt' non-existent" "ass_todo_get_tag_non_existent_flag"

it "exits early when todo.txt is not readable"
testtodotxt="$(mktemp --tmpdir='/tmp' -- 'todo.txt.XXXX')"
chmod -r $testtodotxt
allow_diff '[0-9A-Za-z]{4}$'
approve "$cli todo get-tag --todotxt-file $testtodotxt due" "ass_todo_get_tag_flag_notreadable"
