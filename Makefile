include Makefile.local

ifndef EFI-UUID
errorefi:
	echo "error: set EFI-UUID in Makefile"; false
endif

ifndef CFG-UUID
errorcfg:
	echo "error: set CFG-UUID in Makefile"; false
endif
all: ${IMAGE}



IMAGE=grubx86.efi

all: $(IMAGE)

early.cfg: early.cfg.tmpl
	sed "s,CFG-UUID,$(CFG-UUID)," $< > $@

grubx86.efi: early.cfg modules.txt
	grub-mkimage -O x86_64-efi -p /boot/grub	\
		-c early.cfg				\
		-o $@					\
		$$(<modules.txt)

install: all
	mount UUID=$(EFI-UUID) /mnt/efi
	[ -d /mnt/efi/EFI/test ] || mkdir /mnt/efi/EFI/test
	cp $(IMAGE) /mnt/efi/EFI/test/
	umount /mnt/efi

clean:
	rm -f ${IMAGE} early.cfg

distclean: clean
	rm -f Makefile.local

