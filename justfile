default:
    @just --list

build:
    make ass

test:
    ./test/approve

lint:
    fdfind --type file --extension sh --exclude .flox --exclude .git --exec just lint-shell "{}"
    fdfind --type file --extension yml --extension yaml --exclude .flox --exclude .git --exec just lint-yaml "{}"

lint-shell +TARGET:
    shellcheck -s bash {{TARGET}}

lint-yaml +TARGET:
    yamllint {{TARGET}}

alias fmt := format

format:
    fdfind --type file --extension yml --extension yaml --exclude .flox --exclude .git --exec just format-yaml "{}"

format-yaml TARGET:
    yq --prettyPrint --inplace {{TARGET}}
