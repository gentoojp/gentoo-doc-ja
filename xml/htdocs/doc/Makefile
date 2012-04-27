OPTS=-f xml \
	-o inline="<mail> <sup> <keyval> <b> <path> <c> <e> <uri> <i> <pre><comment> <brite>" \
	-o attributes="caption" \
	-o untranslated="<version> <date> <author> <mail> <values> <key>" \
	-o placeholder="<license>"
METADOC_OPTS=-f xml \
	-o untranslated="<version> <member> <memberof> <bug> <lead>"

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

pofiles/metadoc.po: en/metadoc.xml
	po4a-updatepo $(METADOC_OPTS) -m $< -p $@

ja/metadoc.xml: pofiles/metadoc.po
	-@mkdir -p $(TMPBUILD)/`dirname $@`
	-@touch $(TMPBUILD)/$@.members
	echo "PO4A-HEADER:mode=before;position=<categories>" \
		> $(TMPBUILD)/$@.members
	perl -ne '$$in_members=1 if(/<members>/);print if($$in_members);exit if(m!</members>!);' \
		< $@ >> $(TMPBUILD)/$@.members
	po4a-translate $(METADOC_OPTS) -k 100 \
		-m en/metadoc.xml -p $< -l $(TMPBUILD)/$@ -a $(TMPBUILD)/$@.members
	@test -e $(TMPBUILD)/$@ && mv _build/$@ $@

pofiles/%.po: en/%.xml
	$(PO4A_UPDATEPO) -m $< -p $@

ja/%.xml: pofiles/%.po
	-@mkdir -p $(TMPBUILD)/`dirname $@`
	-@touch $(TMPBUILD)/$@.author
	echo "PO4A-HEADER:mode=before;position=<abstract>" \
		> $(TMPBUILD)/$@.author
	$(GET_TRANSLATORS) < $@ >> $(TMPBUILD)/$@.author
	echo "PO4A-HEADER:mode=after;position=<date>;endboundary=</date>" \
		> $(TMPBUILD)/$@.origrev
	$(GET_ORIGREV) < $(subst ja/,en/,$@) >> $(TMPBUILD)/$@.origrev
	$(PO4A_TRANSLATE) -m $(subst ja/,en/,$@) -p $< -l $(TMPBUILD)/$@ \
		-a $(TMPBUILD)/$@.author -a $(TMPBUILD)/$@.origrev
	@test -e $(TMPBUILD)/$@ && mv _build/$@ $@

clean:
	rm -rf $(TMPBUILD)
