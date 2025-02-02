# Uso: make [all|clean|view]

TEX = pdflatex
TARGET = jorge_benavides-emebedded_engineer
BUILD_DIR = build

.PHONY: all clean view

all: $(TARGET).pdf

$(TARGET).pdf: $(TARGET).tex
	@mkdir -p $(BUILD_DIR)  # <-- TAB (no espacios)
	$(TEX) -output-directory=$(BUILD_DIR) $<  # <-- TAB
	$(TEX) -output-directory=$(BUILD_DIR) $<  # <-- TAB
	@mv $(BUILD_DIR)/$(TARGET).pdf .  # <-- TAB

clean:
	rm -rf $(BUILD_DIR)  # <-- TAB
	# rm -f $(TARGET).pdf
	rm -f *.aux *.log *.out *.toc *.bbl *.blg *.lof *.lot *.xwm

view: $(TARGET).pdf
	xdg-open $(TARGET).pdf 2>/dev/null || open $(TARGET).pdf 2>/dev/null

# Commit automático PRE-clean (¡cuidado!)
git-save:
	@echo "=== Guardando cambios en Git ==="
	git add .
	@if [ -n "$$(git status --porcelain)" ]; then \
		git commit -m "Update: $(shell date +'%Y-%m-%d %H:%M')"; \
	else \
		echo "No hay cambios para commitear"; \
	fi
	git pull origin main  # Cambia 'main' por tu rama

# Limpieza + Git (secuencia segura)
update: clean git-save
