#
#
#               Ezanvakti 7.2 Makefile
#
#

SHELL          = /bin/bash
DESTDIR        =
AD             = ezanvakti
SURUM          = $(shell cat VERSION)
DUZELTME       = $(shell git log -1 --pretty=format:'%ad' --abbrev-commit --date=short 2>/dev/null | tr -d -- '-')
PREFIX         = /usr/local
INSTALL        = /usr/bin/env install
SED            = /bin/sed

bindir         = $(PREFIX)/bin
libdir         = $(PREFIX)/lib
sysconfdir     = $(PREFIX)/etc
datadir        = $(PREFIX)/share
completionsdir = $(PREFIX)/share/bash-completion/completions
mandir         = $(PREFIX)/share/man
sounddir       = $(PREFIX)/share/sounds
icondir        = $(PREFIX)/share/icons/hicolor
appdeskdir     = $(PREFIX)/share/applications

ifeq "$(DUZELTME)" ""
	DUZELTME = $(shell date +%Y%m%d)
endif

BETIKLER = ezanvakti.bash lib/temel_islevler.bash lib/arayuz.bash \
	lib/arayuz2.bash lib/arayuz3.bash lib/ezanvakti-sleep \
	lib/ucbirim_tui.bash data/ezanvakti.desktop data/ayarlar

all: $(BETIKLER)

$(BETIKLER): ${BETIKLER:=.in}
	@echo '	YAP' $@
	@$(SED) -e 's:@AD@:$(AD):g' \
		-e 's:@SURUM@:$(SURUM):' \
		-e 's:@DUZELTME@:$(DUZELTME):' \
		-e 's:@bindir@:$(bindir):' \
		-e 's:@datadir@:$(datadir):' \
		-e 's:@libdir@:$(libdir):' \
		-e 's:@sysconfdir@:$(sysconfdir):' \
		-e 's:@sounddir@:$(sounddir):' \
	$@.in > $@

install: $(BETIKLER)
	$(INSTALL) -vd $(DESTDIR)$(bindir)
	$(INSTALL) -vd $(DESTDIR)$(libdir)/$(AD)
	$(INSTALL) -vd $(DESTDIR)$(sysconfdir)
	$(INSTALL) -vd $(DESTDIR)$(datadir)/$(AD)/{veriler,mealler,simgeler,ulkeler{,/TÜRKİYE,/ABD,/ALMANYA,/KANADA}_ilceler}
	$(INSTALL) -vd $(DESTDIR)$(sounddir)/$(AD)
	$(INSTALL) -vd $(DESTDIR)$(completionsdir)
	$(INSTALL) -vd $(DESTDIR)$(mandir)/man{1,5}
	$(INSTALL) -vd $(DESTDIR)$(appdeskdir)
	$(INSTALL) -vd $(DESTDIR)$(icondir)/{16x16,22x22,32x32,48x48,64x64,96x96}/apps

	$(INSTALL) -vm755 ezanvakti.bash $(DESTDIR)$(bindir)/$(AD)
	$(INSTALL) -vm755 lib/ezanvakti-sleep $(DESTDIR)$(libdir)/$(AD)/$(AD)-sleep
	$(INSTALL) -vm755 data/ezanvakti.desktop $(DESTDIR)$(appdeskdir)/$(AD).desktop

	$(INSTALL) -vm644 data/ayarlar $(DESTDIR)$(sysconfdir)/$(AD).conf
	$(INSTALL) -vm644 data/ezanvakti_completion $(DESTDIR)$(completionsdir)/$(AD)
	# man
	$(INSTALL) -vm644 doc/ezanvakti.1 $(DESTDIR)$(mandir)/man1/$(AD).1
	$(INSTALL) -vm644 doc/ezanvakti-ayarlar.5 $(DESTDIR)$(mandir)/man5/$(AD)-ayarlar.5

	for l in lib/*.bash; \
	do \
		$(INSTALL) -vm755 $$l $(DESTDIR)$(libdir)/$(AD); \
	done

	for v in data/veriler/*; \
	do \
		$(INSTALL) -vm644 "$$v" $(DESTDIR)$(datadir)/$(AD)/veriler; \
	done

	for i in data/ulkeler/*; \
	do \
		[[ -d "$$i" ]] && continue; \
		$(INSTALL) -vm644 "$$i" $(DESTDIR)$(datadir)/$(AD)/ulkeler; \
	done

	for s in data/ulkeler/TÜRKİYE_ilceler/*; \
	do \
		$(INSTALL) -vm644 "$$s" $(DESTDIR)$(datadir)/$(AD)/ulkeler/TÜRKİYE_ilceler; \
	done

	for u in data/ulkeler/ABD_ilceler/*; \
	do \
		$(INSTALL) -vm644 "$$u" $(DESTDIR)$(datadir)/$(AD)/ulkeler/ABD_ilceler; \
	done

	for a in data/ulkeler/ALMANYA_ilceler/*; \
	do \
		$(INSTALL) -vm644 "$$a" $(DESTDIR)$(datadir)/$(AD)/ulkeler/ALMANYA_ilceler; \
	done

	for k in data/ulkeler/KANADA_ilceler/*; \
	do \
		$(INSTALL) -vm644 "$$k" $(DESTDIR)$(datadir)/$(AD)/ulkeler/KANADA_ilceler; \
	done

	for e in  ezanlar/*.ogg; \
	do \
		$(INSTALL) -vm644 $$e $(DESTDIR)$(sounddir)/$(AD); \
	done

	for m in 16 22 32 48 64 96; \
	do \
		$(INSTALL) -vm644 data/simgeler/ezanvakti"$$m".png $(DESTDIR)$(icondir)/$$m"x"$$m/apps/$(AD).png; \
	done

	for t in data/mealler/*; \
	do \
		$(INSTALL) -vm644 $$t $(DESTDIR)$(datadir)/$(AD)/mealler; \
	done

uninstall:
	@rm -f  $(DESTDIR)$(bindir)/$(AD)
	@rm -rf $(DESTDIR)$(libdir)/$(AD)
	@rm -rf $(DESTDIR)$(datadir)/$(AD)
	@rm -rf $(DESTDIR)$(sounddir)/$(AD)
	@rm -f  $(DESTDIR)$(sysconfdir)/$(AD).conf
	@rm -f  $(DESTDIR)$(completionsdir)/$(AD)
	@rm -f  $(DESTDIR)$(mandir)/man1/$(AD).1*
	@rm -f  $(DESTDIR)$(mandir)/man5/$(AD)-ayarlar.5*
	@rm -f  $(DESTDIR)$(appdeskdir)/$(AD).desktop
	@rm -f  $(DESTDIR)$(icondir)/{16x16,22x22,32x32,48x48,64x64,96x96}/apps/$(AD).png

	@echo "$(AD) başarıyla sisteminizden kaldırıldı.."

clean:
	rm -f $(BETIKLER)

dist:
	@echo "Kaynak kod paketi oluşturuluyor. Lütfen bekleyiniz..."
	@git archive master | xz > $(AD)-$(SURUM).$(DUZELTME).tar.xz
	@echo "İşlem tamamlandı. ----------> $(AD)-$(SURUM).$(DUZELTME).tar.xz"


.PHONY: all clean dist install uninstall
