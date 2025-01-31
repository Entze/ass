describe "todo delete"
it "can delete the 1st entry"

testtodo="$(mktemp --directory --tmpdir='/tmp' 'ass_todo_delete.XXXX')"
cp test/resources/todo/* "$testtodo/."

$cli todo delete --todotxt-file "$testtodo/todo.txt" 1
approve "cat $testtodo/todo.txt" "ass_todo_delete_1"

it "exits early if todo.txt is not writeable"
testtodotxt="$(mktemp --tmpdir='/tmp' -- 'todo.txt.XXXX')"
chmod -w $testtodotxt
allow_diff '[0-9A-Za-z]{4}$'
approve "$cli todo delete --todotxt-file $testtodotxt '1'" "ass_todo_delete_flag_notwriteable"

it "cannot delete a line that doesn't exist"
approve "$cli todo delete --todotxt-file $testtodo/todo.txt '10000'" "ass_todo_delete_nonexistententry"
