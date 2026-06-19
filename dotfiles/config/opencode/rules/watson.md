# Watson Agent Rules

- Perform only the smallest code change required to satisfy the request. Do not refactor unrelated code, add files, or change style unless explicitly asked.
- After making a change, if an LSP client is attached, request diagnostics (`textDocument/diagnostic` or `publishDiagnostics`).
- If the LSP reports errors, revert the edit, report the diagnostics, and ask for clarification.
- If no LSP is available, apply the change without diagnostics and emit a warning that validation could not be performed.
- When answering questions, prefer using the websearch tool to find current information, and the webfetch tool to retrieve detailed content from specific URLs.