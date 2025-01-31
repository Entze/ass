
describe "todo get-field"
it "returns the completion status"
export TODOTXT_FILE="$(readlink --canonicalize test/resources/todo/todo.txt)"
approve "$cli todo get-field completion" "ass_todo_get_field_completion_env"
unset TODOTXT_FILE
approve "$cli todo get-field --todotxt-file 'test/resources/todo/todo.txt' completion" "ass_todo_get_field_completion_flag"

it "returns the priority"
export TODOTXT_FILE="$(readlink --canonicalize test/resources/todo/todo.txt)"
approve "$cli todo get-field priority" "ass_todo_get_field_priority_env"
unset TODOTXT_FILE
approve "$cli todo get-field --todotxt-file 'test/resources/todo/todo.txt' priority" "ass_todo_get_field_priority_flag"

it "returns the completion-date"
export TODOTXT_FILE="$(readlink --canonicalize test/resources/todo/todo.txt)"
approve "$cli todo get-field completion-date" "ass_todo_get_field_completion_date_env"
unset TODOTXT_FILE
approve "$cli todo get-field --todotxt-file 'test/resources/todo/todo.txt' completion-date" "ass_todo_get_field_completion_date_flag"

it "returns the creation-date"
export TODOTXT_FILE="$(readlink --canonicalize test/resources/todo/todo.txt)"
approve "$cli todo get-field creation-date" "ass_todo_get_field_creation_date_env"
unset TODOTXT_FILE
approve "$cli todo get-field --todotxt-file 'test/resources/todo/todo.txt' creation-date" "ass_todo_get_field_creation_date_flag"

it "returns the creation-date"
export TODOTXT_FILE="$(readlink --canonicalize test/resources/todo/todo.txt)"
approve "$cli todo get-field creation-date" "ass_todo_get_field_creation_date_env"
unset TODOTXT_FILE
approve "$cli todo get-field --todotxt-file 'test/resources/todo/todo.txt' creation-date" "ass_todo_get_field_creation_date_flag"

it "returns the description"
export TODOTXT_FILE="$(readlink --canonicalize test/resources/todo/todo.txt)"
approve "$cli todo get-field description" "ass_todo_get_field_description_env"
unset TODOTXT_FILE
approve "$cli todo get-field --todotxt-file 'test/resources/todo/todo.txt' description" "ass_todo_get_field_description_flag"

it "returns the project"
export TODOTXT_FILE="$(readlink --canonicalize test/resources/todo/todo.txt)"
approve "$cli todo get-field project" "ass_todo_get_field_project_env"
unset TODOTXT_FILE
approve "$cli todo get-field --todotxt-file 'test/resources/todo/todo.txt' project" "ass_todo_get_field_project_flag"

it "returns the context"
export TODOTXT_FILE="$(readlink --canonicalize test/resources/todo/todo.txt)"
approve "$cli todo get-field context" "ass_todo_get_field_context_env"
unset TODOTXT_FILE
approve "$cli todo get-field --todotxt-file 'test/resources/todo/todo.txt' context" "ass_todo_get_field_context_flag"

it "exits early when todo.txt is not readable"
testtodotxt="$(mktemp --tmpdir='/tmp' -- 'todo.txt.XXXX')"
chmod -r $testtodotxt
allow_diff '[0-9A-Za-z]{4}$'
approve "$cli todo get-field --todotxt-file $testtodotxt completion" "ass_todo_get_field_flag_notreadable"
