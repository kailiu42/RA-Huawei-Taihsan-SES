DCFILE = DC-Taishan5280

DAPS_FLAGS = -d $(DCFILE)

ADOCS = $(wildcard adoc/*.adoc)

IMAGES = $(wildcard adoc/images/*)

EXAMPLES = $(wildcard adoc/examples/*)

SRCS = $(ADOCS) $(IMAGES) $(EXAMPLES)

.PHONY : all clean pdf html html-single check-file check-link check-spell check

all : pdf

pdf : $(SRCS)
	daps $(DAPS_FLAGS) pdf

html : $(SRCS)
	daps $(DAPS_FLAGS) html

html-single : $(SRCS)
	daps $(DAPS_FLAGS) html --single

check-file :
	daps $(DAPS_FLAGS) list-srcfiles-unused
	daps $(DAPS_FLAGS) list-images-missing
	daps $(DAPS_FLAGS) list-images-multisrc

check-spell :
	daps $(DAPS_FLAGS) spellcheck --list --lang=en_US

check : check-file check-spell

clean :
	-daps clean-all