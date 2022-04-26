---
title: "Git Remote"
weight: 50
menu:
  notes:
    name: Remote
    identifier: notes-git-remote
    parent: notes-git
    weight: 50
---

<!-- Remote Setting -->
{{< note title="Remote Setting" >}}
현재 remote repository 확인 명령어
```bash
$ git remote -v
```
---
git remote 변경 명령어
```bash
$ git remote set-url origin {https://github.com/johndoe/example.git}
```
---
git remote 동기화 명령어
```bash
$ git remote update origin --prune
```
{{< /note >}}

<!-- Remote Branch -->
{{< note title="Remote Branch" >}}
Remote branch 리스트 확인하기
```bash
$ git branch -r
```
---
Remote branch가져오기
```bash
$ git checkout -t origin/{branch_name}
```
{{< /note >}}
