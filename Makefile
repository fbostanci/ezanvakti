#
#
#               Ezanvakti 6.0 Makefile
#
#

SHELL         = /bin/bash
surum         = $(shell cat VERSION)
duzeltme      = $(shell git log -1 --pretty=format:'%ad' --abbrev-commit --date=short 2>/dev/null | tr -d -- '-')
PREFIX        = /usr/local
INSTALL       = /usr/bin/env install
SED           = /bin/sed

bindir        = $(PREFIX)/bin
libdir        = $(PREFIX)/lib
sysconfdir    = $(PREFIX)/etc
completiondir = ${sysconfdir}/bash_completion.d
datadir       = $(PREFIX)/share
mandir        = ${datadir}/man
sounddir      = ${datadir}/sounds
appdeskdir    = ${datadir}/applications
autostartdir  = $(sysconfdir)/xdg/autostart


ifeq "$(duzeltme)" ""
	duzeltme = bilinmeyen
endif

SCRIPTS = ezanvakti.bash lib/temel_islevler.bash lib/arayuz.bash \
	lib/ezanvakti-sleep.bash data/ezanvakti.desktop \
	lib/ezanvakti-crontab.bash etc/ayarlar \
	etc/autostart/ezanvakti.desktop

all: $(SCRIPTS)

$(SCRIPTS): ${SCRIPTS:=.in}
	@echo '	GEN' $@
	@$(SED) -e 's:@surum@:$(surum):' \
		-e 's:@duzeltme@:$(duzeltme):' \
		-e 's:@datadir@:$(datadir):' \
		-e 's:@libdir@:$(libdir):' \
		-e 's:@sysconfdir@:$(sysconfdir):' \
	$@.in > $@

install: $(SCRIPTS)
	$(INSTALL) -vd $(DESTDIR)$(bindir)
	$(INSTALL) -vd $(DESTDIR)$(libdir)/ezanvakti
	$(INSTALL) -vd $(DESTDIR)$(sysconfdir)/ezanvakti
	$(INSTALL) -vd $(DESTDIR)$(datadir)/ezanvakti/{veriler,tefsirler,simgeler,ulkeler{,/TURKIYE_ilceler,/ABD_ilceler}}
	$(INSTALL) -vd $(DESTDIR)$(completiondir)
	$(INSTALL) -vd $(DESTDIR)$(mandir)/man{1,5}
	$(INSTALL) -vd $(DESTDIR)$(appdeskdir)
	$(INSTALL) -vd $(DESTDIR)$(autostartdir)

#	$(INSTALL) -vDm755 etc/ezanvakti-pm $(DESTDIR)$(sysconfdir)/pm/sleep.d/ezanvakti-pm
	$(INSTALL) -vm755 ezanvakti.bash $(DESTDIR)$(bindir)/ezanvakti
	$(INSTALL) -vm755 lib/ezanveri_istemci.pl $(DESTDIR)$(libdir)/ezanvakti/ezanveri_istemci.pl
	$(INSTALL) -vm755 data/ezanvakti.desktop $(DESTDIR)$(appdeskdir)/ezanvakti.desktop

	$(INSTALL) -vm644 etc/ayarlar $(DESTDIR)$(sysconfdir)/ezanvakti/ayarlar
	$(INSTALL) -vm644 etc/bash_completion/ezanvakti $(DESTDIR)$(completiondir)/ezanvakti
	$(INSTALL) -vm644 etc/autostart/ezanvakti.desktop $(DESTDIR)$(autostartdir)/ezanvakti.desktop
	# man
	$(INSTALL) -vm644 ezanvakti_man/ezanvakti.1 $(DESTDIR)$(mandir)/man1/ezanvakti.1
	$(INSTALL) -vm644 ezanvakti_man/ezanvakti-ayarlar.5 $(DESTDIR)$(mandir)/man5/ezanvakti-ayarlar.5
	# simgeler
	$(INSTALL) -vm644 data/simgeler/ezanvakti.png $(DESTDIR)$(datadir)/ezanvakti/simgeler/ezanvakti.png
	$(INSTALL) -vm644 data/simgeler/ezanvakti2.png $(DESTDIR)$(datadir)/ezanvakti/simgeler/ezanvakti2.png

	for l in lib/*.bash; \
	do \
		l_dosya=$$(basename $$l); \
		$(INSTALL) -vm755 $$l $(DESTDIR)$(libdir)/ezanvakti/$$l_dosya; \
	done

	for v in data/veriler/*; \
	do \
		v_dosya="$$(basename "$$v")"; \
		$(INSTALL) -vm644 "$$v" $(DESTDIR)$(datadir)/ezanvakti/veriler/"$$v_dosya"; \
	done

	for i in data/ulkeler/*; \
	do \
		i_dosya="$$(basename "$$i")"; \
		$(INSTALL) -vm644 "$$i" $(DESTDIR)$(datadir)/ezanvakti/ulkeler/"$$i_dosya"; \
	done

	for s in data/ulkeler/TURKIYE_ilceler/*; \
	do \
		s_dosya="$$(basename "$$s")"; \
		$(INSTALL) -vm644 "$$s" $(DESTDIR)$(datadir)/ezanvakti/ulkeler/TURKIYE_ilceler/"$$s_dosya"; \
	done

	for u in data/ulkeler/ABD_ilceler/*; \
	do \
		u_dosya="$$(basename "$$u")"; \
		$(INSTALL) -vm644 "$$u" $(DESTDIR)$(datadir)/ezanvakti/ulkeler/ABD_ilceler/"$$u_dosya"; \
	done

	for t in data/tefsirler/*; \
	do \
		t_dosya=$$(basename $$t); \
		$(INSTALL) -vm644 $$t $(DESTDIR)$(datadir)/ezanvakti/tefsirler/$$t_dosya; \
	done

uninstall:
	@rm -f  $(DESTDIR)$(bindir)/ezanvakti
	@rm -rf $(DESTDIR)$(libdir)/ezanvakti
	@rm -rf $(DESTDIR)$(datadir)/ezanvakti
	@rm -rf $(DESTDIR)$(sysconfdir)/ezanvakti
#	@rm -f  $(DESTDIR)$(sysconfdir)/pm/sleep.d/ezanvakti-pm
	@rm -f  $(DESTDIR)$(completiondir)/ezanvakti
	@rm -f  $(DESTDIR)$(autostartdir)/ezanvakti.desktop
	@rm -f  $(DESTDIR)$(mandir)/man1/ezanvakti.1*
	@rm -f  $(DESTDIR)$(mandir)/man5/ezanvakti-ayarlar.5*
	@rm -f  $(DESTDIR)$(appdeskdir)/ezanvakti.desktop

	@echo "ezanvakti başarıyla sisteminizden kaldırıldı.."

clean:
	rm -f $(SCRIPTS)

dist:
	@echo "Kaynak kod paketi oluşturuluyor. Lütfen bekleyiniz..."
	@git archive master | xz > ezanvakti-devel-$(surum).$(duzeltme).tar.xz
	@echo "İşlem tamamlandı. ----------> ezanvakti-devel-$(surum).$(duzeltme).tar.xz"


.PHONY: all clean dist install uninstall