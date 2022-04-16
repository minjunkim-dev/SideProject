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
    
    func setupView() {
       
        backgroundColor = .white
        
        addSubview(mapView)
    }
    
    func setupConstraints() {
        
        mapView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
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

