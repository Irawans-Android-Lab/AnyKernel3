DEVICE := $(shell echo ${DEVICE})
KERNAME := $(shell echo ${KERNAME})

NAME := ${KERNAME}-$(CODENAME)-$(DEVICE)
DATE := $(shell date "+%Y%m%d-%H%M%S")
ZIP := $(NAME)-$(DATE).zip
EXCLUDE := Makefile *.git* *.jar* *placeholder* *.md*

normal: $(ZIP)

$(ZIP):
	sed -i 's/universal/${DEVICE}/g' anykernel.sh
	zip -r9 "$@" . -x $(EXCLUDE)
	echo "Done creating ZIP: $(ZIP)"

clean:
	@rm -vf *.zip*
	@rm -vf *.gz-dtb*
	@rm -vf modules/vendor/lib/modules/*.ko
	echo "Cleaning done."
