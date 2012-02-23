OPTS=-f xml \
	-o inline="<mail> <sup> <keyval> <b> <path> <c> <e> <uri> <i> <pre><comment>" \
	-o attributes="caption" \
	-o untranslated="<version> <date> <author> <mail> <values> <key>" \
	-o placeholder="<license>"

PO4A_UPDATEPO=po4a-updatepo -f xml $(OPTS)
PO4A_TRANSLATE=po4a-translate -f xml $(OPTS) -L UTF-8
XMLFILES=$(wildcard ja/*.xml ja/*/*.xml)
TMPBUILD=_build

all: $(XMLFILES)
update:
	(cd en; cvs up -dP)
	$(MAKE)

pofiles/%.po: en/%.xml
	$(PO4A_UPDATEPO) -m $< -p $@

ja/%.xml: pofiles/%.po
	-@mkdir -p $(TMPBUILD)/`dirname $@`
	$(PO4A_TRANSLATE) -m $(subst ja/,en/,$@) -p $< -l $(TMPBUILD)/$@
	@test -e $(TMPBUILD)/$@ && mv _build/$@ $@

clean:
	rm -rf $(TMPBUILD)
