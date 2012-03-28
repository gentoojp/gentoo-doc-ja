OPTS=-f xml \
	-o inline="<mail> <sup> <keyval> <b> <path> <c> <e> <uri> <i> <pre><comment>" \
	-o attributes="caption" \
	-o untranslated="<version> <date> <author> <mail> <values> <key>" \
	-o placeholder="<license>"

SCRIPTS_DIR=scripts
PO4A_UPDATEPO=po4a-updatepo -f xml $(OPTS)
PO4A_TRANSLATE=po4a-translate -f xml $(OPTS) -L UTF-8 -k 100
GET_TRANSLATORS=$(SCRIPTS_DIR)/get_translators.pl
GET_ORIGREV=$(SCRIPTS_DIR)/get_rev.pl

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
	-@touch $(TMPBUILD)/$@.author
	if fgrep -q '<abstract>' $(subst ja/,en/,$@); then \
		echo "PO4A-HEADER:mode=before;position=<abstract>" \
			> $(TMPBUILD)/$@.author; \
		$(GET_TRANSLATORS) < $@ >> $(TMPBUILD)/$@.author; \
		else rm -f $(TMPBUILD)/$@.author; fi
	echo "PO4A-HEADER:mode=after;position=<date>;endboundary=</date>" \
		> $(TMPBUILD)/$@.origrev
	$(GET_ORIGREV) < $(subst ja/,en/,$@) >> $(TMPBUILD)/$@.origrev
	$(PO4A_TRANSLATE) -m $(subst ja/,en/,$@) -p $< -l $(TMPBUILD)/$@ \
		$(shell test -e $(TMPBUILD)/$@.author && echo -a $(TMPBUILD)/$@.author) \
		-a $(TMPBUILD)/$@.origrev
	@test -e $(TMPBUILD)/$@ && mv _build/$@ $@

clean:
	rm -rf $(TMPBUILD)
