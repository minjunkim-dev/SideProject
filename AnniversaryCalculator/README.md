# AnniversaryCalculator
<img src ="https://img.shields.io/badge/Swift-5.5-FA7343?logo=swift&logoColor=white"> <img src="https://img.shields.io/badge/Xcode-13.3-1575F9?logo=Xcode&logoColor=white"> <img src="https://img.shields.io/badge/Platforms-iOS_13.0-Green?style=flat-square">
> 기념일을 계산해주는 화면 구현해보기

* 다국어 지원: 영어, 한국어
* 라이트/다크모드 모두 동일한 테마로만 지원
* 세로모드만 지원

## 기술스택
> SnapKit, Then, SwiftGen

## 이슈 및 해결방법
> 1. UIDatePicker의 preferredDatePickerStyle 프로퍼티
  - iOS 13.4 미만에서는 해당 프로퍼티를 지원하지 않아 별도로 style 설정을 하지 않았음
  - .inline style의 경우 14.0부터, .wheel style의 경우 13.4부터 지원하기에 #available를 활용하여 상황에 따라 설정하였음
> 2. Locale, TimeZone 설정
  - 사용자 설정에 따라 유동적으로 바뀔 수 있게 autoupdatingCurrent 프로퍼티를 활용했으나 Locale은 정상적으로 동작하지 않음을 확인하였음
  - Locale.autoupdatingCurrent.identifier가 (languageCode)-(regionCode) 형식임을 알 수 있는데,
설정에서 언어를 바꾸더라도 languageCode가 변하지 않고 계속 "en"으로 고정됨을 확인하였음
  - Locale.preferredLanguages.first를 통해 사용자가 설정한 languageCode를 가져와 Locale에 적용하였음.
> 3. 라이트/다크모드에 따른 UIDatePicker의 색상 변화
  - 라이트모드인 시뮬레이터에서는 UIDatePicker가 정상적으로 보였으나 다크모드인 디바이스에서는 보이지 않았음
  - UIDatePicker가 모드에 따라 전체적인 색상 및 폰트 색상이 달라짐을 확인하였음
  - 모드 상관없이 배경색을 흰색으로 설정해두었는데 다크모드일 때 UIDatePicker의 폰트 색상이 배경색과 동일한 흰색이라 보이지 않았던 것이었음
  - UIDatePicker의 overrideUserInterfaceStyle 프로퍼티를 .light로 설정하여 모드에 따라 색상이 변하지 않도록 설정하였음
