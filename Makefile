PRJ = Taishan-SES

DCFILE = DC-$(PRJ)

LANGUAGES = en zh_CN

DAPS_FLAGS = -d $(DCFILE) --force --adocattr="lang=$$l" --builddir=build/$$l

ADOCS = $(wildcard adoc/*.adoc)

IMAGES = $(wildcard adoc/images/*)

EXAMPLES = $(wildcard adoc/examples/*)

SRCS = $(ADOCS) $(IMAGES) $(EXAMPLES)

.PHONY : all clean dist prep pdf html check-file check-link check-spell check

all : dist

pdf : $(SRCS) prep
	for l in $(LANGUAGES); do \
		daps $(DAPS_FLAGS) pdf; \
	done;

html : $(SRCS) prep
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

dist : html pdf
	mkdir -p dist
	@for l in $(LANGUAGES); do \
		cp -a build/$$l/$(PRJ)/single-html/$(PRJ) dist/$$l; \
		cp -a build/$$l/$(PRJ)/$(PRJ)_color_$$l.pdf dist/$$l/$(PRJ)_$$l.pdf; \
	done;

clean :
	-daps clean-all
	rm -rf build dist