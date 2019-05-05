AWS Demo 2019-05-03

# Introduction

This site is to study GIT initially. In the future, I will use this site for AWS study

#Git Commands -- Apply .gitignore
  git rm -r --cached .
  git add .
  git status
  git commit -m "Apply .gitignore"
  git push

#Git Commands -- delete file/folder from the git history
  git filter-branch -f --index-filter "git rm -rf --cached --ignore-unmatch tf-aws-cloudwatch-logs/.terraform" -- --all
