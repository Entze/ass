describe "todo put-tag"
it "puts due tag"
testtodo="$(mktemp --directory --tmpdir='/tmp' 'ass_todo_put_tag.XXXX')"
cp test/resources/todo/* "$testtodo/."
export TODOTXT_FILE="$testtodo/todo.txt"
approve "$cli todo put-tag due '1970-03-03'" "ass_todo_put_tag_due_env"
unset TODOTXT_FILE
approve "$cli todo put-tag --todotxt-file $testtodo/todo.txt due '1970-04-04'" "ass_todo_put_tag_due_flag"
it "rejects invalid input"
approve "$cli todo put-tag --todotxt-file $testtodo/todo.txt t ''" "ass_todo_put_tag_threshold_flag_empty"
approve "$cli todo put-tag --todotxt-file $testtodo/todo.txt aof 'invalid value'" "ass_todo_put_tag_aof_flag_invalidvalue"
approve "$cli todo put-tag --todotxt-file $testtodo/todo.txt 'invalid key' 'value'" "ass_todo_put_tag_invalidkey_flag_value"
it "exits early when todo.txt is not writeable"
testtodotxt="$(mktemp --tmpdir='/tmp' -- 'todo.txt.XXXX')"
chmod -w $testtodotxt
allow_diff '[0-9A-Za-z]{4}$'
approve "$cli todo put-tag --todotxt-file $testtodotxt due '1970-01-01'" "ass_todo_put_tag_due_flag_notwriteable"
