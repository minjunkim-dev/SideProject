# PracticeTableViewController
<img src ="https://img.shields.io/badge/Swift-5.5-FA7343?logo=swift&logoColor=white"> <img src="https://img.shields.io/badge/Xcode-13.3-1575F9?logo=Xcode&logoColor=white"> <img src="https://img.shields.io/badge/Platforms-iOS_13.0-Green?style=flat-square">
> 스토리보드를 통해 테이블 뷰에서 static, dynamic cell 연습해보기

* 다국어 지원: 한국어만 지원
* 라이트/다크모드에 따라 다른 테마를 지원
* 세로모드만 지원
* Main.storyboard의 entry point를 변경하여 서로 다른 유형의 cell로 구성한 화면을 확인 가능

## 기술스택
> UITableView, UITableViewCell(static, dynamic), Storyboard

## 이슈 및 해결방법
> 1. table view의 cell을 static cell로 사용하고자 한다면
  - UIViewController를 상속받는 일반 뷰 컨트롤러에서는 사용이 불가능
  - UITableViewController를 상속받는 뷰 컨트롤러를 활용해야 사용이 가능
