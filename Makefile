.PHONY: run test run-debug run-app-debug test-debug docker-run docker-debug docker-debug-test docker-stop

export PYTHONBREAKPOINT:=$(or $(PYTHONBREAKPOINT), 0)

help: ## Show this help message
	@echo 'Usage:'
	@echo '  make [target]'
	@echo
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# Local Development Commands

run-script: ## Run the script
	python src/text_adventure.py

run-script-debug: ## Run the script in debug mode
	PYTHONBREAKPOINT=pdb.set_trace python -m pdb src/text_adventure.py

run-app: ## Run the application locally (no debug)
	uvicorn app.main:app --host 0.0.0.0 --port 8008 --reload

run-app-debug: ## Run the application locally with debugger
	python -m debugpy --listen 0.0.0.0:5678 --wait-for-client -m uvicorn app.main:app --host 0.0.0.0 --port 8008 --reload

test: ## Run tests locally
	pytest -v tests/

test-debug: ## Run tests locally with debugger
	python -m debugpy --listen 0.0.0.0:5678 --wait-for-client -m pytest -v tests/

##################################################################################
# Run commands inside docker containers
##################################################################################

docker-run: ## Run the application in Docker
	docker-compose -f docker-compose.base.yml up --build

docker-debug: ## Debug the application in Docker
	docker-compose -f docker-compose.debug.yml up --build

docker-test-debug: ## Debug tests in Docker
	docker-compose -f docker-compose.test-debug.yml up --build

clean: ## Clean up Docker resources
	docker-compose -f docker-compose.base.yml down
	docker-compose -f docker-compose.debug.yml down
	docker-compose -f docker-compose.test.yml down
