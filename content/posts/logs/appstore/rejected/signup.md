---
title: "앱스토어 심사 거절 - 회원가입"
date: 2022-05-16T12:15:59+09:00
draft: false
mermaid: true
math: true
menu:
  sidebar:
    name: Signup
    identifier: replace_me
    parent: logs-appstore-rejected
    weight: 10
tags: ["iOS", "Appstore", "심사거절", "Sign up", "회원가입", "In-App Purchase", "Information Needed"]
categories: ["Appstore"]
---

## 앱 구현 상태
---

앱을 새로 개발하면서 앱에 구현했던 회원가입 기능이 문제가 됐습니다.

회원가입 기능은 네이티브로 구현하지 않고 기존에 있는 웹 사이트 회원가입으로 이동하도록 웹뷰를 띄우는 방식으로 구현을 했습니다. 그런데 이것 때문에 앱스토어 심사 거절이 떨어졌습니다.

&nbsp;
## 거절 이력
---

### 1. 외부 결제 유도

> **Guideline 3.1.1 - Business - Payments - `In-App Purchase`**
>
> We found in our review that your app or its metadata provides access to mechanisms other than in-app purchase for purchases or subscriptions to be used in the app, which does not comply with the App Store Review Guidelines. Specifically:
>
> - Your app's registration button (ID creation) includes the following call-to-action and/or URL that directs users to external mechanisms for purchases or subscriptions to be used in the app: 아이디 생성하기
>
> **Next Steps**
> 
> To resolve this issue, please remove features, account registrations links, and any other fully qualified links to your site that could indirectly provide access to external purchase mechanisms.
> 
> If you have any additional information to provide regarding the digital content and services in your app and how the guidelines apply to them, please reply to this message in Resolution Center and let us know. If there is information you'd like us to consider in our review of future submissions, please feel free to include it in the App Review Information section of App Store Connect.

**거절 사유 - 외부 결제 유도** \
대략 정리해보자면 회원가입을 `외부 링크`로 제공하는 경우 그곳에서 `결제나 구독을 유도`할 수 있기 때문에 해당 기능이 들어간다면 In-App Purchase 기능을 이용해야한다는 내용이었습니다.

**시도한 방법**\
일단은 앱을 출시하기 위해 문제가 됐던 `회원가입 기능을 제거`하고 다시 바이너리를 제출했습니다.

&nbsp;

---

### 2. 정보부족
> **Guideline 2.1 - `Information Needed`**
>
> We have started our review, but we need additional information to continue. Specifically, it appears your app accesses or includes paid digital content or services, and we want to understand your business model before completing our review.
>
> **Next Steps**
>
>Please review the following questions and provide as much detailed information about your business model as you can.
>
> 1. Who are the users that will use the paid services in the app?
> 2. Where can users purchase the services that can be accessed in the app?
> 3. What specific types of previously purchased services can a user access in the app?
> 4. What paid content, subscriptions, or features are unlocked within your app that do not use in-app purchase?
>
> Please see attached screenshot for details.
> 
> Since your App Store Connect status is Metadata Rejected, `we do NOT require a new binary`. To revise the metadata, visit App Store Connect to select your app and revise the desired metadata values. Once you’ve completed all changes, reply to this message in Resolution Center and we will continue the review.


**거절 사유 - 정보부족**\
회원가입 기능을 제거하고 새로운 바이너리를 제출하고 심사를 올리자 새로운 바이너리를 요구한적이 없다는 무시무시한 답변이 돌아왔습니다.\
그리고 앱에서 구독이나 결제 시스템을 이용할 것인지, 회사의 비즈니스 모델이 무엇인지 묻는 질문을 보내왔습니다.

**시도한 방법**\
회사의 `비즈니스 모델에 대한 설명`을 적었습니다. 
> 우리의 앱을 이용하는 고객은 회사의 포스기를 사용하는 사장님이다. 우리는 가맹점 계약을 맺은 것으로 수익을 내며 앱은 사장님들에게 드리는 서비스 개념이며 무료로 제공하는 앱이다. 

대략 이런식의 설명을 영어로 번역해서 답변했습니다. 

그리고 `로그인이 필요한 서비스의 경우 회원가입을 제공하지 않는 것 역시 심사 거절의 사유`가된다고 합니다. 그래서 회원가입 기능을 빼도 되는 이유를 설명하기 위해 아래의 내용을 추가해서 보냈습니다.

> 우리는 가맹점 계약을 맺을 당시 아이디가 생셩된다. 그러나 최근 서비스 말고 예전 포스기를 사용하는 사장님의 경우 아이디 생성이 필요하기 때문에 해당 기능을 넣었다. 그러나 이제는 더이상 계약을 하지 않는 포스기이며 점차 최신 포스기로 전환을 유도하고 있다.

그 결과 답변이 받아들여졌고 앱을 배포할 수 있게 되었습니다.

&nbsp;

---

## 결론
* 앱 내 회원가입은 `네이티브로 구현`해야한다.
* 만약 회원가입을 웹으로 제공하여 거절이 난 경우 `비즈니스 모델을 설명`하는 글을 추가해야한다.
* 심사가 거절이 난 경우 거절된 사유에 대해 상세히 설명해야하며 그 도중 새로운 바이너리를 제출해서는 안된다.
