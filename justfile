default:
    @just --list

build:
    make ass

test:
    ./test/approve

lint: lint-shell

lint-shell +TARGET="src/*_command.sh":
    shellcheck -s bash {{TARGET}}

alias fmt := format

format:
    fdfind --type file --extension yml --extension yaml --exec just format-yaml "{}"

format-yaml TARGET:
    yq --prettyPrint --inplace {{TARGET}}
