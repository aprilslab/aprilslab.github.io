---
title: "Git Commit"
weight: 30
menu:
  notes:
    name: Commit
    identifier: notes-git-commit
    parent: notes-git
    weight: 30
---


<!-- Git Commit -->
{{< note title="Git Commit" >}}

변경사항 저장 후 commit하기
```bash
# 변경사항 모두 저장
$ git add .
# git commit
$ git commit -m "commit message"
```
{{< /note >}}


<!-- Commit History -->
{{< note title="Commit History" >}}

commit history 조회 (삭제된 브렌치의 커밋도 조회 가능)
```bash
$ git reflog
```
---
특정 commit 시점으로 이동하기
```bash
$ git checkout {commit}
```
---
현재로 돌아오기
```bash
$ git checkout -
```
{{< /note >}}
