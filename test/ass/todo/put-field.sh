
describe "todo put-field"
it "puts the completion status"
testtodo="$(mktemp --directory --tmpdir='/tmp' 'ass_todo_put_field.XXXX')"
cp test/resources/todo/* "$testtodo/."
export TODOTXT_FILE="$testtodo/todo.txt"
approve "$cli todo put-field completion 'true' :2 3 6:7 11:+2 18:" "ass_todo_put_field_completion_env"
approve "cat $TODOTXT_FILE" "ass_todo_put_field_completion_change"
unset TODOTXT_FILE
approve "$cli todo put-field --todotxt-file $testtodo/todo.txt completion 'false' :4 6 9:10 13:+2 17:" "ass_todo_put_field_completion_flag"
it "rejects invalid input"
approve "$cli todo put-field --todotxt-file $testtodo/todo.txt completion 'non-existent'" "ass_todo_put_field_completion_flag_nonexistent"


it "puts the priority"
testtodo="$(mktemp --directory --tmpdir='/tmp' 'ass_todo_put_field.XXXX')"
cp test/resources/todo/* "$testtodo/."
export TODOTXT_FILE="$testtodo/todo.txt"
approve "$cli todo put-field priority 'A'" "ass_todo_put_field_priority_env"
unset TODOTXT_FILE
approve "$cli todo put-field --todotxt-file $testtodo/todo.txt priority 'Z'" "ass_todo_put_field_priority_flag"
it "rejects invalid input"
approve "$cli todo put-field --todotxt-file $testtodo/todo.txt priority 'non-existent'" "ass_todo_put_field_priority_flag_nonexistent"
approve "$cli todo put-field --todotxt-file $testtodo/todo.txt priority ''" "ass_todo_put_field_priority_flag_empty"

it "puts the completion date"
testtodo="$(mktemp --directory --tmpdir='/tmp' 'ass_todo_put_field.XXXX')"
cp test/resources/todo/* "$testtodo/."
export TODOTXT_FILE="$testtodo/todo.txt"
approve "$cli todo put-field completion-date '1970-06-06'" "ass_todo_put_field_completion_date_env"
unset TODOTXT_FILE
approve "$cli todo put-field --todotxt-file $testtodo/todo.txt completion-date '1970-07-07'" "ass_todo_put_field_completion_date_flag"
it "rejects invalid input"
approve "$cli todo put-field --todotxt-file $testtodo/todo.txt completion-date 'non-existent'" "ass_todo_put_field_completion_date_flag_nonexistent"
approve "$cli todo put-field --todotxt-file $testtodo/todo.txt completion-date ''" "ass_todo_put_field_completion_date_flag_empty"

it "puts the creation date"
testtodo="$(mktemp --directory --tmpdir='/tmp' 'ass_todo_put_field.XXXX')"
cp test/resources/todo/* "$testtodo/."
export TODOTXT_FILE="$testtodo/todo.txt"
approve "$cli todo put-field creation-date '1970-08-08'" "ass_todo_put_field_creation_date_env"
unset TODOTXT_FILE
approve "$cli todo put-field --todotxt-file $testtodo/todo.txt creation-date '1970-09-09'" "ass_todo_put_field_creation_date_flag"
it "rejects invalid input"
approve "$cli todo put-field --todotxt-file $testtodo/todo.txt creation-date 'non-existent'" "ass_todo_put_field_creation_date_flag_nonexistent"
approve "$cli todo put-field --todotxt-file $testtodo/todo.txt creation-date ''" "ass_todo_put_field_creation_date_flag_empty"

it "puts the description"
testtodo="$(mktemp --directory --tmpdir='/tmp' 'ass_todo_put_field.XXXX')"
cp test/resources/todo/* "$testtodo/."
export TODOTXT_FILE="$testtodo/todo.txt"
approve "$cli todo put-field description 'Scratch that I want to make pancakes @errands aof:home'" "ass_todo_put_field_description_env"
unset TODOTXT_FILE
approve "$cli todo put-field --todotxt-file $testtodo/todo.txt description ''" "ass_todo_put_field_description_flag"

it "puts the project"
testtodo="$(mktemp --directory --tmpdir='/tmp' 'ass_todo_put_field.XXXX')"
cp test/resources/todo/* "$testtodo/."
export TODOTXT_FILE="$testtodo/todo.txt"
approve "$cli todo put-field project 'project'" "ass_todo_put_field_project_env"
unset TODOTXT_FILE
approve "$cli todo put-field --todotxt-file $testtodo/todo.txt project 'alt-project'" "ass_todo_put_field_project_flag"
it "rejects invalid input"
approve "$cli todo put-field --todotxt-file $testtodo/todo.txt project ''" "ass_todo_put_field_project_flag_empty"
approve "$cli todo put-field --todotxt-file $testtodo/todo.txt project 'invalid project'" "ass_todo_put_field_project_flag_invalid"

it "puts the context"
testtodo="$(mktemp --directory --tmpdir='/tmp' 'ass_todo_put_field.XXXX')"
cp test/resources/todo/* "$testtodo/."
export TODOTXT_FILE="$testtodo/todo.txt"
approve "$cli todo put-field context 'context'" "ass_todo_put_field_context_env"
unset TODOTXT_FILE
approve "$cli todo put-field --todotxt-file $testtodo/todo.txt context 'alt-context'" "ass_todo_put_field_context_flag"
it "rejects invalid input"
approve "$cli todo put-field --todotxt-file $testtodo/todo.txt context ''" "ass_todo_put_field_context_flag_empty"
approve "$cli todo put-field --todotxt-file $testtodo/todo.txt context 'invalid context'" "ass_todo_put_field_context_flag_invalid"

it "exits early when todo.txt is not writeable"
testtodotxt="$(mktemp --tmpdir='/tmp' -- 'todo.txt.XXXX')"
chmod -w $testtodotxt
allow_diff '[0-9A-Za-z]{4}$'
approve "$cli todo put-field --todotxt-file $testtodotxt completion 'true'" "ass_todo_put_field_flag_notwriteable"

