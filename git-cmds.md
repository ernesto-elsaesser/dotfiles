### Staging

- stage all files
> git add -A

- show diff to HEAD
> git diff

- show diff to index
> git diff --staged

- unstage file FILE
> git checkout -- <FILE>

- unstage all files (reset index)
> git reset HEAD

- discard all changes in working dir (and index)
> git reset --hard HEAD


### Commits

- print short commit hash of the latest commit
> git rev-parse --short HEAD

- add changes to last commit
> git commit --amend --no-edit

- delete last commit (keep working dir for re-commit)
> git reset HEAD~


### Branches

- show local branches
> git branch

- show local and remote branches
> git branch -a

- show branches with more info
> git branch -vv

- switch to branch
> git checkout <NAME>

- create new branch
> git checkout -b <NAME>

- push new branch to upstream repo
> git push -u origin HEAD

- rename current branch
> git branch -m <NAME>

- delete branch
> git branch -d <NAME>

- merge upsteam branch into current
> git fetch; git merge --no-edit

- merge master branch into current
> git fetch; git merge --no-edit origin/master


### Misc

- pull new commits, branches, tags, etc.
> git fetch --all

- rebase interactively over last NUM commits
> git rebase -i HEAD~<NUM>

