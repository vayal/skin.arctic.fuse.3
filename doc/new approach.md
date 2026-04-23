Arctic Fuse 3 Migration - Execution Plan (v2)

Status: Active Execution Guide
Context: Adapted for post-rollback Gap Analysis, script.skinvariables generator architecture, WSL local execution, and HTPC remote-agent inference.

1. The Post-Rollback Reality: Gap Analysis First

Because the 1080i/ directory was rolled back, the implementation status of Phases 1-7 is currently unknown. Before any mapping or code modification occurs, we must perform a Gap Analysis.

We will use the Agent to cross-reference the exact requirements outlined in the Phase 1-7 documents against the current state of the codebase. This will identify the "Delta" (what survived vs. what was lost).

2. The Paradigm Shift: The "Split" Architecture

Once the gaps are identified, we cannot simply re-apply the old Phase touch-lists. Due to the nature of Arctic Fuse 3, any manual edits made to generated 1080i/ files will be overwritten the next time the skin's generator runs.

Therefore, every missing implementation identified in the Gap Analysis must be triaged into a "Split Workflow" (User Scaffolds, Agent Maps):

Bucket A (Generator Blueprints): Gaps belonging to shortcuts/generator/data/setup/*.xml and shortcuts/skinvariables-generator.json. The Agent can edit these directly to fix the gap.

Bucket B (Base Dialogs & Screens): Gaps belonging to static GUI files (e.g., 1080i/DialogVideoInfo.xml). The User must scaffold/isolate these first; the Agent will then map the endpoints.

The Golden Rule: The Agent is strictly forbidden from editing generated 1080i/ output files. It must only edit source blueprints or user-scaffolded base files.

3. System Architecture & Tooling

The development environment is distributed. The agent must be aware of its operational boundaries:

Primary (The Hands): Windows PC running VSCode attached to a WSL (Ubuntu/Linux) Workspace.

Advantage: Cline operates natively within WSL. It uses native Linux paths and executes terminal commands directly against the repository.

Tools Required: ripgrep (rg) and git installed inside WSL (sudo apt install ripgrep git). No external Filesystem MCP is required.

Secondary (The Brain): Linux HTPC running Ollama (qwen-reason).

Role: Provides the reasoning and JSON-RPC mapping logic without burning Primary CPU resources.

4. The Adapted Roadmap

Phase A: Gap Analysis (Audit vs. Specs)

Action: The Agent reads the Phase documents in small batches alongside the screen-by-screen-build-contract.md. It uses ripgrep to scan the codebase to see which tasks are currently missing or reverted.

Deliverable: A new doc/gap-analysis/ directory containing individual markdown files detailing the findings for the audited phases.

Phase B: Rule Application & Triage

Action: The Agent takes the Gap Analysis Reports and applies the af3-agent-rules.md.

Deliverable: The gaps are consolidated and sorted into Bucket A (Generator Sources) and Bucket B (Base Screens) to create our new, actionable to-do list.

Phase C: Ping-Pong Execution (Re-implementation)

We execute the replacements strictly item-by-item based on the Triage list.

User Action: Prepares/scaffolds the target XML file if it falls in Bucket B.

Agent Action: Reads the file, maps themoviedb.helper to velocity using the exact endpoints, and preserves all <control> layout tags. Enforces pagination constraints (no page on spotlights).

Fallback: If a route has no documented equivalent, apply Rule 9: <!-- TODO: velocity-map missing endpoint for this route -->.

Save State: The Agent runs git commit to atomically save the specific screen mapping.

Phase D: Policy Enforcement & Clean Up

Removing legacy helper functionalities (Weather, PVR, Cast/Crew deep rails) that the Gap Analysis showed were reverted.

Action: User directs Agent to specific base files (e.g., 1080i/Dialog_DialogContextMenu.xml); Agent removes the deprecated <control> blocks.

Phase E: Generator Rebuild & Freeze

User Action: Run the script.skinvariables generator within Kodi.

Validation: Boot Kodi and manually test that the newly generated 1080i/ files accurately reflect the Velocity routing and that pagination functions flawlessly.

5. Immediate Next Steps (Agent Kickoff Prompts)

To begin this workflow, open a new chat with the Agent in your WSL VSCode workspace and execute these prompts sequentially. We break the tasks down to respect the Agent's context window.

Prompt 1a: Initialization & Phase 1-2 Audit (Run this first)

"We are migrating an Arctic Fuse 3 skin fork. Our 1080i/ directory recently suffered a rollback. We must perform a Gap Analysis in small, manageable batches to avoid losing context.

First, read the af3-agent-rules.md, screen-by-screen-build-contract.md, and ONLY the Phase 1 and Phase 2 markdown documents.
Second, use your terminal to create a new directory: doc/gap-analysis/.
Third, use your terminal tool to run ripgrep (rg) searches across the shortcuts/ and 1080i/ directories to determine which tasks from Phase 1 and 2 were wiped out and which survived.
Finally, create a file named doc/gap-analysis/phase-01-02-gap.md and document what needs to be re-implemented. Do not edit any XML files yet."

Prompt 1b: Phase 3-4 Audit (Run after Prompt 1a)

"Great. Now, read the Phase 3 and Phase 4 markdown documents.
Use your terminal to run ripgrep searches to check the implementation status of the tasks outlined in these specific phases against the current codebase.
Create a new file named doc/gap-analysis/phase-03-04-gap.md and detail exactly what survived and what needs to be re-implemented for these phases."

Prompt 1c: Phase 5-7 Audit (Run after Prompt 1b)

"Now, read the Phase 5, Phase 6, and Phase 7 markdown documents.
Run your ripgrep searches to check the status of these final phases.
Create a new file named doc/gap-analysis/phase-05-07-gap.md and document your findings on what needs to be re-implemented."

Prompt 2: Triage & Categorization (Run after Audits are complete)

"Now, review the three gap reports you created in the doc/gap-analysis/ directory. Re-read the af3-agent-rules.md to refresh your memory on the rules.

Take your findings and categorize every missing implementation into two lists:

'Bucket A (Generator Sources)' for files in shortcuts/ that you are allowed to edit directly.

'Bucket B (Base Screens)' for files in 1080i/ that I will need to scaffold for you first.

Output this consolidated to-do list into a new file: doc/gap-analysis/master-triage-list.md."

Prompt 3: The Execution Loop (Run per file/hub)

"Let's tackle 

$$Insert Item from To-Do List$$

 at [Insert Path]. Read it and apply the mapping rules. Replace the helper routes with Velocity endpoints. Preserve all <control> and layout tags perfectly. Remember that spotlights cannot have pagination parameters. If you find a route you cannot map, insert the TODO comment as per Rule 9. When finished, save the file and use the terminal to run a git commit summarizing the endpoints you mapped."