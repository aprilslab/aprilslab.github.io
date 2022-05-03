---
title: "Git Rebase"
weight: 60
menu:
  notes:
    name: Rebase
    identifier: notes-git-rebase
    parent: notes-git
    weight: 60
---

<!-- Git Rebase -->
{{< note title="Git Rebase" >}}
git rebase 명령어
```bash
$ git rebase -i
```
---
Base branch 변경
```bash
$ git rebase --onto {새로운_branch_or_commit} {변경전_branch_or_commit}
```
---
과거의 특정 commit 수정 (merge상태 유지)
```bash
$ git rebase -i --rebase-merges {commit}
```
{{< /note >}}