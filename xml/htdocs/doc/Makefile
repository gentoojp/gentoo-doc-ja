TOPDIR=../../..
include $(TOPDIR)/base.mk

METADOC_OPTS=-f xml \
	-o untranslated="<version> <member> <memberof> <bug> <lead>"

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
