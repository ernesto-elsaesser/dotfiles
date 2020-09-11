git status
printf "\n"
read -p "Commit message: " msg
[ -z "$msg" ] && exit
printf "\n"
git add --all
git commit -m "$msg"
git push
