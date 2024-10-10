.PHONY: run test run-debug run-app-debug test-debug docker-run docker-debug docker-debug-test docker-stop

export PYTHONBREAKPOINT:=$(or $(PYTHONBREAKPOINT), 0)
export APP_HOST:=$(or $(APP_HOST), 0.0.0.0)
export APP_PORT:=$(or $(APP_PORT), 8008)
export DEBUG_PORT:=$(or $(DEBUG_PORT), 5678)

DOCKER_CMD_RUN = uvicorn app.main:app --host $(APP_HOST) --port $(APP_PORT) --reload
DOCKER_CMD_DEBUG = python -m debugpy --listen $(APP_HOST):$(DEBUG_PORT) --wait-for-client -m uvicorn app.main:app --host $(APP_HOST) --port $(APP_PORT) --reload
DOCKER_CMD_DEBUG_TEST = python -m debugpy --listen $(APP_HOST):$(DEBUG_PORT) --wait-for-client -m pytest -v tests/

run: # Run the app without debugging
	uvicorn app.main:app --host $(APP_HOST) --port $(APP_PORT) --reload

run-app-debug: # Run the app with PDB debugging
	PYTHONBREAKPOINT=pdb.set_trace uvicorn app.main:app --host $(APP_HOST) --port $(APP_PORT) --reload

test: # Run the tests
	pytest -v -s tests/

##################################################################################
# Run commands inside docker containers
##################################################################################

docker-run: # Run the app inside a docker container
	DOCKER_CMD="$(DOCKER_CMD_RUN)" docker-compose up --build

docker-debug: # Run the app inside a docker container in debug mode
	DOCKER_CMD="$(DOCKER_CMD_DEBUG)" docker-compose up --build

docker-debug-test: # Run the tests inside a docker container in debug mode
	DOCKER_CMD="$(DOCKER_CMD_DEBUG_TEST)" docker-compose up --build

docker-stop: # Stop the docker containers
	docker-compose down
