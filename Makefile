.PHONY: gen test clean get lint run-dev run-prod watch coverage format fix run

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
test:
	flutter test

# Generate a coverage report (requires lcov installed)
# Usage: make coverage
coverage:
	flutter test --coverage
	genhtml coverage/lcov.info -o coverage/html
	open coverage/html/index.html

# Analyze code for linting errors
# Usage: make lint
lint:
	flutter analyze

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

# ----------------------------------------------------------------------
# Running the App (Flavors)
# ----------------------------------------------------------------------

# Run the app (Shortcut for run-dev)
# Usage: make run
run: run-dev

# Run the app in Testing flavor (Default)
# Usage: make run-dev
run-dev:
	flutter run --dart-define=ENV=testing

# Run the app in Production flavor
# Usage: make run-prod
run-prod:
	flutter run --dart-define=ENV=production