---
title: "[SwiftUI] Layout 선택하기"
hero: "heroes/swiftui.png"
url: "swiftui/select_layout"
date: 2022-11-28T07:55:48Z
draft: false
mermaid: true
math: true
menu:
  sidebar:
    name: Layout 선택하기
    identifier: swiftui-layout-00000
    parent: swiftui-layout
    weight: 10
tags: ["SwiftUI", "Layout"]
categories: ["SwiftUI", "Layout"]
---


## 목표

> 앱 사용자 인터페이스에 가장 적합한 컨테이너뷰를 선택할 수 있다.\
> [참고 및 이미지 출처: developer.apple.com](https://developer.apple.com/documentation/swiftui/picking-container-views-for-your-content)

&nbsp;

----


## 뷰 쌓기

> 뷰를 쌓는 방식은 크게 3가지가 있습니다.
> 1. 세로로 쌓기 (VStack)
> 2. 가로로 쌓기 (HStack)
> 3. 겹쳐서 쌓기 (ZStack)
> 이 3가지만 알아도 뷰를 잘 구성할 수 있습니다.

{{< img src="view_stack.png" width=80% align="center" title="뷰 쌓기" >}}

이미지를 보면 이미지와 텍스트뷰 부분이 겹쳐 있는 것을 볼 수 있습니다. 이 부분은 이미지를 겹치는 ZStack을 이용한 것입니다.\
그리고 텍스트들은 사람의 이름인 `Rachael Chiseck`와 직위인 `Chief Executive Officer`가 상하로 배치된것을 볼 수 있는데 이것은 뷰를 세로로 쌓는 VStack을 이용한것입니다.\
마지막으로 텍스트가 왼쪽으로 붙어있는 것을 볼 수 있죠. 이것은 VStack으로 만든 텍스트 부분과 여백을 만드는 Spacer를 가로로 쌓는 HStack을 이용한 것입니다.

예제 코드를 아래와 같이 작성해 볼 수 있습니다.
```swift
struct PersonView: View {
  var body: some View {
    ZStack(alignment: .bottom) {
      Image("rachael")
        .resizable()
        .scaleToFit()
      HStack {
        VStack {
          Text("Rachael Chiseck")
            .font(.system(size: 18, weight: .bold))
          Text("Chief Executive Officer")
            .font(.system(size: 16, weight: .regular))
        }
        Spacer()
      }
    }
  }
}
```
&nbsp;

이 외에도 View를 그리는 타이밍이 늦는 LazyHStack과 LazyVStack이 있지만 그것은 다른 포스트에서 알아보도록 하겠습니다.