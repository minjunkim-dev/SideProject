//
//  AnniversaryCalculatorViewController.swift
//  AnniversaryCalculator
//
//  Created by beneDev on 2022/03/27.
//

import UIKit

final class AnniversaryCalculatorViewController: UIViewController {
    
    private let mainView = AnniversaryCalculatorView()
    private let viewModel = AnniversaryCalculatorViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        mainView.datePicker.addTarget(self, action: #selector(changeDatePickerValue), for: .valueChanged)
    
    }
    
    @objc private func changeDatePickerValue() {
        
        UserDefaults.baseDate = mainView.datePicker.date
        mainView.collectionView.reloadData()
    }
}

extension AnniversaryCalculatorViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnniversaryCollectionViewCell.reuseIdentifier, for: indexPath) as? AnniversaryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let row = indexPath.row
        let data = viewModel.data.value[row]
        let date = mainView.datePicker.date.addDays(day: data.dday)
        cell.configureCell(data: data, date: date)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
    
        let minimumInteritemSpacingForSectionAt = flowLayout.minimumInteritemSpacing
        let minimumLineSpacingForSectionAt = flowLayout.minimumLineSpacing
        
        let width = collectionView.frame.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right)
        let height = collectionView.frame.height - (flowLayout.sectionInset.top + flowLayout.sectionInset.bottom)
        
        let cellInRow = 2
        let cellInCol = 2
        
        let cellWidth = (width - minimumInteritemSpacingForSectionAt) / CGFloat(cellInRow)
        let cellHeight = (height - minimumLineSpacingForSectionAt) / CGFloat(cellInCol)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
