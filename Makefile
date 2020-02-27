DCFILE = DC-Taishan5280

LANGUAGES = en zh_CN

DAPS_FLAGS = -d $(DCFILE) --force --adocattr="lang=$$l" --builddir=build/$$l

ADOCS = $(wildcard adoc/*.adoc)

IMAGES = $(wildcard adoc/images/*)

EXAMPLES = $(wildcard adoc/examples/*)

SRCS = $(ADOCS) $(IMAGES) $(EXAMPLES)

.PHONY : all clean prep pdf html html-single check-file check-link check-spell check

all : html-single

pdf : $(SRCS) prep
	for l in $(LANGUAGES); do \
		daps $(DAPS_FLAGS) pdf; \
	done;

html : $(SRCS) prep
	for l in $(LANGUAGES); do \
		daps $(DAPS_FLAGS) html; \
	done;

html-single : $(SRCS) prep
	for l in $(LANGUAGES); do \
		daps $(DAPS_FLAGS) html --single; \
	done;

check-file : prep
	for l in $(LANGUAGES); do \
		daps $(DAPS_FLAGS) list-srcfiles-unused; \
		daps $(DAPS_FLAGS) list-images-missing; \
		daps $(DAPS_FLAGS) list-images-multisrc; \
	done;

check-spell : prep
	for l in $(LANGUAGES); do \
		daps $(DAPS_FLAGS) spellcheck --list --lang=$$l; \
	done;

check : check-file check-spell

prep :
	@for l in $(LANGUAGES); do \
		mkdir -p build/$$l; \
	done;

clean :
	-daps clean-all