
describe "pkd aof"
it "can list the areas-of-focus"
export PKD_DIR=$(readlink --canonicalize 'test/resources/pkd')
approve "$cli pkd aof ls" "ass_pkd_aof_ls_env"
unset PKD_DIR
approve "$cli pkd aof ls --pkd-dir='test/resources/pkd'" "ass_pkd_aof_ls_flag"

it "exits early on nonexisting PKD or AREAS"
export PKD_DIR="does/not/exist"
approve "$cli pkd aof ls" "ass_pkd_aof_ls_env_nonexisting"
unset PKD_DIR
approve "$cli pkd aof ls --pkd-dir='does/not/exist'" "ass_pkd_aof_ls_flag_nonexisting"
