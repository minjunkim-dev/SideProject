# EmotinalDiary
<img src ="https://img.shields.io/badge/Swift-5.5-FA7343?logo=swift&logoColor=white"> <img src="https://img.shields.io/badge/Xcode-13.3-1575F9?logo=Xcode&logoColor=white"> <img src="https://img.shields.io/badge/Platforms-iOS_13.0-Green?style=flat-square">
> 감정을 기록하는 다이어리 화면 구현해보기

* 다국어 지원: 영어, 한국어
* 라이트/다크모드 모두 동일한 테마로만 지원
* 세로/가로모드 모두 지원

## 기술스택
> SnapKit, Then, SwiftGen, UICollectionView, MVVM Architecture, UserDefaults, propertyWrapper, Localization, delegate pattern

## 이슈 및 해결방법
> 1. 컬렉션 뷰 셀의 크기에 대한 적절한 계산
  - 컬렉션 뷰의 flowLayout에서 설정했던 minimumLineSpacing, minimumInteritemSpacing 프로퍼티의 값을 고려하여 각 셀의 크기를 계산함
> 2. 네비게이션 타이틀 및 버튼 추가
  - 처음에는 루트 뷰컨트롤러를 내가 구현한 EmotionalDiaryViewController로 했는데 네비게이션 컨트롤러를 사용하기 위해,
SceneDelegate에서 루트 뷰컨트롤러를 네비게이션 컨트롤러로 하고, 네비게이션 컨트롤러의 루트 뷰컨트롤러를 EmotionalDiaryViewController로 설정함
  - 이후에 EmotionalDiaryViewController에서 navigationItem.title과 navigationItem.leftBarButtonItem 을 설정함
> 3. 효율적인 컬렉션 뷰 갱신
  - 사용자가 컬렉션 뷰의 셀 하나를 클릭하면 해당 셀의 텍스트(감정 수)만 변경되면 되지만 reloadData() 메서드를 사용하는 것은
모든 셀을 업데이트하는 것이기에 셀의 개수가 늘어날수록 비효율적임
  - reloadItems() 메서드를 사용하여 사용자가 클릭한 셀에 대해서만 갱신할 수 있도록 변경함
> 4. 불필요한 애니메이션 제거
  - 바로 위에서 reloadItems() 메서드를 사용했다고 했는데, 이 경우 애니메이션을 별도로 사용하지 않았는데도 텍스트 변경시 애니메이션이 적용됨을 확인함
  - 이를 제거하기 위해 UIView.performWithoutAnimation를 활용하니 애니메이션 효과가 제거됨
> 5. 가로모드에 적절한 UI 대응 필요
  - 모드에 따라 적절한 UI가 달라지기에 어떤 모드인지 먼저 체크하는 것이 필요함
  - UIDevice.current.orientation.isPortrait를 통해 세로모드 여부를 체크하고자 하였으나,
앱이 켜진 상태에서 화면이 전환될 때는 이것이 정상적으로 적용되나, 앱을 켰을 때는 디바이스 방향을 제대로 체크하지 못함을 확인
  - UIDevice.current.orientation의 경우 첫 화면이 등장하기 전까지는 정상적으로 디바이스 방향을 체크하지 못하는듯 함
  - 그래서 첫 화면을 구성할 때만큼은 UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isPortrait을 통해 디바이스 방향을 확인하여 처리함
  
