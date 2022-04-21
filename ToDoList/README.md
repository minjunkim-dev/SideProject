# ToDoList
<img src ="https://img.shields.io/badge/Swift-5.5-FA7343?logo=swift&logoColor=white"> <img src="https://img.shields.io/badge/Xcode-13.3-1575F9?logo=Xcode&logoColor=white"> <img src="https://img.shields.io/badge/Platforms-iOS_13.0-Green?style=flat-square">
> 할 일을 등록 및 관리하는 화면 구현해보기

* 다국어 지원: 영어, 한국어 지원
* 라이트/다크모드 모두 동일한 테마를 지원
* 세로/가로모드 모두 지원

## 기술스택
> SnapKit, Then, MVVM Architecture, Localization, UserDefaults, propertyWrapper, UITableView(+ automaticDimension), UIAlert, delegate pattern

## 이슈 및 해결방법
> 1. UISegmentControl 사용시 주의사항
  - .selectedSegmentIndex 프로퍼티 값을 지정해주지 않으면 초기값이 없어 처음 클릭했을 때 애니메이션 효과가 나타나지 않음
> 2. UITableView automaticDimension 적용법
  - 테이블 뷰의 .rowHeight, .estimatedHeight 프로퍼티 모두를 UITableView.automaticDimension으로 설정
  - 가장 주의해야 할 점은, 테이블 뷰 셀 내부의 height와 관련된 오토레이아웃을 전부 제대로 잡아주어야만 정상 동작함을 기억
> 3. 뷰에 나타나는 결과와 실제 데이터와 동기화가 제대로 이루어지는지 항상 확인이 필요
  - 특정 뷰에서 분명히 원하는대로 동작해서 문제가 없는줄 알았으나, 다른 뷰로 갔다가 해당 뷰로 다시 돌아갔을 때 변화가 일어나지 않았음을 확인함
  - 뷰에서 조작을 통해 데이터를 변경하고자 한다면, 반드시 실제 데이터에도 이것이 반영이 되었는지 확인이 필요
> 4. 프로퍼티 옵저버에 대하여...
  - 구조체 배열에 프로퍼티 옵저버를 달아두었는데, 배열에서 구조체 하나가 통째로 바뀌어야 옵저버가 감지하는 줄 알았으나,
  배열에 있는 특정 구조체의 프로퍼티 하나만 변하더라도 옵저버가 감지하는 것을 확인함
> 5. 리팩토링 과정에서 주의해야 한다고 느낀 점
  - 길게 코드로 작성해 놓은 기능을 모듈화하여 사용했을 때 기존과 달리 정상 동작하지 않은 경우를 겪음
  - 이를 제대로 확인하지 않고 커밋을 해버리면 굉장히 번거로울 수 있기 때문에,
  매우 작은 단위라도 단위 별로 테스트하여 정상 동작을 확인하고 넘어가는 습관이 필요할듯

## 출처
앱 아이콘: <a href="https://www.flaticon.com/kr/free-icons/-" title="스티커 메모 아이콘">스티커 메모 아이콘  제작자: kornkun - Flaticon</a>
