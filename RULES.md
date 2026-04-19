## Tool Usage Rules

Important rules for all AI agents operating on this machine.

1. If possible, always use specialized tools for file system interactions.
2. If no specialized tool is available, the shell execution tool may be used to
   - Gather system information and metadata (without side effects)
   - Run analyze or build commands to verify correctness of changed code
3. If no specialized tool is available and the AI was *explicitly* instructed to do so, the shell execution tool may be used to
   - Change runtime configuration
   - Execute management commands (restart services, etc)
4. Never use the shell execution tool to read, create, edit or delete files.
5. Never attempt to execute `sudo` commands. Ask the user to manually run such commands instead.

Treat these rules as policy, not just as guidance.

