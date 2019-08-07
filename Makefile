
BINS=wtrunner

.PHONY: all install tests

all:
	@echo ""
	@echo "make install"
	@echo "make tests"

install : 
	@echo "- $(@) --------------------------------------------------------------"
	@echo "  ... install bins in /usr/local/bin, via ln"
	@for b in $(BINS); do \
		echo "    ... install $$b"; \
		ln -f -s $(CURDIR)/bin/$$b /usr/local/bin/$$b; \
		done

tests : 
	@echo "- $(@) --------------------------------------------------------------"
	./tests/all
