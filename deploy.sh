#!/usr/bin/env sh

IS_STAGE="staging"

# Abort on errors
set -e

npm install

# Build
if [ $1 == $IS_STAGE ];
then
echo 'Deploying to staging.tagion.org...'
npm run build:staging
else
echo 'Deploying to tagion.com...'
npm run build
fi

# navigate into the build output directory
cd docs/.vuepress/dist

# if you are deploying to a custom domain
if [ $1 == $IS_STAGE ];
then
echo 'staging.tagion.com' > CNAME

echo 'User-agent: *' > robots.txt
echo 'Disallow: *' >> robots.txt
else
echo 'tagion.com' > CNAME
fi

git init
git add -A
git commit -m 'deploy'

if [ $1 == $IS_STAGE ];
then
git push -f https://github.com/tagion/website-homepage-staging.git master:gh-pages
else
git push -f https://github.com/tagion/website-homepage.git master:gh-pages
fi

cd -
