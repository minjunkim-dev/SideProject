//
//  FilmViewController.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/16.
//

import UIKit
import CoreLocation
import MapKit

final class FilmViewController: UIViewController {
    
    private let mainView = FilmView()
    
    private let locationManager = CLLocationManager()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        locationManager.delegate = self
        
        let font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        let filterItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonClicked))
        configureNavigation(titleColor: .black, titleFont: font, rightItems: [filterItem], barTintColor: .black)
    }
    
    @objc func filterButtonClicked() {
        
        checkUserLocationServicesAuthorization()
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancleTitle = "취소"
        let cancleAction = UIAlertAction(title: cancleTitle, style: .cancel) { _ in
            print("cancle")
        }
        alert.addAction(cancleAction)
        
        
        [
            "메가박스",
            "롯데시네마",
            "CGV",
            "전체보기",
        ].forEach {
            let okAction = UIAlertAction(title: $0, style: .default) { _ in
                print("ok")
            }
            
            alert.addAction(okAction)
        }
        
        
        present(alert, animated: true, completion: nil)
    }
}

extension FilmViewController: MKMapViewDelegate {
    
    func setMapRegion(center: CLLocationCoordinate2D, diameter: CLLocationDistance) {

        let region = MKCoordinateRegion(center: center, latitudinalMeters: diameter, longitudinalMeters: diameter)
        
        MKMapView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.mainView.mapView.setRegion(region, animated: true) // 중심 및 반경 설정
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(#function)
    }
}

// 3. delegate 구현
extension FilmViewController: CLLocationManagerDelegate {
    
    func getDefaultLocation() -> CLLocation {
        
        // 서울시청: 37.5662952, 126.9779451
        let lat = 37.5662952
        let long = 126.9779451
        return CLLocation(latitude: lat, longitude: long)
    }
    
    func getCurrentAddress(location: CLLocation) {
        print(#function)
        
        let geoCoder = CLGeocoder()
        let locale = Locale(identifier: Locale.preferredLanguages.first!)
        
        geoCoder.reverseGeocodeLocation(location, preferredLocale: locale) { placemark, error in
            guard error == nil, let place = placemark?.first else {
                print("주소 설정 불가")
                return
            }
            
            var title = ""
            guard let administrativeArea = place.administrativeArea else {
                self.navigationItem.title = title
                return }
//            print(administrativeArea)
            title += "\(administrativeArea)"
            
            guard let locality = place.locality else {
                self.navigationItem.title = title
                return }
//            print(locality)
            title += " \(locality)"
            
            guard let subLocality = place.subLocality else {
                self.navigationItem.title = title
                return }
//            print(subLocality)
            title += " \(subLocality)"
            
            guard let subThoroughfare = place.subThoroughfare else {
                self.navigationItem.title = title
                return }
//            print(subThoroughfare)
            
            self.navigationItem.title = title
        }
    }
    
    // 4. 사용자가 위치 허용을 한 경우에만 실행됨
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        defer {
            locationManager.stopUpdatingLocation() // start와 짝꿍
        }
        
        print(#function)
        print("locations: \(locations)")
        
        DispatchQueue.main.async {
            
            // 마지막 요소가 최근 위치에 가장 가까움
            if let location = locations.last {
                
                self.getCurrentAddress(location: location)
                
                let coordinate = location.coordinate
                let diameter: CLLocationDistance = 250 * 2 // meter unit(지름이므로 반지름 x2)
                self.setMapRegion(center: coordinate, diameter: diameter)
                
            } else {
                print("Location Can't Find")
            }
        }
    }
    
    // 5. 위치 접근에 실패했을 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    /* 6. iOS14 미만
     앱이 위치 관리자를 생성하고, 승인 상태가 변경이 될때 대리자에게 승인 상태를 알려줌
     - 권한이 변경될 때마다 감지해서 실행이 됨
     - CLLocationManager 인스턴스 생성시에도 실행됨
     */
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
    
    /* 7. iOS14 이상
     앱이 위치 관리자를 생성하고, 승인 상태가 변경이 될때 대리자에게 승인 상태를 알려줌
     - 권한이 변경될 때마다 감지해서 실행이 됨
     - CLLocationManager 인스턴스 생성시에도 실행됨
     */
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
    
    // 8. iOS 버전에 따른 분기 처리와 iOS 위치 서비스 여부 확인
    func checkUserLocationServicesAuthorization() {
        print(#function)
        
        let authorizationStatus: CLAuthorizationStatus // enum
        
        if #available(iOS 14.0, *) { // iOS 14 이상에만 사용 가능
            authorizationStatus = locationManager.authorizationStatus
        } else { // iOS 14 미만에만 사용 가능
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        // iOS 위치 서비스 확인
        if CLLocationManager.locationServicesEnabled() {
            // 권한 상태 확인 및 권한 요청 가능(9번 메서드 실행)
            checkCurrentLocationAuthorization(authorizationStatus: authorizationStatus)
        } else {
            print("iOS 위치 서비스 꺼짐")
            
            DispatchQueue.main.async {

                let location = self.getDefaultLocation()
                self.getCurrentAddress(location: location)

                let diameter: CLLocationDistance = 250 * 2 // meter unit(지름이므로 반지름 x2)
                self.setMapRegion(center: location.coordinate, diameter: diameter)
            }
            
            // required to open settings
        }
    }
    
    // 9. 사용자의 권한 상태 확인 및 권한 요청
    // 사용자가 위치를 허용했는지 유무, 거부했는지 여부 등을 확인
    // (단, iOS 위치 서비스가 가능한지 유무 확인이 선행되어야 함)
    func checkCurrentLocationAuthorization(authorizationStatus: CLAuthorizationStatus) {
        
        switch authorizationStatus {
        case .notDetermined:
            print("NOT DETERMINED")
            
            /* 위치 정확도에 대한 반경 설정
             - default 값이 있기는 함
             - 정확하게 잡을수록 배터리 소모 증가
             */
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() // 앱을 사용하는 동안에 대한 위치 권한 요청
            
        case .restricted, .denied:
            print("RESTRICTED OR DENIED")
            
            DispatchQueue.main.async {

                let location = self.getDefaultLocation()
                self.getCurrentAddress(location: location)

                let diameter: CLLocationDistance = 250 * 2 // meter unit(지름이므로 반지름 x2)
                self.setMapRegion(center: location.coordinate, diameter: diameter)
            }

            // required to open settings
        case .authorizedWhenInUse:
            print("WHEN IN USE")
            locationManager.startUpdatingLocation() // 위치 접근 시작 => didUpdateLocations 실행됨
            
        case .authorizedAlways: // 사용하지 않을 것임
            print("ALWAYS")
            
        @unknown default:
            print("DEFAULT")
        }
        
        // 정확도 상태 체크
        if #available(iOS 14.0, *) {
            
            let accuracyState = locationManager.accuracyAuthorization
            
            switch accuracyState {
            case .fullAccuracy:
                print("FULL")
            case .reducedAccuracy:
                /* 정확도 reduce 상태는...
                 - 정확히 동작하지 않는 앱이 있을 수 있음
                 - 미리 알림기능이 동작하지 않을 수 있음
                 - 1시간에 최대 4번 위치 업데이트
                 - 배터리 소모는 감소함
                 */
                print("REDUCE")
            @unknown default:
                print("DEFAULT")
            }
        }
    }
}
