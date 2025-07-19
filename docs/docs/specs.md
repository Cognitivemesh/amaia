# Amaia Project Specifications

## Project Overview
Amaia is a modular GitHub template for building AI-powered knowledge base applications using Large Language Models (LLMs). It provides a user-friendly interface for creating, managing, and querying markdown-based knowledge bases, with real-time data synchronization and AI-driven features like search, summarization, and form assistance. The project is designed for modularity, with core and plugin packages published to npm (frontend) and PyPI (backend), and uses SurrealDB for data storage with optional SQLite/Turso support.

### Goals
- Enable users to create and manage knowledge bases using markdown documents.
- Integrate AI assistants for real-time search, summarization, and form-filling.
- Visualize knowledge base relationships using interactive graphs.
- Ensure modularity for easy extension via plugins.
- Support real-time data synchronization and cross-platform deployment.

## Feature Specifications

### 1. Knowledge Base Editor
**Description**: A frontend component that allows users to create and edit markdown-based knowledge base documents, with AI assistance for content suggestions.

**Requirements**:
- **Frontend**: Built with Deno, Next.js, CopilotKit (`CopilotTextarea`), Shadcn UI, and Tailwind CSS.
- **Functionality**:
  - Users can input a document title and markdown content.
  - CopilotKit provides AI-driven content suggestions based on the current document state.
  - Documents are saved to SurrealDB and synced in real-time using live updates.
- **Storage**: Uses the `storageLayer` module to interact with SurrealDB (default) or SQLite/Turso.
- **API**: Backend endpoint to save documents (`POST /documents`).

**Acceptance Criteria**:
- Users can create a document with a title and markdown content.
- AI suggestions appear in the textarea as users type.
- Documents are saved to SurrealDB within 1 second.
- Live updates reflect changes in the UI within 2 seconds.
- The UI is responsive and styled consistently across devices.

**Technical Details**:
- Frontend: `frontend/plugins/knowledge-base-editor/src/KnowledgeBaseEditor.tsx`
- Backend: `backend/plugins/knowledge-base-agent/src/knowledge_base_agent.py`
- Storage: `backend/core/src/storageLayer/__init__.py`

### 2. Search Agent
**Description**: A backend agent that fetches real-time web data using Tavily’s search API and stores results in SurrealDB for use in the knowledge base.

**Requirements**:
- **Backend**: Built with FastAPI, LangGraph, and Tavily-python.
- **Functionality**:
  - Accepts a search query via a `POST /search` endpoint.
  - Uses LangGraph to define a workflow: search (Tavily) → store (SurrealDB).
  - Caches search results using `functools.lru_cache` to optimize performance.
- **Storage**: Uses the `storageLayer` module for database interactions.
- **Frontend**: Displays search results in a clean, tabular format using Shadcn UI.

**Acceptance Criteria**:
- A search query returns results within 3 seconds.
- Results are stored in SurrealDB and retrievable via a query endpoint.
- Cached searches return results in under 0.5 seconds.
- The frontend displays results with clear formatting and no UI glitches.

**Technical Details**:
- Backend: `backend/plugins/search-agent/src/search_agent.py`
- Frontend: `frontend/plugins/search-agent/src/SearchAgent.tsx`
- Storage: `backend/core/src/storageLayer/__init__.py`

### 3. Graph Visualizer
**Description**: A frontend component that visualizes knowledge base relationships (nodes and edges) using AntV X6/G6, with data fetched from SurrealDB.

**Requirements**:
- **Frontend**: Built with Deno, Next.js, AntV X6/G6, and Tailwind CSS.
- **Functionality**:
  - Fetches nodes and edges from SurrealDB using `surrealdb.js`.
  - Renders an interactive graph where users can zoom and drag nodes.
  - Supports real-time updates via SurrealDB’s live queries.
- **Storage**: Uses the `storageLayer` module for data retrieval.

**Acceptance Criteria**:
- The graph renders within 2 seconds of page load.
- Nodes and edges update in real-time when modified in SurrealDB.
- The graph is interactive (zoom, drag) on desktop and mobile devices.
- No rendering errors occur with 100+ nodes.

**Technical Details**:
- Frontend: `frontend/plugins/graph-visualizer/src/GraphVisualizer.tsx`
- Storage: `backend/core/src/storageLayer/__init__.py`

### 4. Summarization Agent
**Description**: A backend agent that summarizes markdown documents using LangChain and an LLM (e.g., OpenAI), storing summaries in SurrealDB.

**Requirements**:
- **Backend**: Built with FastAPI, LangChain, and Pydantic.
- **Functionality**:
  - Accepts a document via a `POST /summarize` endpoint.
  - Uses LangChain’s `LLMChain` with a prompt template to generate a summary (100 words or less).
  - Stores the summary in SurrealDB using the `storageLayer` module.
- **Optimization**: Uses `functools.lru_cache` for repeated summarizations.

**Acceptance Criteria**:
- A 500-word document is summarized in under 5 seconds.
- Summaries are accurate and under 100 words.
- Summaries are stored in SurrealDB and retrievable via a query endpoint.
- No errors occur for documents up to 10,000 words.

**Technical Details**:
- Backend: `backend/plugins/summarization-agent/src/summarization_agent.py`
- Storage: `backend/core/src/storageLayer/__init__.py`

### 5. Form Assistant
**Description**: A frontend component with a conversational AI assistant (using CopilotKit) to help users fill out forms, with data stored in SurrealDB.

**Requirements**:
- **Frontend**: Built with Deno, Next.js, CopilotKit (`CopilotPopup`), Shadcn UI, and Tailwind CSS.
- **Backend**: FastAPI endpoint to save form data (`POST /form`).
- **Functionality**:
  - Users interact with a popup AI assistant to fill form fields (e.g., name, email).
  - CopilotKit’s `useCopilotAction` handles form updates and sends data to the backend.
  - Form data is stored in SurrealDB via the `storageLayer` module.
- **Storage**: Supports SurrealDB (default) and SQLite/Turso.

**Acceptance Criteria**:
- The AI assistant suggests valid form inputs based on user prompts.
- Form data is saved to SurrealDB within 1 second.
- The UI is intuitive and responsive across devices.
- No data loss occurs during submission.

**Technical Details**:
- Frontend: `frontend/plugins/form-assistant/src/FormAssistant.tsx`
- Backend: `backend/plugins/form-agent/src/form_agent.py`
- Storage: `backend/core/src/storageLayer/__init__.py`

## Architecture

### Frontend
- **Framework**: Deno, Next.js
- **Libraries**: CopilotKit (`react-ui`, `react-core`), AntV X6/G6, Shadcn UI, Tailwind CSS, surrealdb.js
- **Structure**: Monorepo managed by Lerna, with core (`@amaia/core`) and plugins (`@amaia/knowledge-base-editor`, etc.).
- **Storage**: Embedded SurrealDB client in `frontend/core/src/storage` for direct database access.
- **Publishing**: npm packages with Deno compatibility via `denoify`.

### Backend
- **Framework**: FastAPI
- **Libraries**: LangGraph, LangChain, Tavily-python, Pydantic, loguru, SurrealDB, sqlite-vec
- **Structure**: Monorepo managed by `uv`, with core (`amaia-backend-core`) and plugins (`amaia-search-agent`, etc.).
- **Storage**: Decoupled `storageLayer` module supporting SurrealDB (default) and SQLite/Turso.
- **Publishing**: PyPI packages using `uv build` and `uv publish`.

### Storage Layer
- **Default**: SurrealDB (multimodel, real-time live updates)
- **Optional**: SQLite with vector search via `sqlite-vec`
- **Implementation**: `backend/core/src/storageLayer/__init__.py` with async methods for connect, save, query, and live updates.
- **Synchronization**: SurrealDB’s live queries ensure real-time data updates between frontend and backend.

## Non-Functional Requirements
- **Performance**: API endpoints respond within 3 seconds; frontend renders within 2 seconds.
- **Scalability**: Supports 1,000 concurrent users with horizontal scaling.
- **Security**: API keys stored in `.env`; HTTPS for all endpoints; input validation with Pydantic.
- **Reliability**: 99.9% uptime; error handling with `loguru` logging.
- **Compatibility**: Backend compatible with Pyodide for WebAssembly; frontend compatible with Deno and npm.

## Acceptance Criteria (Global)
- All features are accessible via a single Next.js application at `http://localhost:3000`.
- Backend APIs are exposed at `http://localhost:8000` and documented in `docs/api.md`.
- Documentation is available at `http://localhost:8000/docs` using `mkdocs-material`.
- All packages are publishable to npm (frontend) and PyPI (backend) without errors.
- Tests (using `pytest` and `jest`) achieve 90% code coverage.

## Setup and Publishing

### Setup
1. **Clone Repository**:
   ```bash
   git clone https://github.com/your-org/amaia.git
   cd amaia
   ```
2. **Frontend**:
   ```bash
   cd frontend
   npm install
   npm run dev
   ```
3. **Backend**:
   ```bash
   cd backend
   uv venv
   source .venv/bin/activate
   uv pip install .
   uvicorn core.src.api.main:app --reload
   ```
4. **Documentation**:
   ```bash
   cd docs
   uv pip install mkdocs-material
   mkdocs serve
   ```
5. **Environment Variables**:
   Create `backend/core/.env`:
   ```plaintext
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

### Publishing
- **Frontend (npm)**:
  ```bash
  cd frontend
  npx lerna bootstrap
  npx lerna run build
  npx lerna publish
  ```
  For Deno compatibility:
  ```bash
  cd frontend/core
  npm run denoify
  ```
- **Backend (PyPI)**:
  ```bash
  cd backend/core
  uv build
  uv publish
  ```
  Repeat for each plugin in `backend/plugins`.

## Implementation Plan
1. **Setup Environment**: Configure `uv`, Lerna, and `mkdocs-material` using the `Makefile`.
2. **Develop Storage Layer**: Implement `storageLayer` with SurrealDB and SQLite support.
3. **Build Core Packages**: Develop `@amaia/core` (frontend) and `amaia-backend-core` (backend).
4. **Implement Plugins**: Develop each feature as a separate plugin, following the specifications above.
5. **Test and Validate**: Write unit tests (`pytest`, `jest`) and integration tests to meet acceptance criteria.
6. **Document and Publish**: Update `mkdocs-material` documentation and publish packages to npm/PyPI.