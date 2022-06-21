set -e

npm run build

cd dist

git init
git add -A
git commit -m 'deploy'

git push -f https://github.com/BoyouLin/HSAW_frontend.git master:gh-pages

cd -