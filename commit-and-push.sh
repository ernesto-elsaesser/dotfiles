git status
printf "\n"
read -p "COMMIT AND PUSH ALL CHANGES AS '$1'? " c
[ ! -z "$c" ] && exit
git add --all
git commit -m "$1"
git push
