git status
read -p "Commit and push? " c
[ ! -z "$c" ] && exit
git add --all
git commit -m "$1"
git push
