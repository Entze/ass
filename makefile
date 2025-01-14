DEPS := $(wildcard src/*_command.sh) $(wildcard lib/*) $(wildcard src/*.yml) $(wildcard src/**/*.yml)

ass: settings.yml $(DEPS)
	bashly generate
