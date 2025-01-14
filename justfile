default:
    @just --list

build:
    make ass

test:
    ./test/approve

lint: lint-shell lint-yaml

lint-shell +TARGET="src/*_command.sh":
    shellcheck -s bash {{TARGET}}

lint-yaml +TARGET=".":
    yamllint {{TARGET}}

alias fmt := format

format:
    fdfind --type file --extension yml --extension yaml --exclude .flox --exclude .git --exec just format-yaml "{}"

format-yaml TARGET:
    yq --prettyPrint --inplace {{TARGET}}
