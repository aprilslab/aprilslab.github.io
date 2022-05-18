---
title: "화면이 멈추는 현상 (TabView)"
date: 2022-05-18T11:12:00+09:00
draft: false
mermaid: true
math: true
menu:
  sidebar:
    name: 화면이 멈추는 현상 (TabView)
    identifier: logs-swiftui-tabview
    parent: logs-swiftui
    weight: 20
tags: ["iOS", "SwiftUI", "Tabview", "앱화면이 멈췄어요"]
categories: ["SwiftUI", "Error"]
---

## TabView란?

&nbsp;

공식문서: [링크](https://developer.apple.com/documentation/swiftui/tabview)

&nbsp;

**Apple 정의**
> A view that switches between multiple child views using interactive user interface elements.

여러개의 자식뷰를 가진 뷰 스위쳐라고 적혀있다. 안드로이드의 ViewPager와 비슷하다고 보면 될 것 같다.
애플에서 공식으로 제공하는 뷰중에 하나지만 StackOverflow 등을 보면 버그가 많아서 많이 쓰이지는 않는 것같다.

이번에 겪은 증상을 기록용으로 남겨본다.

&nbsp;

---

## 버그증상
> `iOS 14.2, 14.3` 등 특정 버전에서 화면이 멈추면서 아예 동작을 하지 않았다.

SwiftUI를 쓰면서 느낀것인데 SwiftUI는 OS 버전을 많이 타는 것 같다. iOS 14.1이나 iOS 15버전에서는 정상동작을 하는 것을보면 희한하다.

&nbsp;

---

## 해결방법
> 1. TabView를 제거한다.
> 2. [UIPageViewController](https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit)를 사용하거나 [SwiftUIPager 라이브러리](https://github.com/fermoya/SwiftUIPager)를 사용한다.

UIKit에서 제공하는 UIPageViewController를 사용하거나 SwiftUIPager라이브러리를 사용하니 버전별로 다르게 동작하던 버그가 사라졌다.

&nbsp;

---

## 결론

* iOS 14 일부 버전에서 TabView 사용시 화면이 아예 멈추는 현상 발생 (TabView 한 개만 View에서 단독사용시 발생 안함) 
* 아직까지는 TabView를 사용하지 말고 UIKit에서 제공하는 UIPageViewController를 사용하거나 SwiftUIPager라이브러리를 사용하자