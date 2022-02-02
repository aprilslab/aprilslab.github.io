---
title: "Git Settings"
weight: 10
menu:
  notes:
    name: Settings
    identifier: notes-git-settings
    parent: notes-git
    weight: 10
---

<!-- Git clone -->
{{< note title="Git Clone" >}}
원격 저장소 복제(Clone)하기 - **HTTP**
```bash
$ git clone {https://gitlab.com/johndoe/example.git}
```
---

원격 저장소 복제(Clone)하기 - **SSH**
```bash
$ git clone {git@gitlab.com:johndoe/example.git}
```
{{< /note >}}

<!-- Git Config -->
{{< note title="Git Config" >}}
유저 이름과 이메일 설정하기
```bash
$ git config --global user.name "John Doe"
$ git config --global user.email "johndoe@email.com"
```
---
**merge --no-ff**가 기본으로 동작하도록 설정
```bash
$ git config --global merge.ff false
```
---
pager 끄기
```bash
$ git config --global pager.branch false
$ git config --global pager.tag false
```
{{< /note >}}

<!-- Git Repository -->
{{< note title="Git Repository" >}}
Git에 존재하는 폴더 올리기
```bash
$ cd {existing_folder}
$ git init --initial-branch={master}
$ git remote add origin {git@gitlab.com:johndoe/example.git}
$ git add .
$ git commit -m "Initial commit"
$ git push -u origin {master}
```
---
Git에 존재하는 프로젝트 올리기
```bash
$ cd {existing_repo}
$ git remote rename origin old-origin
$ git remote add origin {git@gitlab.com:johndoe/example.git}
$ git push -u origin --all
$ git push -u origin --tags
```
{{< /note >}}

{{< note title="Git Ignore" >}}
.gitignore 파일 자동 생성 사이트: 
[gitignore.io](https://www.toptal.com/developers/gitignore)
{{< /note >}}