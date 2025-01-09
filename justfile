default:
    @just --list

build:
    make ass

test:
    ./test/approve
