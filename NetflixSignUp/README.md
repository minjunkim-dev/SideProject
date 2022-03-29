# NetflixSignUp
### 개발환경 : <img src ="https://img.shields.io/badge/Swift-5.5-FA7343?logo=swift&logoColor=white"> <img src="https://img.shields.io/badge/Xcode-13.3-1575F9?logo=Xcode&logoColor=white"> <img src="https://img.shields.io/badge/Platforms-iOS_13.0-Green?style=flat-square">
> 넷플릭스 느낌의 회원가입 화면 구현해보기

* 다국어 지원: 영어, 한국어
* 라이트/다크모드 모두 동일한 테마로만 지원
* 세로/가로모드 모두 지원

## 기술스택
> SnapKit, Then, UIStackView, UIScrollView, MVVM pattern, Localization, UIAlert, UISwitch, NotificationCenter

## 이슈 및 해결방법
> 1. UISwitch의 off시 tintColor 설정법
  - UISwitch에는 onTintColor 프로퍼티는 존재하여 on시의 tintColor는 쉽게 설정이 가능하나, off시에는 별도의 tintColor 설정을 위한 프로퍼티가 존재하지 않음
  - 원하는 효과를 내기 위해, backgroundColor를 먼저 설정하고, cornerRadius를 UISwitch의 frame / 2로 설정,
마지막으로 clipsToBounds를 true로 설정하여 목적을 달성함
> 2. 가로모드 UI 대응을 위한 스크롤뷰 추가 필요성
  - 세로모드만 고려했을 때는 스크롤뷰 필요성을 못느꼈지만, 가로모드를 고려했을 때 스크롤 기능이 반드시 필요함
  - 이를 위해 기존의 뷰를 스크롤뷰에 추가하여 스크롤뷰를 컨테이너 뷰처럼 활용함
  - 스크롤뷰 구현시 주의해야 할 점!
    - 스크롤뷰에서 보여줄 컨텐츠 뷰는 스크롤 할 방향에 대한 오토레이아웃을 빠짐없이 설정되어야 함
    - 수직 스크롤을 하고자 하면 컨텐츠 뷰의 너비를 고정, 수평 스크롤을 하고자 하면 컨텐츠 뷰의 높이를 고정해야 함
> 3. 텍스트 입력시 고려사항
  - 텍스트 입력시 키보드가 올라오는데 이때 뷰도 같이 올라오지 않으면 키보드에 가려지는 현상이 발생함
  - 이를 해결하기 위해 처음에는 스크롤뷰의 부모뷰인 루트뷰를 이동시켰으나
사실 스크롤뷰만 이동시키면 되기 때문에 불필요한 작업이기도 했고, 루트뷰를 움직이면 safe area를 침범하는 현상이 발생하기도 함
  - 따라서, 키보드가 올라올 때는 해당 텍스트필드의 frame 높이를 고려하여 스크롤뷰가 움직이게 구현하고,
키보드가 내려갈 때는 스크롤뷰가 원래 위치로 돌아가게 구현함.
  - 스크롤뷰를 움직일 때 setContentOffset 메서드를 활용함.
> 4. 회원가입시 유효성 검사
  - 이 앱의 경우 추가 정보 입력 여부를 결정할 수 있으므로 유저의 선택에 따라 유효성 검사가 추가로 이루어져야 함을 고려하는 것이 필요함
  - 필수정보의 경우 무조건 유효성 검사가 이루어져야 하므로 일단 먼저 필수정보에 대한 유효성 검사를 진행하고,
UISwitch의 on/off 여부에 따라 추가정보에 대한 유효성 검사를 추가적으로 진행함
 
