DEPS := $(wildcard src/*_command.sh) $(wildcard lib/*)

ass: $(DEPS)
	bashly generate
