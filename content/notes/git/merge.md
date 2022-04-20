---
title: "Git Merge"
weight: 40
menu:
  notes:
    name: Merge
    identifier: notes-git-merge
    parent: notes-git
    weight: 40
---

<!-- Merge Branch -->
{{< note title="Merge Branch" >}}
B 브랜치를 A 브랜치로 병합
```bash
$ git checkout A
$ git merge B
```
{{< /note >}}

<!-- Merge Conflict -->
{{< note title="Merge Conflict" >}}
Conflict 난 파일 수정후 아래의 명령어 입력
```bash
# 수정한 파일만 추가
$ git add {수정한 파일}
# 전체 파일추가
$ git add . 
# merge 계속 진행하기
$ git merge --continue
```
{{< /note >}}

<!-- Merge Abort -->
{{< note title="Merge Abort" >}}
merge를 진행하던 도중 취소하려고 할 때 사용
```bash
$ git merge --abort
```
{{< /note >}}