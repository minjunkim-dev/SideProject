//
//  FilmView.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/16.
//

import UIKit

import SnapKit
import Then

import MapKit

final class FilmView: UIView, ViewPresentable {
    
    let mapView = MKMapView()
    
    let gpsButton = UIButton().then {
        $0.setImage(Assets.place.image, for: .normal)
        
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.setShadow()
    }
    
    func setupView() {
       
        backgroundColor = .white
        
        addSubview(mapView)
        
        mapView.addSubview(gpsButton)
    }
    
    func setupConstraints() {
        
        mapView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        gpsButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.size.equalTo(50)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

