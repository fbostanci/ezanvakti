#
#
#               Ezanvakti 6.0 Makefile
#
#

SHELL = /bin/bash
surum = $(shell cat VERSION)
derleme = $(shell git log -1 --pretty=format:'%ad' --abbrev-commit --date=short 2>/dev/null | tr -d -- '-')

INSTALL = install
SED = sed

PREFIX = /usr/local

bindir = $(PREFIX)/bin
libdir = $(PREFIX)/lib
mandir = $(PREFIX)/share/man
sysconfdir = $(PREFIX)/etc
completiondir = ${sysconfdir}/bash_completion.d
datadir = $(PREFIX)/share
sounddir = $(PREFIX)/share/sounds
appdeskdir = $(PREFIX)/share/applications

ifeq "$(derleme)" ""
	derleme = bilinmeyen
endif

all:
		@echo "Nothing to make, use 'make install' to perform an installation."


clean:
		@rm -f ezanvakti 2>/dev/null
		@rm -f lib/temel_islevler.bash 2>/dev/null
		@rm -f lib/ezanvakti-sleep.bash 2>/dev/null
		@rm -f lib/ezanvakti-crontab.bash 2>/dev/null
		@rm -f etc/ayarlar 2>/dev/null
		@rm -f data/ezanvakti.desktop 2>/dev/null
		@rm -f etc/autostart/ezanvakti.desktop 2>/dev/null


config: clean
		@$(SED) -e 's:@derleme@:$(derleme):' \
				-e 's:@datadir@:$(datadir):' \
				-e 's:@libdir@:$(libdir):' \
				-e 's:@sysconfdir@:$(sysconfdir):' \
			lib/temel_islevler.bash.in > lib/temel_islevler.bash

		@$(SED) 's:@libdir@:$(libdir):' \
			ezanvakti.bash.in > ezanvakti

		@$(SED) 's:@libdir@:$(libdir):' \
			lib/ezanvakti-sleep.bash.in > lib/ezanvakti-sleep.bash

		@$(SED) -e 's:@surum@:$(surum):' \
				-e 's:@sounddir@:$(sounddir):' \
			etc/ayarlar.in > etc/ayarlar

		@$(SED) -e 's:@bindir@:$(bindir):' \
				-e 's:@datadir@:$(datadir):' \
			data/ezanvakti.desktop.in > data/ezanvakti.desktop

		@$(SED) 's:@bindir@:$(bindir):' \
			etc/autostart/ezanvakti.desktop.in > etc/autostart/ezanvakti.desktop

install: config
		$(INSTALL) -vDm644 etc/ayarlar $(DESTDIR)$(sysconfdir)/ezanvakti/ayarlar
		$(INSTALL) -vDm644 etc/bash_completion/ezanvakti $(DESTDIR)$(completiondir)/ezanvakti
		$(INSTALL) -vDm644 etc/autostart/ezanvakti.desktop $(DESTDIR)$(sysconfdir)/xdg/autostart/ezanvakti.desktop

#		$(INSTALL) -vDm755 etc/ezanvakti-pm $(DESTDIR)$(sysconfdir)/pm/sleep.d/ezanvakti-pm
		$(INSTALL) -vDm755 ezanvakti $(DESTDIR)$(bindir)/ezanvakti

		$(INSTALL) -vDm755 data/ezanvakti.desktop $(DESTDIR)$(appdeskdir)/ezanvakti.desktop
		$(INSTALL) -vDm644 ezanvakti_man/ezanvakti.1 $(DESTDIR)$(mandir)/man1/ezanvakti.1
		$(INSTALL) -vDm644 ezanvakti_man/ezanvakti-ayarlar.5 $(DESTDIR)$(mandir)/man5/ezanvakti-ayarlar.5

		$(INSTALL) -vd $(DESTDIR)$(datadir)/ezanvakti/{veriler,tefsirler,simgeler,ulkeler{,/TURKIYE_ilceler,/ABD_ilceler}}
		$(INSTALL) -vd $(DESTDIR)$(libdir)/ezanvakti


		for l in  lib/*.bash; \
		do \
			l_dosya=$$(basename $$l); \
			$(INSTALL) -vm755 $$l $(DESTDIR)$(libdir)/ezanvakti/$$l_dosya; \
		done

		$(INSTALL) -vm755 lib/ezanveri_istemci.pl $(DESTDIR)$(libdir)/ezanvakti/ezanveri_istemci.pl

		$(INSTALL) -vm644 data/veriler/bilgiler $(DESTDIR)$(datadir)/ezanvakti/veriler/bilgiler
		$(INSTALL) -vm644 data/veriler/esma $(DESTDIR)$(datadir)/ezanvakti/veriler/esma
		$(INSTALL) -vm644 data/veriler/gunler $(DESTDIR)$(datadir)/ezanvakti/veriler/gunler
		$(INSTALL) -vm644 data/veriler/kirk-hadis $(DESTDIR)$(datadir)/ezanvakti/veriler/kirk-hadis
		$(INSTALL) -vm644 data/veriler/sureler_ayetler $(DESTDIR)$(datadir)/ezanvakti/veriler/sureler_ayetler
		$(INSTALL) -vm644 data/veriler/sure_bilgisi $(DESTDIR)$(datadir)/ezanvakti/veriler/sure_bilgisi


		for i in  data/ulkeler/*; \
		do \
			i_dosya="$$(basename "$$i")"; \
			$(INSTALL) -vm644 "$$i" $(DESTDIR)$(datadir)/ezanvakti/ulkeler/"$$i_dosya"; \
		done
		
		for s in  data/ulkeler/TURKIYE_ilceler/*; \
		do \
			s_dosya="$$(basename "$$s")"; \
			$(INSTALL) -vm644 "$$s" $(DESTDIR)$(datadir)/ezanvakti/ulkeler/TURKIYE_ilceler/"$$s_dosya"; \
		done

		for u in  data/ulkeler/ABD_ilceler/*; \
		do \
			u_dosya="$$(basename "$$u")"; \
			$(INSTALL) -vm644 "$$u" $(DESTDIR)$(datadir)/ezanvakti/ulkeler/ABD_ilceler/"$$u_dosya"; \
		done

		for t in  data/tefsirler/*; \
		do \
			t_dosya=$$(basename $$t); \
			$(INSTALL) -vm644 $$t $(DESTDIR)$(datadir)/ezanvakti/tefsirler/$$t_dosya; \
		done

		$(INSTALL) -vm644 data/simgeler/ezanvakti.png $(DESTDIR)$(datadir)/ezanvakti/simgeler/ezanvakti.png
		$(INSTALL) -vm644 data/simgeler/ezanvakti2.png $(DESTDIR)$(datadir)/ezanvakti/simgeler/ezanvakti2.png

uninstall:
		@rm -rf $(DESTDIR)$(sysconfdir)/ezanvakti
#		@rm -f  $(DESTDIR)$(sysconfdir)/pm/sleep.d/ezanvakti-pm
		@rm -f  $(DESTDIR)$(completiondir)/ezanvakti
		@rm -f  $(DESTDIR)$(sysconfdir)/xdg/autostart/ezanvakti.desktop
		@rm -f  $(DESTDIR)$(bindir)/ezanvakti
		@rm -rf $(DESTDIR)$(libdir)/ezanvakti
		@rm -rf $(DESTDIR)$(datadir)/ezanvakti
		@rm -f  $(DESTDIR)$(appdeskdir)/ezanvakti.desktop
		@rm -f  $(DESTDIR)$(mandir)/man1/ezanvakti.1*
		@rm -f  $(DESTDIR)$(mandir)/man5/ezanvakti-ayarlar.5*
		@echo "ezanvakti başarıyla sisteminizden kaldırıldı.."

dist:
		@echo "Kaynak kod paketi oluşturuluyor. Lütfen bekleyiniz..."
		@git archive master | xz > ezanvakti-devel-$(surum).$(derleme).tar.xz
		@echo "İşlem tamamlandı. ----------> ezanvakti-devel-$(surum).$(derleme).tar.xz"


.PHONY: all clean config dist install uninstall
