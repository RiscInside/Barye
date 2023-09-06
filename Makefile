SOURCES = $(wildcard src/*.sml) $(wildcard src/*.mlb) $(wildcard src/**/*.sml) $(wildcard src/**/*.mlb)
SMLFMT = ./smlfmt/smlfmt

BUILD_DIR = ./build
MLTON_BIN = $(BUILD_DIR)/barye-mlton
POLYML_BIN = $(BUILD_DIR)/barye-polyml

ROOT = main.mlb

.PHONY: fmt mlton polyml repl clean

all: mlton polyml

mlton: $(MLTON_BIN)
polyml: $(POLYML_BIN)

$(SMLFMT):
	make -C smlfmt

fmt: $(SMLFMT)
	$(SMLFMT) --force $(ROOT)

$(MLTON_BIN): $(SOURCES)
	mkdir -p $(BUILD_DIR)
	mlton -output $(MLTON_BIN) $(ROOT)

$(POLYML_BIN): $(SOURCES)
	mkdir -p $(BUILD_DIR)
	./sml-buildscripts/polybuild $(ROOT) -o $(POLYML_BIN)
	$(RM) main

repl:
	./sml-buildscripts/polyrepl $(ROOT)

clean:
	$(RM) $(MLTON_BIN) $(POLYML_BIN)
