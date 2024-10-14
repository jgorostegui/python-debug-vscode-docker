# Mastering Python Debugging: Leveraging VS Code, Docker, and pdb

This repository accompanies the article ["Mastering Python Debugging: Leveraging VS Code, Docker, and pdb"](https://medium.com/@jgorostegui/mastering-python-debugging-leveraging-vs-code-docker-and-pdb-2e06b65d4667) and provides a practical example of how to debug a FastAPI application using Visual Studio Code (VS Code), both locally and within a Docker container.

## Features

* **FastAPI example application:** A simple FastAPI application with basic CRUD operations for managing items.
* **Dockerized environment:**  Dockerfile and docker-compose.yaml for running the application in a containerized environment.
* **Debugging configurations:** VS Code launch.json configurations for local and remote debugging.
* **Makefile:**  Helper scripts for running the application, tests, and debugging sessions.
* **Tests:**  pytest test suite for verifying the functionality of the application.

## Getting Started

1. **Clone the repository:**

   ```bash
   https://github.com/jgorostegui/python-debug-vscode-docker
   cd python-debug-vscode-docker
   ```

2. **Install dependencies:**

   ```bash
   pip install -r requirements.txt
   ```

3. **Run the application locally:**

   ```bash
   make run-app
   ```


5. **Explore the debugging configurations in `.vscode/launch.json` and follow the instructions in the article to debug the application.**

## Testing using curl commands

1. **Create an item:**

   ```bash
   curl -X POST http://localhost:8008/items -H "Content-Type: application/json" -d '{"name": "Example Item", "price": 19.99}'
   ```

2. **Get all items:**

   ```bash
   curl -X GET "http://localhost:8000/items/" -H  "accept: application/json"
   ```

## Debugging

This repository provides examples of how to debug the FastAPI application using VS Code and `pdb` (Python Debugger).

### VS Code Debugging

* **Local debugging:**  Use the "Python: FastAPI (local)" configuration in `launch.json` to debug the application running locally.
* **Remote debugging (Docker):** Use the "Python: Remote Attach" configuration in `launch.json` to debug the application running inside a Docker container.

### pdb Debugging

* Insert `breakpoint()` statements in your Python code where you want to pause execution and enter pdb.
* Use pdb commands to inspect variables, step through code, and analyze program behavior.
