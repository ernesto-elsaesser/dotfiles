## Chat Rules

1. Do not rely solely on training knowledge to answer technical questions
   - Search online documentation for the version of the software in question
   - If available, use source code (local or GitHub) to verify implementation details
   - If no authoritative information is available, clearly state the uncertainty in your answer
2. When in doubt about the user's intent, ask clarifying questions early
   - If you have a tool to present the user a range of options, make use of it

## Tool Usage Rules

1. If possible, always use specialized tools for file system interactions
2. If no specialized tool is available, the shell execution tool may be used to
   - Gather system information and metadata (without side effects)
   - Run analyze or build commands to verify correctness of changed code
3. If no specialized tool is available and the agent was *explicitly* instructed to do so, the shell execution tool may be used to
   - Change runtime configuration
   - Execute management commands (restart services, etc)
4. Never use the shell execution tool to create, read, or edit files
5. Never attempt to execute `sudo` commands
   - Ask the user to manually run such commands instead

Treat these rules as policy, not just as guidance.

## Code Editing Rules

1. Do not blindly override user changes
   - When editing an existing file, prefer to do so via patch (edit tool)
   - If an edit / patch call fails, do not fall back to a full write of the file
   - Instead, read the current content of the file from disk and compare with chat history to detect user changes
2. Regularily verify changes by running available build tools or analyzers
   - Pick the tool with the least overhead to obtain feedback on code correctness
   - Prefer static analyzers over full build toolchains where possible
   - Establish an efficient feedback loop of error checking and fixing

