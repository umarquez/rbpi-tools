.PHONY: setup deps fastfetch go sonic-pi starship test lint clean

setup: deps fastfetch go sonic-pi starship
	@echo "========================="
	@echo "Configuring"
	@echo "-------------------------"
	./scripts/config/config.sh
	@echo "========================="

deps:
	@echo "========================="
	@echo "Installing dependencies"
	@echo "-------------------------"
	sudo apt update
	sudo apt install -y git cmake build-essential libpci-dev libvulkan-dev libgl1-mesa-dev libdrm-dev screen git-delta shellcheck
	@echo "========================="

fastfetch:
	@echo "========================="
	@echo "Installing fastfetch"
	@echo "-------------------------"
	./scripts/fastfetch/setup.sh
	@echo "========================="

go:
	@echo "========================="
	@echo "Installing go"
	@echo "-------------------------"
	VERSION=1.24.4 ARCH=arm64 ./scripts/go/setup.sh
	@echo "========================="

sonic-pi:
	@echo "========================="
	@echo "Installing Sonic Pi"
	@echo "-------------------------"
	wget https://sonic-pi.net/files/releases/v4.5.1/sonic-pi_4.5.1_1_bookworm.arm64.deb
	sudo apt install ./sonic-pi_4.5.1_1_bookworm.arm64.deb
	rm sonic-pi_4.5.1_1_bookworm.arm64.deb
	@echo "========================="

starship:
	@echo "========================="
	@echo "Installing starship"
	@echo "-------------------------"
	curl -sS https://starship.rs/install.sh | sh -s -- -y
	@echo "➡️  Starship instalado. Configura el prompt con 'make setup' o reinicia tu sesión."
	@echo "========================="



test:
	bats tests

lint:
	@echo "📊 Linting shell scripts con shellcheck y shfmt"
	@find scripts -type f -name '*.sh' | xargs shellcheck
	@find scripts -type f -name '*.sh' | xargs shfmt -d -i 2

clean:
	rm -rf fastfetch sonic-pi_4.5.1_1_bookworm.arm64.deb fastfetch*.tar.gz *.tar.gz *.deb build
