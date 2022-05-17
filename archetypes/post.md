---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: false
mermaid: true
math: true
menu:
  sidebar:
    name: {{ replace .Name "-" " " | title }}
    identifier: replace_me
    parent: replace_parent
    weight: 10
tags: [""]
categories: [""]
---
