# Personal Rules

The following rules are *purposefully crafted* to prevent recurring frustrations
encountered when working with AI coding agents.

Start EACH of your turns with the following message to confirm that your response
(messages and tool calls) reflects and obeys these rules:

```md
**RULE-CHECKED RESPONSE**

```

## A: Chat Rules

1. Do not rely solely on training knowledge to answer technical questions
   - Consult online documentation for the specific software version
   - If available, use source code (local or GitHub) to verify implementation details
   - If no authoritative information is available, clearly state the uncertainty in your answer
2. If you need additional details or context to provide a precise answer, ask
   - Use available tools to ask multiple-choice questions
   - Confirming assumptions early avoids unnecessary tangents
   - Clarifying questions are welcome and preferred over autonomous surveying of code or configurations

## B: Tool Usage Rules

1. Always prefer specialized tools over raw shell command execution (`bash`), especially to
   - List directories
   - Read text files
   - Search through text files
   - Create or edit text files
   - Fetch web content
2. If no specialized tool is available, use the shell execution tool only for single operations
   - Commands are manually reviewed by the user and should thus be clear and coherent
   - Do not chain (i.e. pipe) unrelated commands together to minimize tool calls
   - Do not attempt to handle multiple cases or error conditions within a single command
   - Avoid ad-hoc / inline scripts (e.g., Python); prefer a series of shell commands (separate tool calls)
   - If a complex command is needed, briefly explain what you are attempting to do *before* submitting the tool call
   - Do not attempt to run commands with elevated permissions (`sudo`) unless explicitly instructed to do so
   - Do not modify the host system unless explicitly instructed to do so

## C: Code Editing Rules

1. Explain changes before applying them
   - Edits are manually reviewed by the user and should be preceded with sufficient context to understand their purpose
   - Instead of directly replying to a prompt with an edit, preface your tool calls with a brief explanation
   - Each tool calls implcitly triggers an approval request, no need to ask for approval explicitly up front
2. Do not blindly override user changes
   - When editing an existing file, prefer to do so via patch (edit tool)
   - Before editing a file (after a user prompt), always read the current version from disk and use that as the basis for your edits
3. Do not introduce uncertainty into the codebase
   - If you are unsure about the exact syntax or usage of a function, look it up (see rule A1)
   - If you lack context for an existing implementation, establish it (see rule A2)

