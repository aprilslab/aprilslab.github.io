---
title: "Xcode13 달라진 점"
date: 2022-05-19T11:29:14+09:00
draft: false
mermaid: true
math: true
menu:
  sidebar:
    name: "Xcode13 달라진 점"
    identifier: logs-xcode-xcode13
    parent: logs-xcode
    weight: 10
tags: ["Xcode", "Xcode13"]
categories: ["Xcode"]
---

## Xcode13 달라진 점

&nbsp;

Xcode13으로 업데이트가 되면서 새로운 프로젝트를 생성하게 되면 기존의 프로젝트 생성과는 달라진것이 있습니다. 

&nbsp;

**애플 사이트 설명**
> Xcode 13에는 새롭고 강력한 팀 개발 기능이 추가되어 Xcode Cloud뿐만 아니라 GitHub, Bitbucket 및 GitLab 협업 기능과도 완벽하게 작업할 수 있습니다. Xcode 내에서 바로 Pull Request를 시작, 검토, 주석 달기 및 병합할 수 있습니다. 코드 내에서 팀원의 주석을 볼 수 있으며, 코드 파일의 두 개의 버전을 신속하게 비교해 볼 수도 있습니다.

&nbsp;

Xcoe Cloud, Vim 모드, CarPlay시뮬레이터 등이 추가가 된것 같습니다.\
그러나 기존의 프로젝트를 이어서 개발할 때는 큰 차이를 느끼지 못했습니다.

&nbsp;

그러나 제가 Xcode 13에서 신규 프로젝트를 생성하려고 하니 달라진 점이 보였습니다.

* **Life Cycle**\
Xcode 12에서는 프로젝트 생성당시 Life Cycle을 SwiftUI와 UIKit App Delegate를 선택할 수 있었지만 지금 제가사용하는 Xcode 13.2.1 기준 프로젝트를 생성할 당시 선택권을 주지 않고 `무조건 SwiftUI로 생성`되도록 바뀌었습니다. 이제 AppDelegate나 SceneDelete를 생성하기 위해서는 수동으로 생성해주어야합니다. 
[애플의 공지사항](https://developer.apple.com/news/?id=2t1chhp3)에서 `2022년 4월 25일부터 App Store에 앱을 제출하기 위해서는 Xcode13으로 빌드`해야한다고 하니 참고 바랍니다.

* **info.plist**\
`info.plist`가 사라졌습니다. info.plist를 사용해야하는 경우, 당황하지 말고 `xcodeproj 파일의 Info → Custom iOS Target Properties` 부분을 수정해주면 자동으로 파일이 생성됩니다.

&nbsp;

---

## 결론
* Xcode 13부터는 Life Cycle을 SwiftUI와 UIKit App Delegate를 선택할 수 없다 (무조건 SwiftUI로 생성)
* 2022년 4월 25일부터 App Store에 앱을 제출하기 위해서는 Xcode13으로 빌드해야한다.
* 기존에 개발하던 프로젝트를 Xcode13으로 빌드하는 것은 잘 된다.

&nbsp;

앞으로는 무조건 SwiftUI를 쓰게하겠다는 Apple의 의지가 보이는 것 같습니다.\
iOS개발자 분들은 아직 스토리보드를 쓰고 계시다면 이제부터라도 슬슬 SwiftUI를 공부하시는게 좋을 것 같습니다.