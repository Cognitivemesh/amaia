# API Reference 📚

Amaia’s backend exposes FastAPI endpoints for interacting with AI agents and the knowledge base.

## Search Endpoint

```http
POST /search
Content-Type: application/json
{"query": "example query"}
```

**Response**:
```json
{
  "results": {
    "answer": "Search results here",
    "web_data": []
  }
}
```

## Summarization Endpoint

```http
POST /summarize
Content-Type: application/json
{"document": "text to summarize"}
```

**Response**:
```json
{
  "summary": "Summarized text here"
}
```

## Form Endpoint

```http
POST /form
Content-Type: application/json
{"name": "John Doe", "email": "john@example.com"}
```

**Response**:
```json
{
  "status": "success"
}
```



### Project Structure

```plaintext
amaia/
├── frontend/
│   ├── core/                       # Core frontend package (@amaia/core)
│   │   ├── src/
│   │   │   ├── components/         # React components
│   │   │   ├── hooks/              # Custom React hooks
│   │   │   ├── providers/          # Context providers
│   │   │   ├── lib/                # Utility functions
│   │   │   └── storage/            # Embedded SurrealDB client
│   │   ├── package.json
│   │   └── deno.json
│   ├── plugins/
│   │   ├── knowledge-base-editor/  # @amaia/knowledge-base-editor
│   │   ├── graph-visualizer/       # @amaia/graph-visualizer
│   │   ├── ai-chat/                # @amaia/ai-chat
│   │   ├── search-agent/           # @amaia/search-agent
│   │   ├── form-assistant/         # @amaia/form-assistant
│   │   └── package.json
│   ├── lerna.json
│   └── package.json
├── backend/
│   ├── core/                       # Core backend package (amaia-backend-core)
│   │   ├── src/
│   │   │   ├── storageLayer/       # Decoupled storage layer
│   │   │   ├── agents/             # LangGraph agents
│   │   │   ├── api/                # FastAPI endpoints
│   │   │   └── utils/              # Utility functions
│   │   ├── pyproject.toml
│   │   └── .env
│   ├── plugins/
│   │   ├── knowledge-base-agent/   # amaia-knowledge-base-agent
│   │   ├── search-agent/           # amaia-search-agent
│   │   ├── summarization-agent/    # amaia-summarization-agent
│   │   ├── graph-agent/            # amaia-graph-agent
│   │   ├── form-agent/             # amaia-form-agent
│   │   └── pyproject.toml
│   ├── pyproject.toml
│   └── uv.lock
├── docs/                           # Documentation with mkdocs-material
│   ├── mkdocs.yml
│   ├── index.md
│   ├── setup.md
│   ├── plugins.md
│   ├── api.md
│   └── contributing.md
├── README.md                       # Main README
└── LICENSE                         # MIT License
```
