DIRS=xml/htdocs/doc xml/htdocs/proj
report:
	@test -z "$$(git ls-files -m)" || (echo "Please commit/revert your local change. (see: git status)" ;exit 1)
	@git checkout tmp/report || git checkout -b tmp/report
	@(for x in $(DIRS);do LANG=C make -B -C $$x -k 2>&1| perl scripts/report_pre.pl $$x; done; \
		git checkout -- . 1>&2; git checkout - 1>&2; git branch -D tmp/report) |\
	 	perl scripts/report.pl
