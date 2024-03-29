PDFS = inlay-qbus.pdf inlay-unibus.pdf inlay-rk11-c.pdf inlay-rp11.pdf inlay-rk11-f.pdf
PNGS = inlay-qbus.png inlay-unibus.png inlay-rk11-f.png inlay-rp11.png
EPS = inlay-qbus.eps inlay-rk11-f.eps

all: $(PDFS) $(PNGS)
eps: $(EPS)
push: all
	rsync --verbose --progress $(PDFS) server:pdp10/qsic
	rsync --verbose --progress $(PNGS) server:pdp10/qsic/html

inlay-qbus-poster.ps: inlay-qbus.ps
	poster -m letter -s 1 -o $@ $<

inlay-rk11-f-poster.ps: inlay-rk11-f.ps
	poster -m letter -s 1 -o $@ $<

clean:
	rm inlay-*.ps inlay-*.eps inlay-*.pdf inlay-*.png

.SUFFIXES: .svg .pdf .ps .png .eps

.svg.pdf:
	inkscape --export-filename=$@ $<

.svg.png:
	inkscape --export-filename=$@ $<

.svg.eps:
	inkscape --export-text-to-path --export-eps=$@ $<

.pdf.ps:
	pdf2ps $< $@
