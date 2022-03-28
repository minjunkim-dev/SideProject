//
//  AnniversaryCalculatorViewModel.swift
//  AnniversaryCalculator
//
//  Created by beneDev on 2022/03/28.
//

import Foundation

final class AnniversaryCalculatorViewModel {
    
    var data: Observable<[DDay]> = Observable([])
    
    init() {
        data.value = [
            DDay(dday: 100, image: Assets.image0.image),
            DDay(dday: 200, image: Assets.image1.image),
            DDay(dday: 300, image: Assets.image2.image),
            DDay(dday: 365, image: Assets.image3.image)
        ]
    }
}

extension AnniversaryCalculatorViewModel: UICollectionViewCellRepresentable {
    
    var numberOfItemsInSection: Int {
        return data.value.count
    }
}
