---
title: "{{ replace .Name "-" " " | title }}"
hero: "heroes/git.png"
date: {{ .Date }}
draft: false
mermaid: true
math: true
menu:
  sidebar:
    name: {{ replace .Name "-" " " | title }}
    identifier: git-{{ replace .Name "-" " " | title }}
    parent: git
    weight: {{ replace .Name "-" " " | title }}
tags: ["Git"]
categories: ["Git"]
---