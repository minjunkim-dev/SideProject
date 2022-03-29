# LEDBoard
### 개발환경 : <img src ="https://img.shields.io/badge/Swift-5.5-FA7343?logo=swift&logoColor=white"> <img src="https://img.shields.io/badge/Xcode-13.3-1575F9?logo=Xcode&logoColor=white"> <img src="https://img.shields.io/badge/Platforms-iOS_13.0-Green?style=flat-square">
> 전광판 기능을 하는 화면 구현해보기

* 다국어 지원: 영어, 한국어
* 라이트/다크모드 모두 동일한 테마로만 지원
* 세로/가로모드 모두 지원

## 기술스택
> SnapKit, Then, MVVM pattern, Localization, UserDefaults, propertyWrapper

## 이슈 및 해결방법
> 1. 스플래시 화면 오류(검정색 화면)
  - 이미지를 바꾸거나, 시스템 이미지를 사용했을 때는 정상 동작하는 것을 확인함
  - 해당 리소스 자체가 과도한 메모리를 차지하여 그런 것으로 판단함
> 2. 전광판 텍스트를 나타내는 UILabel의 유동적인 폰트 크기 설정
  - 사용자가 입력할 텍스트의 길이를 미리 알 수 없으므로 상황에 따라 유동적인 폰트 크기가 가능하게 설정함이 필요함
  - adjustsFontSizeToFitWidth 프로퍼티를 true로 설정하여 UILabel의 너비에 폰트 크기가 adjust 될 수 있게 설정함
  - 여기에 minimumScaleFactor 프로퍼티를 설정하여 폰트 크기가 유동적으로 변화되, 최소로 작아질 수 있는 한계를 지정함
  - 당연히 여러줄로 보일 수 있어야 하므로 numberOfLines 프로퍼티는 0으로 설정함
> 3. UITextField의 패딩에 대한 필요성
  - 텍스트필드의 placeholder 및 text가 패딩을 적용하지 않아서 경계에 너무 딱 달라붙어 보기 불편한 점이 존재함
  - 이를 위해 커스텀 텍스트필드를 만들어 패딩을 적용하고 이 커스텀 텍스트필드를 활용함
  - UITextField의 textRect, placeholderRect, editingRect 메서드를, 원하는 패딩만큼 UIEdgeInsets로 지정하여 오버라이딩 함
  - 스크롤뷰 구현시 주의해야 할 점!
> 4. 상단 뷰(텍스트필드 + 버튼 2개 포함한 뷰)의 토글 기능과 키보드를 내리는 기능의 충돌
  - 루트뷰를 탭했을 때 상단 뷰가 토글되는 기능과 키보드를 내리는 기능을 둘다 추가했을 때 충돌됨을 확인함
  - 텍스트를 입력하기 위해 키보드가 올라와 있을 때 루트뷰를 탭하면 키보드는 내려가지 않고 상단 뷰의 토글 기능만 동작하는 것을 확인함
  - 이를 해결하기 위해 텍스트필드가 수정중이면 토글 기능을 호출하지 않고 키보드를 내리는 기능을 호출하고, 아니라면 그 반대로 동작하게 함
> 5. UserDefaults가 저장 가능한 값에 대한 고려
  - UserDefaults는 기본적으로 Swift의 기본 자료형이나, Data 타입으로 변경해야 저장할 수 있음
  - 사용자가 앱을 다시 켰을 때에도 이전 상태를 유지하기 위해 텍스트 뿐만 아니라 색상을 유지, 관리할 필요가 있었는데
UIColor는 UserDefaults에 그대로 저장이 불가능함
  - 이를 해결하기 위해 UIColor의 RGB, 그리고 alpha 값을 배열로 만들어 저장하고, 이를 가져와서 활용하는 방법을 채택함
