DEVICE := $(shell echo ${DEVICE})
KERNAME := $(shell echo ${KERNAME})
BRANCH := $(shell git -C .. rev-parse --abbrev-ref HEAD)

ifeq ($(findstring 10,$(BRANCH)),10)
	ACNAME := Q
else ifeq ($(findstring 9,$(BRANCH)),9)
	ACNAME := PIE
else ifeq ($(findstring 8,$(BRANCH)),8)
	ACNAME := Oreo
else
	ACNAME := universal
endif

ifeq ($(findstring eas,$(BRANCH)),eas)
	VARIANT := EAS
else
	VARIANT := HMP
endif

NAME := ${KERNAME}-${VARIANT}-${ACNAME}-$(DEVICE)
DATE := $(shell date "+%Y%m%d-%H-%M-%S")
ZIP := $(NAME)-$(DATE).zip
EXCLUDE := Makefile *.git* *.jar* *placeholder* *.md*
ifeq ($(findstring eas,$(BRANCH)),eas)
EXCLUDE += system_root
endif

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
