DEVICE := $(shell echo ${DEVICE})
KERNAME := $(shell echo ${KERNAME})
BRANCH := $(shell git symbolic-ref -q HEAD)

ifeq ($(findstring 10,$(BRANCH)),10)
	ACNAME := Q
else ifeq ($(findstring 9,$(BRANCH)),9)
	ACNAME := PIE
else
	ACNAME := universal
endif

NAME := ${KERNAME}-${ACNAME}-$(DEVICE)
DATE := $(shell date "+%Y%m%d")
ZIP := $(NAME)-$(DATE).zip
EXCLUDE := Makefile *.git* *.jar* *placeholder* *.md*

normal: $(ZIP)

$(ZIP):
	sed -i 's/universal/${DEVICE}-${VARIANT}/g' anykernel.sh
	zip -r9 "$@" . -x $(EXCLUDE)
	echo "Done creating ZIP: $(ZIP)"

clean:
	@rm -vf *.zip*
	@rm -vf *.gz-dtb*
	@rm -vf modules/vendor/lib/modules/*.ko
	echo "Cleaning done."
