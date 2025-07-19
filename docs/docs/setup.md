# Setup Instructions 🛠️

## Prerequisites

* **Deno** (for frontend compatibility)
* **Python** (>=3.11)
* **uv** (Python package manager)
* **SurrealDB** (running locally or via Docker)

## Frontend Setup

```bash
cd frontend
npm install
npm run dev
```
Open http://localhost:3000 in your browser.
## Backend Setup
```bash
cd backend
uv venv
source .venv/bin/activate
uv pip install .
uvicorn core.src.api.main:app --reload
```

## Environment Variables
Create a .env file in backend/core:

```bash
OPENAI_API_KEY=your_openai_api_key
TAVILY_API_KEY=your_tavily_api_key
GROQ_API_KEY=your_groq_api_key
OPENROUTER_API_KEY=your_openrouter_api_key
SURREALDB_URL=ws://localhost:8000
SURREALDB_USER=admin
SURREALDB_PASSWORD=admin
SURREALDB_NAMESPACE=amaia
SURREALDB_DATABASE=knowledge_base
```

## Documentation
Run the documentation site locally:

```bash
cd docs
uv pip install mkdocs-material
mkdocs serve
```
Open http://localhost:8000 to view.
