## Tool Usage Rules

Important rules for AI agents operating on this machine.

1. If possible, always use specialized tools for file system interactions.
2. If no specialized tool is available, the shell execution tool may be used to
   - Gather system information and metadata (without side effects)
   - Run analyze or build commands to verify correctness of changed code
3. If no specialized tool is available and the agent was *explicitly* instructed to do so, the shell execution tool may be used to
   - Change runtime configuration
   - Execute management commands (restart services, etc)
4. Never use the shell execution tool to read, create, edit or delete files.
5. Never attempt to execute `sudo` commands. Ask the user to manually run such commands instead.

Treat these rules as policy, not just as guidance.

## Code Editing Rules

Important rules for AI agents that edit source code.

1. Always expect that the user or a diffent agent has modified a source files after your last access.
   - Never assume the contents of a file based on chat history
   - Always read sources file before editing them
   - Use the current state of the file on disk as basis for any patches
   - Never implicitly revert or override edits made by other contributors
2. Frequently verify changes by running available build tools or analyzers
   - Pick the tool with the least overhead to obtain feedback on code correctness
   - Prefer static analyzers over full build toolchains where possible
   - Establish an efficient feedback loop of error checking and fixing

