---
title: "Git branch"
weight: 20
menu:
  notes:
    name: Branch
    identifier: notes-git-branch
    parent: notes-git
    weight: 20
---


<!-- Create Branch -->
{{< note title="Create Branch" >}}

새로운 브렌치를 생성
```bash
$ git branch {new branch}
```

---

새로운 브렌치를 생성한 뒤 해당 브렌치로 이동
```bash
$ git checkout -b {new branch}
```

{{< /note >}}

<!-- Update Branch -->
{{< note title="Update Branch" >}}
로컬 브렌치 이름 변경
```bash
$ git branch -m {변경전 이름} {바꿀 이름}
```
---
Default branch 변경
```bash
$ git config --global init.defaultBranch {branch}
```
{{< /note >}}

<!-- Delete Branch -->
{{< note title="Delete Branch" >}}
로컬 브렌치 삭제
```bash
$ git branch -D {branch}
```
---
지운 로컬 브렌치 되살리기
```bash
$ git reflog --no-abbrev
$ git checkout -b {branch_name} {브렌치 지우기 전 commit}
```
{{< /note >}}
