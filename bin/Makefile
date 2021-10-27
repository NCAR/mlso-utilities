.PHONY: install

PREFIX=$(HOME)
DUSK_PREFIX=/export/data1/$(HOME)
SCP_OPTIONS=-i /home/mgalloy/.ssh/id_rsa2

install:
	cp *.sh $(PREFIX)/bin
	cp hpss $(PREFIX)/bin
	cp compare_hpss_dirs $(PREFIX)/bin
	cp mlso-archiverd $(PREFIX)/bin
	cp mlso-archiver.cfg $(PREFIX)/bin
	cp check_clock*.sh $(PREFIX)/bin
	scp $(SCP_OPTIONS) check_clock*.sh kodiak.mlso.ucar.edu:$(PREFIX)/bin
	scp $(SCP_OPTIONS) check_clock*.sh dusk.mlso.ucar.edu:$(DUSK_PREFIX)/bin
	cp log_clocks.sh $(PREFIX)/bin
	scp $(SCP_OPTIONS) log_clocks.sh kodiak.mlso.ucar.edu:$(PREFIX)/bin
	scp $(SCP_OPTIONS) log_clocks.sh dusk.mlso.ucar.edu:$(DUSK_PREFIX)/bin
	cp plot_clocks $(PREFIX)/bin
	cp olog2pdf.sh $(PREFIX)/bin
	cp yesterday_olog2pdf.sh $(PREFIX)/bin
