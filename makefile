# Amaia Makefile
# Automates setup, development, build, test, publish, documentation, and cleanup tasks for the Amaia project

.PHONY: all setup run-frontend run-backend run-docs build-frontend build-backend build-docs test publish-frontend publish-backend deploy-docs clean

# Default target: setup everything
all: setup

# Setup all components (frontend, backend, documentation)
setup: setup-frontend setup-backend setup-docs
	@echo "Setup complete for Amaia project"

# Setup frontend dependencies
setup-frontend:
	@echo "Setting up frontend dependencies..."
	@cd frontend && npm install
	@if [ ! -d "frontend/node_modules" ]; then \
		echo "Error: Frontend setup failed. Check npm installation."; \
		exit 1; \
	fi
	@echo "Frontend setup complete"

# Setup backend dependencies
setup-backend:
	@echo "Setting up backend dependencies..."
	@cd backend && uv venv && source .venv/bin/activate && uv pip install .
	@if [ ! -d "backend/.venv" ]; then \
		echo "Error: Backend setup failed. Check uv installation."; \
		exit 1; \
	fi
	@echo "Backend setup complete"

# Setup documentation dependencies
setup-docs:
	@echo "Setting up documentation dependencies..."
	@cd docs && uv pip install mkdocs-material
	@if ! command -v mkdocs >/dev/null 2>&1; then \
		echo "Error: mkdocs-material installation failed."; \
		exit 1; \
	fi
	@echo "Documentation setup complete"

# Run frontend development server
run-frontend:
	@echo "Starting frontend development server..."
	@cd frontend && npm run dev

# Run backend development server
run-backend:
	@echo "Starting backend development server..."
	@cd backend && source .venv/bin/activate && uvicorn core.src.api.main:app --reload

# Run documentation server
run-docs:
	@echo "Starting documentation server..."
	@cd docs && mkdocs serve

# Build frontend packages
build-frontend:
	@echo "Building frontend packages..."
	@cd frontend && npx lerna run build
	@if [ $$? -ne 0 ]; then \
		echo "Error: Frontend build failed."; \
		exit 1; \
	fi
	@echo "Frontend build complete"

# Build backend packages
build-backend:
	@echo "Building backend core package..."
	@cd backend/core && uv build
	@if [ $$? -ne 0 ]; then \
		echo "Error: Backend core build failed."; \
		exit 1; \
	fi
	@echo "Building backend plugins..."
	@for dir in backend/plugins/*; do \
		if [ -d "$$dir" ]; then \
			cd $$dir && uv build; \
			if [ $$? -ne 0 ]; then \
				echo "Error: Build failed for $$dir"; \
				exit 1; \
			fi; \
			cd ../../..; \
		fi; \
	done
	@echo "Backend build complete"

# Build documentation site
build-docs:
	@echo "Building documentation site..."
	@cd docs && mkdocs build
	@if [ $$? -ne 0 ]; then \
		echo "Error: Documentation build failed."; \
		exit 1; \
	fi
	@echo "Documentation build complete"

# Run tests for frontend and backend
test:
	@echo "Running frontend tests..."
	@cd frontend && npm test
	@if [ $$? -ne 0 ]; then \
		echo "Error: Frontend tests failed."; \
		exit 1; \
	fi
	@echo "Running backend tests..."
	@cd backend && source .venv/bin/activate && pytest
	@if [ $$? -ne 0 ]; then \
		echo "Error: Backend tests failed."; \
		exit 1; \
	fi
	@echo "All tests passed"

# Publish frontend packages to npm
publish-frontend:
	@echo "Publishing frontend packages to npm..."
	@cd frontend && npx lerna bootstrap && npx lerna run build && npx lerna publish --conventional-commits
	@if [ $$? -ne 0 ]; then \
		echo "Error: Frontend publish failed. Check npm authentication."; \
		exit 1; \
	fi
	@echo "Publishing Deno-compatible modules..."
	@cd frontend/core && npm run denoify
	@if [ $$? -ne 0 ]; then \
		echo "Error: Denoify failed."; \
		exit 1; \
	fi
	@echo "Frontend publish complete"

# Publish backend packages to PyPI
publish-backend:
	@echo "Publishing backend core package to PyPI..."
	@cd backend/core && uv build && uv publish
	@if [ $$? -ne 0 ]; then \
		echo "Error: Backend core publish failed. Check PyPI authentication."; \
		exit 1; \
	fi
	@echo "Publishing backend plugins to PyPI..."
	@for dir in backend/plugins/*; do \
		if [ -d "$$dir" ]; then \
			cd $$dir && uv build && uv publish; \
			if [ $$? -ne 0 ]; then \
				echo "Error: Publish failed for $$dir"; \
				exit 1; \
			fi; \
			cd ../../..; \
		fi; \
	done
	@echo "Backend publish complete"

# Deploy documentation to GitHub Pages
deploy-docs:
	@echo "Deploying documentation to GitHub Pages..."
	@cd docs && mkdocs gh-deploy
	@if [ $$? -ne 0 ]; then \
		echo "Error: Documentation deployment failed."; \
		exit 1; \
	fi
	@echo "Documentation deployment complete"

# Clean up generated files and dependencies
clean:
	@echo "Cleaning up..."
	@rm -rf frontend/node_modules backend/.venv backend/uv.lock docs/site
	@find . -type d -name "__pycache__" -exec rm -rf {} +
	@find . -type d -name "dist" -exec rm -rf {} +
	@find . -type d -name "*.egg-info" -exec rm -rf {} +
	@echo "Cleanup complete"
