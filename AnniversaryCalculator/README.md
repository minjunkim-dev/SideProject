# AnniversaryCalculator
<img src ="https://img.shields.io/badge/Swift-5.5-FA7343?logo=swift&logoColor=white"> <img src="https://img.shields.io/badge/Xcode-13.3-1575F9?logo=Xcode&logoColor=white"> <img src="https://img.shields.io/badge/Platforms-iOS_13.0-Green?style=flat-square">
> 기념일을 계산해주는 화면 구현해보기

* 다국어 지원: 영어, 한국어
* 라이트/다크모드 모두 동일한 테마로만 지원
* 세로모드만 지원

## 기술스택
> SnapKit, Then, SwiftGen, UIDatePicker, UICollectionView, DateFormatter, MVVM pattern, UserDefaults, propertyWrapper, Localization

## 이슈 및 해결방법
> 1. UIDatePicker의 preferredDatePickerStyle 프로퍼티
  - iOS 13.4 미만에서는 해당 프로퍼티를 지원하지 않아 별도로 style 설정을 하지 않음
  - .inline style의 경우 14.0부터, .wheel style의 경우 13.4부터 지원하기에 #available를 활용하여 상황에 따라 설정함
> 2. Locale, TimeZone 설정
  - 사용자 설정에 따라 유동적으로 바뀔 수 있게 autoupdatingCurrent 프로퍼티를 활용했으나 Locale은 정상적으로 동작하지 않음을 확인함
  - Locale.autoupdatingCurrent.identifier가 (languageCode)-(regionCode) 형식임을 알 수 있는데,
설정에서 언어를 바꾸더라도 languageCode가 변하지 않고 계속 "en"으로 고정됨을 확인함
  - Locale.preferredLanguages.first를 통해 사용자가 설정한 languageCode를 가져와 Locale에 적용함
> 3. 라이트/다크모드에 따른 UIDatePicker의 색상 변화
  - 라이트모드인 시뮬레이터에서는 UIDatePicker가 정상적으로 보였으나 다크모드인 디바이스에서는 보이지 않음
  - UIDatePicker가 모드에 따라 전체적인 색상 및 폰트 색상이 달라짐을 확인함
  - 모드 상관없이 배경색을 흰색으로 설정해두었는데 다크모드일 때 UIDatePicker의 폰트 색상이 배경색과 동일한 흰색이라 보이지 않았던 것임
  - UIDatePicker의 overrideUserInterfaceStyle 프로퍼티를 .light로 설정하여 모드에 따라 색상이 변하지 않도록 설정함
> 4. UIImageView의 cornerRadius
  - cornerRaidus 프로퍼티를 적용했으나 실제로 적용되지 않음을 확인함
  - clipsToBounds 프로퍼티를 true로 설정하여 UIImageView 경계를 기준으로 바깥쪽을 잘라 원하는 효과를 얻음
> 5. 컬렉션 뷰 내의 spacing(margin)
  - 컬렉션 뷰의 적절한 셀 간격을 위해 minimumInteritemSpacing, minimumLineSpacing 프로퍼티를 활용함
  - 위 두 프로퍼티는 말 그대로 item, line 사이의 간격만을 설정하므로, 컬렉션 뷰의 시작과 끝 부분에는 간격이 생기지 않음
  - 이를 위해 처음에는 컬렉션 뷰 양 끝쪽 영역을 원하는 간격만큼 줄였으나
이렇게 되면 간격이 있는 것처럼 보이기는 하지만 해당 영역에는 컬렉션 뷰 자체가 없는 것이므로,
스크롤이 필요할 때 해당 영역에서는 스크롤이 안되는 이슈가 발생할 수 있음
  - 따라서 컬렉션 뷰 영역 자체는 그대로 두되, sectionInsets 프로퍼티를 활용하여 원하는 간격을 설정함
> 6. 컬렉션 뷰의 셀 크기 계산
  - 이 앱에서는 각 셀의 크기가 항상 동일하므로 self-sizing은 필요가 없음
  - 정확한 셀 크기 계산을 위해 아래 요소들을 모두 고려함
    * 1. minimumInteritemSpacing, minimumLineSpacing
    * 2. sectionInsets
    * 3. 컬렉션 뷰의 행과 열에서의 셀 수
  - 실제 디바이스 너비, 높이에서 1, 2를 고려하여 실제 셀들이 차지할 수 있는 너비, 높이를 먼저 계산함
  - 계산한 너비, 높이를 3을 고려하여 각 셀들에 동일하게 분배함
 > 7. 디데이를 나타내는 셀 개수의 유동성 고려
  - 이 앱은 현재 디데이의 개수가 총 4개(D+100, 200, 300, 365)이지만 언제든지 확장 가능성이 있을 수 있음
  - 따라서, 디데이 리스트를 별도로 관리하고 이에 기반하여 유동적으로 셀의 개수가 변하게끔 구현함
  - 디데이에 따라 셀 내의 텍스트와 이미지가 변경되어야 하므로,
텍스트와 이미지를 포함하는 구조체를 구성하고 이 구조체 리스트를 관리함
 > 8. Swift Date, 그리고 String
  - Date는 GMT 0이 기본값이므로, 이를 사용자 설정에 맞게 보여주려면 알맞게 변환할 필요가 있음
  - DateFormatter를 통해 Locale, TimeZone, dateFormat을 적절하게 설정하고 String으로 변환하여 사용함
  - 사용자가 선택한 Date의 디데이를 계산할 때는 addingTimeInterval 메서드를 활용하여
D+100, 200, 300, 365일에 해당하는 Date를 계산하고, 이를 적절한 String으로 다시 변환하여 사용함
 > 9. 유저의 편의성 고려 부족
  - 앱 특성상 기준이 되는 Date를 한번 결정하면 자주 변하지 않으므로 사용자가 결정한 Date 정보를 유지, 관리할 필요가 있음
  - UserDefaults를 통해 이 Date 정보를 유지 관리함
 > 10. 가로모드에서의 UI 깨짐현상
  - 프로젝트 설정(Targets-Deployment Info-Device Orientation, Info.plist)에서 분명히 portrait만 가능하게 설정함
  - 그럼에도 불구하고, 디바이스를 가로로 돌렸을 때 세로모드에만 대응한 UI가 그대로 출력되어 깨짐현상이 발생함
  - 이를 해결하기 위해 AppDelegate의 supportedInterfaceOrientationsFor 메서드에서 .portrait만 리턴하게 하여 이슈를 해결함
(근데 아직도 프로젝트 설정은 왜 제대로 적용이 안되었는지 정확한 이유를 모르겠음)
