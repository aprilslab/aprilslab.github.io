---
title: "NavigationLink 이동하자마자 뒤로 가는 현상 해결 방법"
date: 2022-05-17T11:00:45+09:00
draft: false
mermaid: true
math: true
menu:
  sidebar:
    name: "NavigationLink 이동하자마자 뒤로 가는 현상 해결 방법"
    identifier: logs-swiftui-navi
    parent: logs-swiftui
    weight: 10
tags: ["SwiftUI", "NavigationLink"]
categories: ["SwiftUI", "Error"]
---

## 증상

> NavigationLink로 페이지를 `이동하자마자 뒤로 가는` 현상

SwiftUI로 개발을 하다보면 NavigationLink를 사용하는 경우가 많습니다.\
그런데 SwiftUI로 NavigationLink를 사용하다보면 NavigationLink로 `페이지를 이동하자마자 뒤로 가는 현상`이 발생하는 황당한 경우가 있습니다.

그렇습니다. SwiftUI 버그입니다..... 

&nbsp;

---

## 해결방법

> 빈 링크를 3개 넣어준다.
> ```swift
> NavigationLink(destination: EmptyView()) {EmptyView()}
> NavigationLink(destination: EmptyView()) {EmptyView()}
> NavigationLink(destination: EmptyView()) {EmptyView()}
> ```

해결방법 자체는 간단합니다.

SwiftUI 자체 버그가 발생하는 경우 꼼수로 해결하는 수 밖에 없습니다.\
EmptyView로 이동하는 빈 NavigationLink를 링크를 3개 더 넣어줍니다.

아래에 예시코드코드처럼 뷰 안에 빈 링크 `NavigationLink(destination: EmptyView()) {EmptyView()}`를 3개 넣어줍시다.

```Swift

import SwiftUI

struct CustomView: View {

    var body: some View {
        
        VStack {
          NavigationLink(destination: NextView()) { Text("여기로 이동") }
        }
        .background(
          //SwiftUI 자체 버그로 인해 필요한 Dummy View
          VStack {
              NavigationLink(destination: EmptyView()) {EmptyView()}
              NavigationLink(destination: EmptyView()) {EmptyView()}
              NavigationLink(destination: EmptyView()) {EmptyView()}
          }
        )
    }
}

```

테스트를 해보면 잘 동작하는 것을 확인할 수 있습니다.

&nbsp;

---

## 결론
* 3개 이하의 NavigationLink를 사용시 iOS 14 버전에서 뒤로가는 버그가 발생한다.
* iOS 14 버전을 지원해야한다면 빈 NavigationLink를 3개는 추가로 넣어준다.