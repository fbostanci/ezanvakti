#
#
#               Ezanvakti 6.2 Makefile
#
#

SHELL         = /bin/bash
DESTDIR       =
AD            = ezanvakti
SURUM         = $(shell cat VERSION)
DUZELTME      = $(shell git log -1 --pretty=format:'%ad' --abbrev-commit --date=short 2>/dev/null | tr -d -- '-')
PREFIX        = /usr/local
INSTALL       = /usr/bin/env install
SED           = /bin/sed

bindir        = $(PREFIX)/bin
libdir        = $(PREFIX)/lib
sysconfdir    = $(PREFIX)/etc
datadir       = $(PREFIX)/share
completiondir = $(PREFIX)/share/bash-completion/completions
mandir        = $(PREFIX)/share/man
sounddir      = $(PREFIX)/share/sounds
appdeskdir    = $(PREFIX)/share/applications
autostartdir  = $(sysconfdir)/xdg/autostart


ifeq "$(DUZELTME)" ""
	DUZELTME = bilinmeyen
endif

BETIKLER = ezanvakti.bash lib/temel_islevler.bash lib/arayuz.bash \
	lib/arayuz2.bash lib/ezanvakti-sleep.bash data/ezanvakti.desktop \
	etc/ayarlar etc/autostart/ezanvakti.desktop

all: $(BETIKLER)

$(BETIKLER): ${BETIKLER:=.in}
	@echo '	YAP' $@
	@$(SED) -e 's:@AD@:$(AD):' \
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
	$(INSTALL) -vd $(DESTDIR)$(sysconfdir)/$(AD)
	$(INSTALL) -vd $(DESTDIR)$(datadir)/$(AD)/{veriler,tefsirler,simgeler,ulkeler{,/TURKIYE_ilceler,/ABD_ilceler,/KANADA_ilceler}}
	$(INSTALL) -vd $(DESTDIR)$(sounddir)/$(AD)
	$(INSTALL) -vd $(DESTDIR)$(completiondir)
	$(INSTALL) -vd $(DESTDIR)$(mandir)/man{1,5}
	$(INSTALL) -vd $(DESTDIR)$(appdeskdir)
	$(INSTALL) -vd $(DESTDIR)$(autostartdir)

	$(INSTALL) -vm755 ezanvakti.bash $(DESTDIR)$(bindir)/$(AD)
	$(INSTALL) -vm755 lib/ezanveri_istemci.pl $(DESTDIR)$(libdir)/$(AD)/ezanveri_istemci.pl
	$(INSTALL) -vm755 data/ezanvakti.desktop $(DESTDIR)$(appdeskdir)/$(AD).desktop

	$(INSTALL) -vm644 etc/ayarlar $(DESTDIR)$(sysconfdir)/$(AD)/ayarlar
	$(INSTALL) -vm644 etc/bash_completion/ezanvakti $(DESTDIR)$(completiondir)/$(AD)
	$(INSTALL) -vm644 etc/autostart/ezanvakti.desktop $(DESTDIR)$(autostartdir)/$(AD).desktop
	# man
	$(INSTALL) -vm644 doc/ezanvakti.1 $(DESTDIR)$(mandir)/man1/$(AD).1
	$(INSTALL) -vm644 doc/ezanvakti-ayarlar.5 $(DESTDIR)$(mandir)/man5/$(AD)-ayarlar.5
	# simgeler
	$(INSTALL) -vm644 data/simgeler/ezanvakti.png $(DESTDIR)$(datadir)/$(AD)/simgeler/ezanvakti.png
	$(INSTALL) -vm644 data/simgeler/ezanvakti2.png $(DESTDIR)$(datadir)/$(AD)/simgeler/ezanvakti2.png

	for l in lib/*.bash; \
	do \
		l_dosya="$$(basename $$l)"; \
		$(INSTALL) -vm755 $$l $(DESTDIR)$(libdir)/$(AD)/$$l_dosya; \
	done

	for v in data/veriler/*; \
	do \
		v_dosya="$$(basename "$$v")"; \
		$(INSTALL) -vm644 "$$v" $(DESTDIR)$(datadir)/$(AD)/veriler/"$$v_dosya"; \
	done

	for i in data/ulkeler/*; \
	do \
		i_dosya="$$(basename "$$i")"; \
		$(INSTALL) -vm644 "$$i" $(DESTDIR)$(datadir)/$(AD)/ulkeler/"$$i_dosya"; \
	done

	for s in data/ulkeler/TURKIYE_ilceler/*; \
	do \
		s_dosya="$$(basename "$$s")"; \
		$(INSTALL) -vm644 "$$s" $(DESTDIR)$(datadir)/$(AD)/ulkeler/TURKIYE_ilceler/"$$s_dosya"; \
	done

	for u in data/ulkeler/ABD_ilceler/*; \
	do \
		u_dosya="$$(basename "$$u")"; \
		$(INSTALL) -vm644 "$$u" $(DESTDIR)$(datadir)/$(AD)/ulkeler/ABD_ilceler/"$$u_dosya"; \
	done

	for k in data/ulkeler/KANADA_ilceler/*; \
	do \
		k_dosya="$$(basename "$$k")"; \
		$(INSTALL) -vm644 "$$k" $(DESTDIR)$(datadir)/$(AD)/ulkeler/KANADA_ilceler/"$$k_dosya"; \
	done

	for e in  ezanlar/*.ogg; \
	do \
		e_dosya=$$(basename $$e); \
		$(INSTALL) -vm644 $$e $(DESTDIR)$(sounddir)/$(AD)/$$e_dosya; \
	done

	for t in data/tefsirler/*; \
	do \
		t_dosya=$$(basename $$t); \
		$(INSTALL) -vm644 $$t $(DESTDIR)$(datadir)/$(AD)/tefsirler/$$t_dosya; \
	done

uninstall:
	@rm -f  $(DESTDIR)$(bindir)/$(AD)
	@rm -rf $(DESTDIR)$(libdir)/$(AD)
	@rm -rf $(DESTDIR)$(datadir)/$(AD)
	@rm -rf $(DESTDIR)$(sysconfdir)/$(AD)
	@rm -rf $(DESTDIR)$(sounddir)/$(AD)
	@rm -f  $(DESTDIR)$(completiondir)/$(AD)
	@rm -f  $(DESTDIR)$(autostartdir)/$(AD).desktop
	@rm -f  $(DESTDIR)$(mandir)/man1/$(AD).1*
	@rm -f  $(DESTDIR)$(mandir)/man5/$(AD)-ayarlar.5*
	@rm -f  $(DESTDIR)$(appdeskdir)/$(AD).desktop

	@echo "$(AD) başarıyla sisteminizden kaldırıldı.."

clean:
	rm -f $(BETIKLER)

dist:
	@echo "Kaynak kod paketi oluşturuluyor. Lütfen bekleyiniz..."
	@git archive master | xz > $(AD)-$(SURUM).$(DUZELTME).tar.xz
	@echo "İşlem tamamlandı. ----------> $(AD)-$(surum).$(duzeltme).tar.xz"


.PHONY: all clean dist install uninstall
