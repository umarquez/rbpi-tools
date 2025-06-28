.PHONY: setup deps fastfetch go sonic-pi starship pisound test lint clean

setup: deps fastfetch go sonic-pi starship pisound
	@echo "========================="
	@echo "Configuring"
	@echo "-------------------------"
	bash ./scripts/config/config.sh
	@echo "========================="

deps:
	@echo "========================="
	@echo "Installing dependencies"
	@echo "-------------------------"
	sudo apt update
	sudo apt install -y git cmake build-essential libpci-dev libvulkan-dev libgl1-mesa-dev libdrm-dev screen shellcheck libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev libgl1-mesa-dev libasound2-dev
	@echo "========================="

fastfetch:
	@echo "========================="
	@echo "Installing fastfetch"
	@echo "-------------------------"
	bash ./scripts/fastfetch/setup.sh
	@echo "========================="

go:
	@echo "========================="
	@echo "Installing go"
	@echo "-------------------------"
	VERSION=1.24.4 ARCH=arm64 bash ./scripts/go/setup.sh
	@echo "========================="

sonic-pi:
	@echo "========================="
	@echo "Installing Sonic Pi"
	@echo "-------------------------"
	bash ./scripts/sonic-pi/install.sh
	@echo "========================="

starship:
	@echo "========================="
	@echo "Installing starship"
	@echo "-------------------------"
	bash ./scripts/starship/install.sh
	@echo "➡️  Starship instalado. Configura el prompt con 'make setup' o reinicia tu sesión."
	@echo "========================="

pisound:
	@echo "========================="
	@echo "Installing Pisound"
	@echo "-------------------------"
	bash ./scripts/pisound/setup.sh
	@echo "========================="


test:
	bats tests

lint:
	@echo "📊 Linting shell scripts con shellcheck y shfmt"
	@find scripts -type f -name '*.sh' | xargs shellcheck
	@find scripts -type f -name '*.sh' | xargs shfmt -d -i 2

clean:
	rm -rf fastfetch sonic-pi_4.5.1_1_bookworm.arm64.deb fastfetch*.tar.gz *.tar.gz *.deb build go*.tar.gz
