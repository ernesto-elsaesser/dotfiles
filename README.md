## Git Cheatsheet

Command | Description
--- | ---
**Staging** | 
`git add -A` | stage all files 
`git diff` | show diff to HEAD 
`git diff --staged` | show diff to index 
`git checkout -- FILE` | unstage file FILE 
`git checkout origin/master -- FILE` | replace FILE with master branch version 
`git reset HEAD` | unstage all files (reset index) 
`git reset --hard HEAD` | discard all changes in working dir (and index) 
**Commits** | 
`git rev-parse --short HEAD` | print short commit hash of the latest commit 
`git commit --amend --no-edit` | add changes to last commit 
`git reset HEAD^` | delete last commit (keep working dir for re-commit) 
**Branches** | 
`git branch` | show local branches 
`git branch -a` | show local and remote branches 
`git branch -vv` | show branches with more info 
`git checkout NAME` | switch to branch 
`git checkout -b NAME` | create new branch 
`git push -u origin HEAD` | push new branch to upstream repo 
`git branch -m NAME` | rename current branch 
`git rebase origin/master` | rebase current branch to master 
`git merge --no-edit` | merge upsteam branch into current 
`git merge --no-edit origin/master` | merge master branch into current 
`git branch -d NAME` | delete branch 
**Other** | 
`git fetch --all` | pull new commits, branches, tags, etc. 
`git rebase -i HEAD~N` | rebase interactively over last N commits 

