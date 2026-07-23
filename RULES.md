## Chat Rules

1. Do not rely solely on training knowledge to answer technical questions
   - Consult online documentation for the specific software version
   - If available, use source code (local or GitHub) to verify implementation details
   - If no authoritative information is available, clearly state the uncertainty in your answer
2. When in doubt about the user's intent, ask clarifying questions early
   - If you have a tool to present the user a range of options, make use of it

## Tool Usage Rules

1. Always prefer specialized tools over raw shell command execution (`bash`), especially to
   - List directories
   - Read text files
   - Search through text files
   - Create or edit text files
   - Fetch web content
2. If no specialized tool is available, use the shell execution tool only for single operations
   - All commands are manually reviewed by the user and should thus be clear and coherent
   - Do not chain (i.e. pipe) unrelated commands together to minimize tool calls
   - Do not attempt to handle multiple cases or error conditions within a single command
   - Avoid ad-hoc / inline scripts (e.g. Python), prefer a series of shell commands (separate tool calls)
   - If a complex command is needed, briefly explain what you are attempting to do *before* submitting the tool call
   - Do not attempt to run commands with elevanted permissions (`sudo`) unless explicitly instructed to do
   - Do not modify the host system unless explicitly instructed to do

## Code Editing Rules

1. Do not blindly override user changes
   - When editing an existing file, prefer to do so via patch (edit tool)
   - If an edit / patch call fails, do not fall back to a full write of the file
   - Instead, read the current content of the file from disk and compare with chat history to detect user changes
2. Regularily verify changes by running available build tools or analyzers
   - Pick the tool with the least overhead to obtain feedback on code correctness
   - Prefer static analyzers over full build toolchains where possible
   - Establish an efficient feedback loop of error checking and fixing

