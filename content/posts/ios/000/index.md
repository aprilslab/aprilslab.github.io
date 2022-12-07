---
title: "[iOS] iOS 버전별 점유율 확인"
url: posts/ios/000/
date: 2022-06-02T08:43:39+09:00
draft: false
mermaid: true
math: true
menu:
  sidebar:
    name: "[iOS] iOS 버전별 점유율 확인"
    identifier: ios-000
    parent: ios
    weight: 10
tags: ["iOS 점유율", "iOS 타켓 OS 정하기"]
categories: ["iOS"]
---

## 어디서 확인할 수 있을까?

> iOS 점유율은 애플에서 제공하고 있다.\
> 아래의 링크로 이동하면 확인 할 수 있다.
> 
> [https://developer.apple.com/kr/support/app-store/](https://developer.apple.com/kr/support/app-store/)

&nbsp;

----

## 왜 확인해야할까?

SwiftUI로 개발을하다보면 OS 버전별로 동작이 다르고 이전 버전일 수록 SwiftUI에서 발생하는 버그가 많은 것을 느낄 수 있다.

OS 점유율을 근거로 제시하여 iOS 14 버전 이상을 타켓으로 잡아야한다는 주장을 펼칠 수 있는 근간이 된다.

아래의 사진을 보면 지난 4년간 도입된 아이폰의 98%가 iOS 14버전 이상을 쓰고 있는 것을 확인할 수 있다.

{{< img src="/images/ios/ios-00-00.png" width="400" align="center" title="iOS 점유율" >}}