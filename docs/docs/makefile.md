# Amaia Makefile Guide

The Amaia project uses a `Makefile` to automate setup, development, build, test, publish, documentation, and cleanup tasks. This guide explains each command (target) in simple terms, comparing them to setting up and running a business office. The Makefile ensures tasks are reproducible and efficient, like a one-click setup for a complex office system.

## Project Context
Amaia is a modular GitHub template for building AI-powered knowledge base applications. It includes a frontend (Deno, Next.js, CopilotKit) for user interaction, a backend (FastAPI, LangGraph, LangChain) for AI processing, and a documentation site (`mkdocs-material`) for guides and specifications. The Makefile supports the specs-driven development approach outlined in `docs/specs.md`, automating tasks for the modular structure.

## Makefile Targets

### `make setup`
**Purpose**: Installs all dependencies for the frontend, backend, and documentation, like setting up computers, servers, and manuals for a new office.

**Details**:
- Installs frontend dependencies using `npm install` in `frontend/`.
- Sets up the backend virtual environment and installs dependencies using `uv` in `backend/`.
- Installs `mkdocs-material` for documentation in `docs/`.
- Checks for successful installation to prevent errors.

**Usage**:
```bash
make setup
```

**Outcome**: The project is ready for development, with all tools and libraries installed.

---

### `make run-frontend`
**Purpose**: Starts the frontend development server, like opening the office doors for customers to interact with the user interface.

**Details**:
- Runs `npm run dev` in `frontend/` to start the Next.js development server.
- Accessible at `http://localhost:3000`.

**Usage**:
```bash
make run-frontend
```

**Outcome**: Developers can test and interact with the frontend UI in real-time.

---

### `make run-backend`
**Purpose**: Starts the backend development server, like powering up the server room to process data.

**Details**:
- Activates the backend virtual environment and runs `uvicorn` in `backend/` to start the FastAPI server.
- Accessible at `http://localhost:8000`.

**Usage**:
```bash
make run-backend
```

**Outcome**: The backend APIs are available for processing AI requests and database operations.

---

### `make run-docs`
**Purpose**: Starts the documentation server, like sharing the user manual online for employees to read.

**Details**:
- Runs `mkdocs serve` in `docs/` to start the `mkdocs-material` server.
- Accessible at `http://localhost:8000`.

**Usage**:
```bash
make run-docs
```

**Outcome**: Developers and users can view the documentation site, including the project specifications (`specs.md`).

---

### `make build-frontend`
**Purpose**: Compiles frontend code, like assembling office furniture for use.

**Details**:
- Runs `lerna run build` in `frontend/` to compile the core (`@amaia/core`) and plugin packages (e.g., `@amaia/knowledge-base-editor`).
- Generates Deno-compatible modules using `denoify`.
- Includes error checking to ensure successful compilation.

**Usage**:
```bash
make build-frontend
```

**Outcome**: Frontend packages are compiled and ready for publishing or deployment.

---

### `make build-backend`
**Purpose**: Compiles backend packages, like packaging server software for distribution.

**Details**:
- Runs `uv build` in `backend/core` for the core package (`amaia-backend-core`).
- Iterates through `backend/plugins/*` to build each plugin (e.g., `amaia-search-agent`).
- Includes error checking for each build.

**Usage**:
```bash
make build-backend
```

**Outcome**: Backend packages are built and ready for publishing to PyPI.

---

### `make build-docs`
**Purpose**: Builds the documentation site, like printing a polished user manual.

**Details**:
- Runs `mkdocs build` in `docs/` to generate a static site in `docs/site`.
- Includes error checking to ensure successful build.

**Usage**:
```bash
make build-docs
```

**Outcome**: A static documentation site is generated, ready for deployment.

---

### `make test`
**Purpose**: Runs tests to ensure everything works, like testing office equipment and server connections.

**Details**:
- Runs frontend tests using `npm test` in `frontend/`.
- Runs backend tests using `pytest` in `backend/`.
- Ensures 90% code coverage as per the project specifications.
- Includes error checking to report test failures.

**Usage**:
```bash
make test
```

**Outcome**: Confirms that all features (Knowledge Base Editor, Search Agent, etc.) work as specified.

---

### `make publish-frontend`
**Purpose**: Publishes frontend packages to npm, like shipping office products to customers.

**Details**:
- Runs `lerna bootstrap`, `lerna run build`, and `lerna publish` in `frontend/` to publish core and plugin packages.
- Generates Deno-compatible modules using `denoify` for the core package.
- Requires npm authentication (`npm login`).
- Includes error checking for authentication or build failures.

**Usage**:
```bash
make publish-frontend
```

**Outcome**: Frontend packages (e.g., `@amaia/core`, `@amaia/knowledge-base-editor`) are available on npm.

---

### `make publish-backend`
**Purpose**: Publishes backend packages to PyPI, like distributing server software to clients.

**Details**:
- Runs `uv build` and `uv publish` in `backend/core` for the core package (`amaia-backend-core`).
- Iterates through `backend/plugins/*` to publish each plugin (e.g., `amaia-search-agent`).
- Requires PyPI authentication (`uv publish --token <your-pypi-token>`).
- Includes error checking for authentication or build failures.

**Usage**:
```bash
make publish-backend
```

**Outcome**: Backend packages are available on PyPI for other developers to use.

---

### `make deploy-docs`
**Purpose**: Deploys documentation to GitHub Pages, like sharing the user manual publicly.

**Details**:
- Runs `mkdocs gh-deploy` in `docs/` to deploy the static site to GitHub Pages.
- Requires GitHub Pages to be enabled in the repository settings.
- Includes error checking to ensure successful deployment.

**Usage**:
```bash
make deploy-docs
```

**Outcome**: The documentation site, including `specs.md`, is publicly accessible via GitHub Pages.

---

### `make clean`
**Purpose**: Removes temporary files, like resetting the office to a blank slate for a fresh start.

**Details**:
- Removes `frontend/node_modules`, `backend/.venv`, `backend/uv.lock`, `docs/site`, `__pycache__`, `dist`, and `*.egg-info` directories.
- Ensures a clean environment for rebuilding or troubleshooting.

**Usage**:
```bash
make clean
```

**Outcome**: The project is reset, removing all generated files and dependencies.

---

## Alignment with Amaia Project
- **Specs-Driven Development**: The Makefile automates tasks defined in `docs/specs.md`, ensuring setup, development, and publishing align with the project’s requirements.
- **Modularity**: Supports the modular structure by handling core (`@amaia/core`, `amaia-backend-core`) and plugin packages separately.
- **Frontend**: Uses Lerna for monorepo management and `denoify` for Deno compatibility, as specified.
- **Backend**: Uses `uv` for dependency management and publishing, ensuring Pyodide compatibility for WebAssembly.
- **Documentation**: Integrates with `mkdocs-material` to make specifications and guides accessible.
- **Error Handling**: Each target includes checks (e.g., for `node_modules`, `.venv`, or command availability) to provide clear feedback, like a progress report during office setup.

## Usage Instructions
Place the Makefile in the root directory (`amaia/Makefile`) and run commands from the project root:

```bash
# Setup everything
make setup

# Run development servers
make run-frontend
make run-backend
make run-docs

# Build packages
make build-frontend
make build-backend
make build-docs

# Run tests
make test

# Publish packages
make publish-frontend
make publish-backend

# Deploy documentation
make deploy-docs

# Clean up
make clean
```
