#!/bin/bash

git config --global user.email "april.kim412@gmail.com"
git config --global user.name "aprilslab"
git config user.email "april.kim412@gmail.com"
git config user.name "aprilslab"
git config --global init.defaultBranch main

hugo server --buildDrafts --buildFuture --bind 0.0.0.0 --port 443 --baseURL $REPL_SLUG.$REPL_OWNER.reple.co # https://aprilslabgithubio.yeongjukim2.repl.co