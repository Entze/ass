DEPS := $(wildcard src/*_command.sh) $(wildcard src/lib/*.sh) $(wildcard src/lib/**/*.sh) $(wildcard src) $(wildcard src/*.yml) $(wildcard src/**/*.yml)

ass: settings.yml $(DEPS)
	bashly generate
