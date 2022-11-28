---
title: "[SwiftUI] WebView 구현하기"
date: 2022-11-25T05:41:49Z
draft: true
mermaid: true
math: true
menu:
  sidebar:
    name: "[SwiftUI] WebView 구현하기"
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
import WebKit

struct WebView: UIViewRepresentable {

    var url: URL
    
    //뷰를 생성하고 초기 상태를 구성한다
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: CGRect.zero)
        webView.load(URLRequest(url: self.url))
        return webView
    }
    
    //SwiftUI의 새로운 정보로 뷰의 상태를 업데이트한다
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
이제부터 좀 더 User Interactive한 WebView를 구현하기 위한 항목을 하나씩 추가해보도록 하겠습니다.

#### # Alert, Confirm 창 띄우기
웹을 사용하다보면 사용자에게 정보를 알려주거나, 확인/취소 등의 피드백을 받기 위해 alert, comfirm 창을 활용해야할 때가 많습니다.
이러한 유저 피드백은 네이티브단에서 웹으로 알려줘야하는데 이것을 연결하는 방법은 다음과 같습니다.

```swift
import SwiftUI
import UIKit
import WebKit

struct WebView: UIViewRepresentable {
    
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: CGRect.zero)
        webView.uiDelegate = context.coordinator
        webView.load(URLRequest(url: self.url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }

    //뷰에서 SwiftUI 인터페이스의 다른 부분으로 변경 사항을 전달하는 데 사용하는 사용자 정의 인스턴스를 만들어준다
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
그렇기 때문에 위에 있는 예시코드를 그대로 사용하는 경우 `Alert창이나 Confirm창이 뜨자마자 유저가 확인버튼이나 확인/취소 버튼을 누른 것으로 인식`하기 때문에 `ViewModel 구현하기`에서 SwiftUI에서 버튼을 누른경우 응답을 하는 동작으로 바꿔보겠습니다.


#### # 외부 링크 연결 (전화결기, 결제하기 등)
전화번호를 연결하거나 메일을 보내거나 결제를 위해 다른 앱을 실행하는 등 http와 https로 시작하지 않는 custom url scheme의 경우 해당 url을 open 해주면 전화를 하거나 메일을 보내거나 새로운 앱을 여는 등의 동작을 할 수 있습니다.\
Coordinator에 WKNavigationDelegate를 상속 받고 WKWebView의 navigation delegate에 Coordinator를 넣어줍니다.
```swift
import SwiftUI
import UIKit
import WebKit

struct WebView: UIViewRepresentable {
    
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: CGRect.zero)
        // coordinator에  WKNavigationDelegate를 상속받고 웹뷰의 navigationDelegate에 넣어준다
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.load(URLRequest(url: self.url))
        return webView
    }
    ...생략...
}

extension WebView.Coordinator: WKNavigationDelegate {
    public func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        // 외부 링크가 아니고 tel, mailto로 시작하는 링크나 특정 앱을 실행하는 url scheme일 경우 링크를 열어준다
        let scheme = navigationAction.request.url?.scheme
        let schemes = ["http", "https", "about"]
        if let scheme = scheme?.lowercased(), !schemes.contains(scheme) {
            UIApplication.shared.open(navigationAction.request.url!, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
            
        } else {
            decisionHandler(.allow)
        }
    }
}
```
#### # Javascript bridge 설정하기
웹뷰에서 네이티브쪽 기능을 호출할 때 Javascript bridge를 이용합니다.
`웹뷰 → 네이티브` 방향 통신입니다.
```swift
import SwiftUI
import UIKit
import WebKit

struct WebView: UIViewRepresentable {
    
    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        // java script bridge를 허용하는 configuration을 생성한 뒤 webview생성할 때 해당 configuration을 넣어준다
        let config = self.getConfig()
        let webView = WKWebView(frame: CGRect.zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.load(URLRequest(url: self.url))
        return webView
    }

    func getConfig() -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration()
        let preferences = WKPreferences()
        
        // iOS 14 이상일 경우
        if #available(iOS 14.0, *) {
            let pagePreferences = WKWebpagePreferences()
            // java script 허용
            pagePreferences.allowsContentJavaScript = true
            configuration.defaultWebpagePreferences = pagePreferences
        } 
        // iOS 13 이하일 경우
        else {
            // java script 허용
            preferences.javaScriptEnabled = true
        }
        
        configuration.preferences = preferences
        configuration.userContentController.add(self.makeCoordinator(), name: "yourBridgeName")
        return configuration
    }
    ...생략...
}

extension WebView.Coordinator: WKScriptMessageHandler {
    public func userContentController(_ userContentController: WKUserContentController,
                                 didReceive message: WKScriptMessage) {
        
        if message.name == "yourBridgeName" {
            //받은 데이터를 출력해본다
            print(message.body)
            // TODO: Your Action
        }
    }
}
```

그렇다면 `네이티브 → 웹뷰` 방향으로 javascript 함수들을 호출하고 싶을 때는 어떻게 해야할까요?
```swift
import SwiftUI
import UIKit
import WebKit

struct WebView: UIViewRepresentable {

    ...생략...
    class Coordinator: NSObject, WKUIDelegate {
        // 첫 생성시 말고도 다른 곳에서도 접근 할 수 있도록 WebView변수를 전역으로 선언한다
        var webView: WKWebView? = nil
        
        ...생략...
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            //웹 뷰 로딩이 끝나면 webView변수를 할당한다
            self.webView = webView
        }

        // java script를 실행한다. 예: alert('hello world!');
        func executeJavaScript(_ script: String) {
            guard let webView = self.webView else { 
                // 아직 웹뷰가 로딩되기 전이면 스크립트를 실행하지 않고 리턴한다
                return
            }

            webView.evaluateJavaScript(script) { result, error in
                if let error = error {
                    print("script error: \(error)")
                }
                
                print("script result: \(result ?? "")")
            }
        }
    }
}

```
WKWebView 내부에 있는 evaluateJavaScript 함수를 쓰면 JavaScript를 실행할 수 있습니다.\
그렇다면 이제 SwiftUI에서 자유롭게 WebView에서 받은 변수에 따른 동작을 정의하거나 WebView를 호출하여 JavaScript를 실행하기 위해서 ViewModel을 생성해주도록 합시다.

---
## ViewModel 구현하기
ViewModel을 구현하는데는 ObservableObject와 Combine을 활요해 보도록 하겠습니다.
ObservableObject에서 Combine을 사용하여 Web 페이지의 변화를 감지해서 @Published 태그가 붙어 있는 변수에 할당해줘서 SwiftUI에서 변화를 감지할 수 있도록 구현해보겠습니다.
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