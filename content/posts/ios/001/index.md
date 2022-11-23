---
title: "[SwiftUI] WebView 구현하기 1"
date: 2023-11-23T05:41:49Z
draft: true
mermaid: true
math: true
menu:
  sidebar:
    name: "[SwiftUI] WebView 구현하기 1"
    identifier: ios-001
    parent: ios
    weight: 20
tags: ["iOS", "SwiftUI", "WKWebView"]
categories: ["iOS"]
---

> **서론**\
> 앱을 개발하다보면 웹 페이지를 꼭 포함해야하는 경우가 있습니다.\
> 이미 레거시가 웹 기반으로 구현이 되어 있다던지, 
> 결제페이지를 붙여야한다던지, 본인인증 페이지나 카카오 주소검색 페이지를 붙이는 등의 작업이 필요할 때 등의 경우가 있죠.\
> 아래 내용에서는 현재 제가 회사에서 사용하는 웹뷰의 구현 방법에 대해서 말해보도록 하겠습니다.

---
## 프로젝트 세팅
해당 세팅은 웹 페이지 링크도 https이고 내부 리소스 링크도 https만 사용하는 안정적인 페이지의 경우는 건너 뛰셔도 상관이 없습니다.
그러나 경험상 https와 http를 혼용해서 사용하는 경우가 더 많기 때문에 외부 이미지나 스크립트를 끌어다 쓰시는 경우는 아래 설정을 무조건 해주시는 것이 좋습니다.


---
## WebView 구현하기
WebView의 전체 구현 소스를 보면 한눈에 딱 들어오지 않기 때문에 파트를 나눠서 설명하겠습니다.\
우선 SwiftUI에서 WebView를 사용하기 위해서는 `UIKit`에서 제공하는 `WKWebView`를 
`UIViewRepresentable` 프로토콜을 상속받아서 사용해야합니다.

WebView를 생성하고 UIViewRepresentable를 상속받고나서 기본 소스코드는 다음과 같습니다.

`WebView.swift`
```swift
import SwiftUI
import UIKit
import Combine
import WebKit

struct WebView: UIViewRepresentable {

    var url: URL
    
    //뷰를 생성하고 초기 상태를 구성합니다.
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: CGRect.zero)
        webView.load(URLRequest(url: self.url))
        return webView
    }
    
    //SwiftUI의 새로운 정보로 뷰의 상태를 업데이트합니다.
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
```
이런식으로 구현 후 아래 코드로 WebView를 호출을 하면 기본적인 웹뷰는 보입니다.
```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        WebView(url: URL(string: "https://www.google.com")!)
    }
}
```
이제부터 # 붙은 항목을 필요한대로 찾은 후 소스코드에 붙여서 사용하시면 됩니다.

#### # Alert, Confirm 창 띄우기
웹을 사용하다보면 사용자에게 정보를 알려주거나, 확인/취소 등의 피드백을 받기 위해 alert, comfirm 창을 활용해야할 때가 많습니다.
이러한 유저 피드백은 네이티브단에서 웹으로 알려줘야하는데 이것을 연결하는 방법은 다음과 같습니다.

```swift
import SwiftUI
import UIKit
import Combine
import WebKit

struct WebView: UIViewRepresentable {
    
    var url: URL
    
    //뷰를 생성하고 초기 상태를 구성합니다.
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: CGRect.zero)
        webView.uiDelegate = context.coordinator
        webView.load(URLRequest(url: self.url))
        return webView
    }
    
    //SwiftUI의 새로운 정보로 뷰의 상태를 업데이트합니다.
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }

    //뷰에서 SwiftUI 인터페이스의 다른 부분으로 변경 사항을 전달하는 데 사용하는 사용자 정의 인스턴스를 만듭니다.
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, WKUIDelegate {
        //alert
        func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
            //alert 확인 버튼을 누름
            completionHandler()
        }

        //confirm
        func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
            //confrim 버튼을 누름 (확인: true, 취소: false)
            completionHandler(true)
        }
    }
}
```
WebView는 struct이기 때문에 WKUIDelegate를 상속 받을 수 없습니다. 
WebView에 WKUIDelegate를 상속받는 경우 
`Non-class type 'WebView' cannot conform to class protocol 'WKUIDelegate'`에러가 뜨게 됩니다.
해석해보자면 WKUIDelegate는 class protocol이라는 것입니다.

그렇기 때문에 UIViewRepresentable에서 사용하는 makeCoordinator 함수를 이용해봅시다.
Coordinator는 UIViewRepresentable를 상속받은 뷰에서 SWiftUI와 통신하기 위한 사용자 정의 클래스입니다.

Coordinator클래스를 정의 후 `NSObject, WKUIDelegate`를 상속받고 `makeUIView`함수에서 
`webView.uiDelegate = context.coordinator`를 추가해줍니다. 그 후 함수 두개를 추가해줍니다. 

runJavaScriptAlertPanelWithMessage 변수를 가지고 있는 webView함수의 completionHandler를 호출하는 경우 
웹뷰에서는 확인 버튼을 누른 것으로 인식하고
runJavaScriptConfirmPanelWithMessage 변수를 가지고 있는 webView함수의 completionHandler를 호출하는 경우
웹뷰에서는 completionHandler에 입력된 변수에 따라 확인/취소 버튼을 누른것으로 인식합니다.

위에 있는 예시코드를 그대로 사용하는 경우 Alert창이나 Confirm창이 뜨자마자 유저가 확인버튼이나 확인/취소 버튼을 누른 것으로 인식하기 때문에


#### # 외부 링크 연결 (전화결기, 결제하기 등)
```swift
```
#### # Javascript bridge 설정하기
```swift
```
---
## ViewModel 구현하기
```swift
```
---
## WebView 사용하기

```swift
```
---
#### 참고 사이트
* [https://velog.io/@altmshfkgudtjr/SwiftUI에서-WebView를-사용해보자](https://velog.io/@altmshfkgudtjr/SwiftUI%EC%97%90%EC%84%9C-WebView%EB%A5%BC-%EC%82%AC%EC%9A%A9%ED%95%B4%EB%B3%B4%EC%9E%90)
* [https://developer.apple.com/documentation/swiftui/uiviewrepresentable](https://developer.apple.com/documentation/swiftui/uiviewrepresentable)
* 