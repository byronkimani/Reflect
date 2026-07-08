.PHONY: gen test clean get lint run-dev run-prod watch coverage coverage-check format fix run prepare-env build-prod-apk deps-outdated deps-check deps-upgrade

# ----------------------------------------------------------------------
# Code Generation
# ----------------------------------------------------------------------

# Run build_runner to generate code (Freezed, JsonSerializable, etc.)
# Usage: make gen
gen:
	dart run build_runner build --delete-conflicting-outputs

# Watch for changes and re-generate code automatically (useful during dev)
# Usage: make watch
watch:
	dart run build_runner watch --delete-conflicting-outputs

# ----------------------------------------------------------------------
# Testing & Quality
# ----------------------------------------------------------------------

# Run all unit and widget tests
# Usage: make test
test: prepare-env-testing
	flutter test

# Generate a coverage report (requires lcov installed)
# Usage: make coverage
coverage: prepare-env-testing
	flutter test --coverage
	lcov --remove coverage/lcov.info '*.g.dart' '*.freezed.dart' '*firebase_options.dart' '*/l10n/*' '*/tables/*' '*/main.dart' -o coverage/lcov.info --ignore-errors unused,empty
	genhtml coverage/lcov.info -o coverage/html
	@lcov --summary coverage/lcov.info | grep lines || true
	@if [ "$$SKIP_COVERAGE_OPEN" != "1" ]; then open coverage/html/index.html; fi

# Print filtered line coverage (run after make coverage)
coverage-check:
	lcov --summary coverage/lcov.info 2>&1 | grep lines

# Analyze code for linting errors
# Usage: make lint
lint:
	flutter analyze --fatal-infos --fatal-warnings

# Fix lint issues automatically (Great for solo devs)
# Usage: make fix
fix:
	dart fix --apply

# Format code
# Usage: make format
format:
	dart format .

# ----------------------------------------------------------------------
# Maintenance
# ----------------------------------------------------------------------

# Clean the project and get dependencies
# Usage: make clean
clean:
	flutter clean
	flutter pub get

# Just get dependencies
# Usage: make get
get:
	flutter pub get

# List packages with available updates (informational)
# Usage: make deps-outdated
deps-outdated:
	dart pub outdated

# Upgrade direct dependencies to the latest versions allowed by pubspec.yaml
# Usage: make deps-upgrade
deps-upgrade:
	dart pub upgrade
	@echo ""
	@echo "Upgraded packages in pubspec.lock. Next: make gen (if codegen deps changed), make lint, make test"

# Fail when direct dependencies are behind within pubspec constraints
# Usage: make deps-check
deps-check:
	dart run tool/check_outdated_deps.dart

# ----------------------------------------------------------------------
# Environment
# ----------------------------------------------------------------------

prepare-env-testing:
	chmod +x tool/prepare_env.sh
	./tool/prepare_env.sh testing

prepare-env-production:
	chmod +x tool/prepare_env.sh
	./tool/prepare_env.sh production

# ----------------------------------------------------------------------
# Running the App (Flavors)
# ----------------------------------------------------------------------

# Run the app (Shortcut for run-dev)
# Usage: make run
run: run-dev

# Run the app in Testing flavor (Default)
# Usage: make run-dev
run-dev: prepare-env-testing
	flutter run --dart-define=ENV=testing

# Run the app in Production flavor
# Usage: make run-prod
run-prod: prepare-env-production
	flutter run --dart-define=ENV=production

# Build obfuscated production APK
# Usage: make build-prod-apk
build-prod-apk: prepare-env-production
	flutter build apk --release \
		--obfuscate \
		--split-debug-info=build/debug-info \
		--dart-define=ENV=production
