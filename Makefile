EMACS ?= emacs
EASK ?= eask

.PHONY: build_packages test-install generate_badges_system generate_archive_json generate_badges_version generate_badges_downloads

build_packages:
	@echo "Building packages..."
	@$(EASK) install-deps
	@$(EASK) load "./scripts/build-packages.el" --allow-error

test-install:
	@echo "Building packages..."
	./test/install/run.sh

generate_eld:
	@echo "Generating elpa-packages.eld file..."
	@$(EASK) load "./scripts/generate-eld.el"

generate_archive_json:
	@echo "Generating archive.json file..."
	@$(EASK) load "./scripts/generate-archive-json.el"

generate_badges_system:
	@echo "Generating system badges.."
	@$(EASK) load "./scripts/generate-badges-system.el"

generate_badge_packages:
	@echo "Generating packages badge.."
	@$(EASK) load "./scripts/generate-badge-packages.el"

generate_badges_version:
	@echo "Generating version badges.."
	@$(EASK) load "./scripts/generate-badges-version.el"

generate_badges_downloads:
	@echo "Generating downloads badges.."
	@$(EASK) load "./scripts/generate-badges-downloads.el"
