default:
    @just --list

build:
    make ass

test:
    ./test/approve

lint +TARGET="src/*_command.sh":
    shellcheck -s bash {{TARGET}}
