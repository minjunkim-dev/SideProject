# TrendMedia
<img src ="https://img.shields.io/badge/Swift-5.6-FA7343?logo=swift&logoColor=white"> <img src="https://img.shields.io/badge/Xcode-13.3-1575F9?logo=Xcode&logoColor=white"> <img src="https://img.shields.io/badge/Platforms-iOS_13.0-Green?style=flat-square">
> 다양한 미디어(드라마, 영화, 책) 정보를 제공해주는 앱 만들어보기

* 다국어 지원: 영어, 한국어 지원
* 라이트/다크모드 모두 동일한 테마를 지원
* 현재 세로모드만 지원, 가로모드 지원 예정

## 기술스택
> SnapKit, Then, Kingfisher, SwiftGen, MVVM pattern, Localization, UITableView(+ automaticDimension), UICollectionView, UIAlert, delegate pattern, Mapkit, CoreLocation

## 이슈 및 해결방법
> 1. UITableView의 style를 잘 활용하자
  - 각 셀마다 radius 및 양방향에 inset 적용이 필요했는데 이는 .insetGrouped style을 이용하면 쉽게 해결 가능하였음
  - 다만, 연습을 위해 .plain style로 두고 동일하게 구현하려고 하였음
> 2. Cell의 ContentView
  - 셀 내부의 컨텐츠뷰는 기본적으로 셀을 꽉차게 차지하도록 제약조건이 설정되어 있고, 이를 변경하는 것은 불가능한 것으로 보임
  - 그럼에도 불구하고 셀 자체와 컨텐츠뷰의 inset을 어떻게든 적용하고 싶어서
셀의 layoutSubViews() 메서드에서 컨텐츠뷰의 frame을 조정하여 하위뷰들의 위치와 크기를 재조정되도록 하였음
  - 근데 컨텐츠뷰를 건드는 아이디어는 별로 좋아보이지 않음,
차라리 보여줄 뷰를 담을 용도의 컨테이너 뷰를 하나 만들어 그것을 조정하는게 더 현명한 선택일 것 같다는 생각을 함
> 3. UITableView에서 automaticDimension
  - 테이블뷰의 .rowHeight, .estimeatedHeight 프로퍼티를 UITableView.automaticDimension으로 설정하고,
"반드시" height와 관련된 제약조건을 명확하게 설정해주어야 유동적인 셀의 높이가 정상적으로 구현된다는 것을 잊지 말기
> 4. UISearchBar의 inset?
  - UISearchBar 자체의 height가 일정 이상 크게하면, 내부에 있는 textfield와의 간격이 보기 불편할 정도로 커짐
  - 상황에 따라 이런 inset 자체가 보기에 불편할 수 있으므로, textfield의 제약조건을 변경하여 inset을 없앨 수 있음
> 5. UITableView .plain style 특징
  - 이 스타일의 경우 섹션 헤더의 컨텐츠가 다음 섹션이 나타날 때까지 고정되어 보인다는 점이 있었음
> 6. UITableView .grouped style 특징
  - 이 스타일의 경우 섹션 헤더의 컨텐츠가 스크롤하면 안보이기는 하지만,
문제는 자동으로 섹션 헤더와 푸터에 공간이 생긴다는 점이었음
  - 이 공간을 없애고 싶다면 테이블뷰의 .sectionHeader(or Footer)Height 프로퍼티를 .leastNonzeroMagnitude 값으로 설정하여야 함
  - 위 프로퍼티에 0 값을 설정하면 기본값을 사용한다는 의미여서 공간이 사라지지 않음을 주의!
> 7. 검색 기능 제공시에 일치 조건의 중요성
  - 검색 일치 조건을 명확하게, 또 상세하게 설정해주어야 함. 아니면 원하는대로 검색 결과가 나오지 않음.
  - 예를 들어, sensitive하게 할 것인지 아닌지, 공백 유무에 따라 어떻게 처리할 것인지 등
> 8. UIToolBar 생성시 주의점..?(코드로 UI 잡을 때 기준)
  - UIToolBar 생성시에 frame을 별도로 잡아주지 않으면 제약조건 잡았을 때 경고가 발생함을 확인함(이유는 당최 모르겠음...)
> 9. 테이블뷰의 reloadData() vs reloadRows(or Sections) 메서드
  - 테이블뷰에서 특정 이벤트가 발생했을 때 "한 개의 셀"만 갱신할 필요가 있어서
처음에는 reloadData() 메서드로 갱신했더니 원하는대로 동작하였음
  - 그런데 "한 셀"만 갱신하면 되므로 효율성을 위해 reloadRows()나 reloadSections() 메서드를 사용했더니 원하는대로 동작하지 않았음
  - reloadData()의 경우 기존 셀을 "재사용"하는 것을 확인했으나,
나머지 두 메서드의 경우 셀이 새로 생성되어 셀의 init() 메서드가 호출됨을 확인함
  - reloadData()의 경우 항상 셀을 "재사용"하지만,
나머지 두 메서드는 상황에 따라서는 셀을 재사용하지 않고 새로 생성하여 기존 셀을 대체하는 것으로 보임
> 10. mapkit의 mapView.setRegion() 메서드로 중심 및 반경 설정시 효과
  - setRegion() 메서드만 단순히 사용하면 중심과 반경 설정을 어떻게 하느냐에 따라 불필요하게 움직이는데 오랜 시간이 소요될 수 있음
  - MKMapView.animate() 메서드로 적절히 옵션을 주어 원하는 애니메이션으로 맵뷰가 이동하게 할 수 있음
> 11. locationManagerDidChangeAuthorization 메서드의 정확한 호출 시기
  - 1) CLLocationManager 인스턴스 생성시
  - 2) 위치 권한이 변경될 때마다 감지해서 실행됨
> 12. 사용자가 허용한 권한 상태 확인 및 권한 요청
  - 사용자 허용 권한 상태 확인 및 권한 요청 이전에 반드시 iOS 위치 서비스 허용 여부를 먼저 확인하는 것이 필수적으로 선행되어야 함(CLLocationManager.locationServicesEnabled() 메서드 활용)
  - locationManager.authorizationStatus(iOS 14 이상) or CLLocationManager.authorizationStatus()로 사용자 허용 권한 상태 확인 가능
  - 앱을 사용하는 동안에 대한 위치 권한 요청은 locationManager.requestWhenInUseAuthorization()로 가능
  - 권한이 허용된 상태에서 locationManager.startUpdatingLocation() 메서드를 호출하면 didUpdateLocations 메서드가 호출되며,
작업이 끝난 이후에는 반드시 stopUpdatingLocation() 메서드를 호출해주어야 함
