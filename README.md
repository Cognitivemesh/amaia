# Amaia 🌟

**A modular GitHub template for building AI-powered knowledge base applications** 🚀

![Amaia Banner](https://via.placeholder.com/1200x200.png?text=Amaia+AI+Knowledge+Base) <!-- Replace with actual banner -->

Welcome to **Amaia**, the ultimate template for crafting AI-driven knowledge bases with Large Language Models (LLMs). Amaia brings together cutting-edge frontend and backend technologies to create intuitive, powerful, and modular applications. Whether you're building a chatbot, a data visualizer, or a research tool, Amaia has you covered! 🧠💻

[![GitHub Stars](https://img.shields.io/github/stars/cognitivemesh/amaia?style=social)](https://github.com/Cognitivemesh/amaia)
[![GitHub Issues](https://img.shields.io/github/issues/cognitivemesh/amaia)](https://github.com/Cognitivemesh/amaia/issues)
[![MIT License](https://img.shields.io/github/license/cognitivemesh/amaia)](https://github.com/Cognitivemesh/amaia/blob/main/LICENSE)
[![Discord](https://img.shields.io/discord/1234567890?logo=discord)](https://discord.gg/your-discord)

---

## ✨ Features

- **📝 Knowledge Base Editor**: Craft markdown-based knowledge bases with AI assistance via CopilotKit.
- **🌐 Search Agent**: Fetch real-time web data using Tavily’s AI-optimized search API.
- **📊 Graph Visualizer**: Visualize relationships with interactive AntV X6/G6 diagrams.
- **✍️ Summarization Agent**: Summarize documents with LangChain and OpenAI.
- **🤖 Form Assistant**: Streamline form-filling with conversational AI using CopilotKit.

Amaia is built for modularity, with core and plugin packages publishable to npm and PyPI, and a decoupled storage layer using SurrealDB (with SQLite/Turso support). Data syncs in real-time, making it perfect for dynamic applications. 🌍

---

## 🚀 Getting Started

Get up and running in minutes! Follow the detailed setup instructions in our [Setup Guide](docs/setup.md).

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Cognitivemesh/amaia.git
   cd amaia
   ```
2. **Frontend Setup**:
   ```bash
   cd frontend
   npm install
   npm run dev
   ```
3. **Backend Setup**:
   ```bash
   cd backend
   uv venv
   source .venv/bin/activate
   uv pip install .
   uvicorn core.src.api.main:app --reload
   ```

Check out the [Setup Guide](docs/setup.md) for environment variables and more details.

---

## 🛠️ Built With

Amaia leverages a modern, powerful tech stack to deliver a seamless experience:

<details>
<summary>Frontend Tech Stack</summary>

- **[Deno](https://deno.land)**: Secure, modern runtime for JavaScript/TypeScript.
- **[Next.js](https://nextjs.org)**: React framework for fast, scalable web apps.
- **[CopilotKit](https://github.com/CopilotKit/CopilotKit)**: AI-powered assistants and chatbots.
- **[AntV X6/G6](https://antv.antgroup.com)**: Interactive graph and diagram visualizations.
- **[Shadcn UI](https://ui.shadcn.com)**: Reusable, accessible UI components.
- **[Tailwind CSS](https://tailwindcss.com)**: Utility-first CSS for rapid styling.

</details>

<details>
<summary>Backend Tech Stack</summary>

- **[FastAPI](https://fastapi.tiangolo.com)**: High-performance API framework for Python.
- **[LangGraph](https://github.com/langchain-ai/langgraph)**: Workflow orchestration for AI agents.
- **[LangChain](https://github.com/langchain-ai/langchain)**: Connects LLMs to external data.
- **[Tavily](https://www.tavily.com)**: AI-optimized search API for real-time web data.
- **[CopilotKitSDK](https://github.com/CopilotKit/CopilotKit)**: Backend integration for AI agents.
- **[SurrealDB](https://surrealdb.com)**: Multimodel database with real-time sync (default).
- **[SQLite/Turso](https://turso.tech)**: Lightweight database with vector search support.

</details>

<details>
<summary>Package Management</summary>

- **[Lerna](https://lerna.js.org)**: Manages JavaScript monorepo for frontend packages.
- **[uv](https://github.com/astral-sh/uv)**: Fast Python package manager for backend.

</details>

---

## 📈 Stats & Activity

![GitHub Activity](https://img.shields.io/github/commit-activity/m/Cognitivemesh/amaia)
![GitHub Contributors](https://img.shields.io/github/contributors/Cognitivemesh/amaia)
![GitHub Last Commit](https://img.shields.io/github/last-commit/Cognitivemesh/amaia)

---

## 🧩 Plugins

Amaia’s modular design allows you to extend functionality with plugins. Explore our core plugins:

- **Knowledge Base Editor**: AI-assisted markdown editing.
- **Search Agent**: Real-time web searches with Tavily.
- **Graph Visualizer**: Interactive data visualizations.
- **Summarization Agent**: Concise document summaries.
- **Form Assistant**: Conversational form-filling.

See the [Plugins Guide](docs/docs/plugins.md) for details and how to create your own.

---

## 📚 Documentation

Our documentation is powered by [mkdocs-material](https://squidfunk.github.io/mkdocs-material/) for a sleek, user-friendly experience. Run it locally:

```bash
cd docs
uv pip install mkdocs-material
mkdocs serve
```

Visit [docs/index.md](docs/docs/index.md) for the full documentation, including setup, plugins, and API reference.

---

## 🤝 Contributing

We 💜 contributions! Whether it’s code, docs, or new plugins, your input is welcome. Check out the [Contributing Guide](docs/docs/contributing.md) for details.

1. Fork the repo 🍴
2. Create a branch (`git checkout -b feature/awesome-plugin`)
3. Commit your changes (`git commit -m "Add awesome plugin"`)
4. Push to the branch (`git push origin feature/awesome-plugin`)
5. Open a Pull Request 🚀

---

## 📦 Publishing

Amaia’s modular packages are publishable to npm (frontend) and PyPI (backend):

<details>
<summary>Frontend (npm)</summary>

```bash
cd frontend
npx lerna bootstrap
npx lerna run build
npx lerna publish
```

For Deno compatibility, run `npm run denoify` in each package.

</details>

<details>
<summary>Backend (PyPI)</summary>

```bash
cd backend/core
uv build
uv publish
```

Repeat for each plugin in `backend/plugins`.

</details>

---

## 📜 License

Distributed under the [MIT License](LICENSE). See the license file for more information.

---

## 🌐 Connect with Us

* **Issues**: [Report bugs or suggest features](https://github.com/Cognitivemesh/amaia/issues) 🐞
* **Docs**: [Explore the full documentation](docs/docs/index.md) 📖

---

**Amaia**: Where AI meets knowledge, and modularity meets magic. Let’s build something extraordinary! ✨
