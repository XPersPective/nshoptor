Project state and working protocol: the Project Brain lives in `.project-brain/` (config.yaml, current.md, target.md, constraints.md, tasks/, decisions/). At every session start run the project-brain skill boot sequence against that directory; execute work through its task loop. The legacy single-file `PROJECT_BRAIN.md` was removed — do not recreate it.

<!-- project-brain -->
## Project Brain
This project keeps its state in `.project-brain/` (current architecture, target, open tasks).
Before any work, load the `project-brain` skill and run its boot step; follow it for all work here.
