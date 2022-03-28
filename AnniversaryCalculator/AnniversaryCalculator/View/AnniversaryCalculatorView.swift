//
//  AnniversaryCalculatorView.swift
//  AnniversaryCalculator
//
//  Created by beneDev on 2022/03/27.
//

import UIKit

import SnapKit
import Then

final class AnniversaryCalculatorView: UIView, ViewPresentable {
    
    let datePicker = UIDatePicker().then {
        if #available(iOS 14.0, *) {
            $0.preferredDatePickerStyle = .inline
        }
        
        if #available(iOS 13.4, *) {
            $0.preferredDatePickerStyle = .wheels
        }
        
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: Locale.preferredLanguages.first!)
        $0.timeZone = TimeZone(identifier: TimeZone.autoupdatingCurrent.identifier)
    }
    
    func setupView() {
        
        backgroundColor = .white
//        datePicker.setValue(UIColor.black, forKey: "textColor")
//        datePicker.setValue(false, forKeyPath: "highlightsToday")
        datePicker.overrideUserInterfaceStyle = .light

        
        addSubview(datePicker)
    
    }
    
    func setupConstraints() {
        
        datePicker.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            $0.height.equalToSuperview().multipliedBy(0.4)
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
