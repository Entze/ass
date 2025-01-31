describe "pkd proj"
it "can list the projects"
export PKD_DIR=$(readlink --canonicalize 'test/resources/pkd')
approve "$cli pkd proj ls" "ass_pkd_proj_ls_env"
unset PKD_DIR
approve "$cli pkd proj ls --pkd-dir='test/resources/pkd'" "ass_pkd_proj_ls_flag"

it "exits early on nonexisting PKD or PROJECTS"
export PKD_DIR=$(readlink --canonicalize 'does/not/exist')
approve "$cli pkd proj ls" "ass_pkd_proj_ls_env_nonexisting"
unset PKD_DIR
approve "$cli pkd proj ls --pkd-dir='does/not/exist'" "ass_pkd_proj_ls_flag_nonexisting"
