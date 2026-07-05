# Uso: make [all|clean|view|git-save|update]

TEX       = pdflatex
TARGET    = jorge_benavides-emebedded_engineer
MAIN      = main
BUILD_DIR = build
SECTIONS  = $(wildcard sections/*.tex)

.PHONY: all clean view git-save update

all: $(TARGET).pdf

$(TARGET).pdf: $(MAIN).tex config.tex $(SECTIONS)
	@mkdir -p $(BUILD_DIR)
	$(TEX) -output-directory=$(BUILD_DIR) -jobname=$(TARGET) $(MAIN).tex
	$(TEX) -output-directory=$(BUILD_DIR) -jobname=$(TARGET) $(MAIN).tex
	@mv $(BUILD_DIR)/$(TARGET).pdf .

clean:
	rm -rf $(BUILD_DIR)
	rm -f *.aux *.log *.out *.toc *.bbl *.blg *.lof *.lot *.xwm

view: $(TARGET).pdf
	xdg-open $(TARGET).pdf 2>/dev/null || open $(TARGET).pdf 2>/dev/null

# Commit automático
git-save:
	@echo "=== Guardando cambios en Git ==="
	git add .
	@if [ -n "$$(git status --porcelain)" ]; then \
		git commit -m "Update: $(shell date +'%Y-%m-%d %H:%M')"; \
	else \
		echo "No hay cambios para commitear"; \
	fi
	git pull origin main
	git push origin main

# Limpieza + Git
update: clean git-save
