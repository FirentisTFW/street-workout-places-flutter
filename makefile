.DEFAULT_GOAL := help

build_android: ## Builds apk
	$(prefix) flutter build apk --target lib/main.dart

files: ## Runs flutter build runner command
	$(prefix) flutter packages pub run build_runner build --delete-conflicting-outputs
	
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'