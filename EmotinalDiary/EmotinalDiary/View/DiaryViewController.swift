//
//  DiaryViewController.swift
//  EmotinalDiary
//
//  Created by beneDev on 2022/03/25.
//

import UIKit

class DiaryViewController: UIViewController {
    
    private let mainView = DiaryView()
    private let viewModel = EmotionalDiaryViewModel()

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        let item = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetButtonClicked))
        item.tintColor = .black
        navigationItem.leftBarButtonItem = item
        navigationItem.title = "감정 다이어리"
        
        viewModel.fun.bind { count in
            let indexPath = IndexPath(row: Emotion.fun.rawValue, section: 0)
            UIView.performWithoutAnimation {
                self.mainView.collectionView.reloadItems(at: [indexPath])
            }
        }
        
        viewModel.happy.bind { count in
            let indexPath = IndexPath(row: Emotion.happy.rawValue, section: 0)
            UIView.performWithoutAnimation {
                self.mainView.collectionView.reloadItems(at: [indexPath])
            }
        }
        
        viewModel.lovely.bind { count in
            let indexPath = IndexPath(row: Emotion.lovely.rawValue, section: 0)
            UIView.performWithoutAnimation {
                self.mainView.collectionView.reloadItems(at: [indexPath])
            }
        }
        
        viewModel.angry.bind { count in
            let indexPath = IndexPath(row: Emotion.angry.rawValue, section: 0)
            UIView.performWithoutAnimation {
                self.mainView.collectionView.reloadItems(at: [indexPath])
            }
        }
        
        viewModel.helpless.bind { count in
            let indexPath = IndexPath(row: Emotion.helpless.rawValue, section: 0)
            UIView.performWithoutAnimation {
                self.mainView.collectionView.reloadItems(at: [indexPath])
            }
        }
    
        viewModel.tired.bind { count in
            let indexPath = IndexPath(row: Emotion.tired.rawValue, section: 0)
            UIView.performWithoutAnimation {
                self.mainView.collectionView.reloadItems(at: [indexPath])
            }
        }
        
        viewModel.embarrassing.bind { count in
            let indexPath = IndexPath(row: Emotion.embarrassing.rawValue, section: 0)
            UIView.performWithoutAnimation {
                self.mainView.collectionView.reloadItems(at: [indexPath])
            }
        }
        
        viewModel.depressed.bind { count in
            let indexPath = IndexPath(row: Emotion.depressed.rawValue, section: 0)
            UIView.performWithoutAnimation {
                self.mainView.collectionView.reloadItems(at: [indexPath])
            }
        }
        
        viewModel.upset.bind { count in
            let indexPath = IndexPath(row: Emotion.upset.rawValue, section: 0)
            UIView.performWithoutAnimation {
                self.mainView.collectionView.reloadItems(at: [indexPath])
            }
        }
    }
    
    @objc func resetButtonClicked() {
        viewModel.resetEmotionNumber()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        viewModel.storeEmotionNumber()
    }
}

extension DiaryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Emotion.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmotionCollectionViewCell.reuseIdentifier, for: indexPath) as? EmotionCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.delegate = viewModel
        
        let row = indexPath.row
        cell.tag = row
        
        var description = ""
        var image = UIImage()
        var count = 0
        
        if let emotion = Emotion(rawValue: row) {
            
            description = emotion.description
        
            /* UserDefaults를 배열로 관리하면 더 깔끔하게 고칠 수 있지 않을까? */
            switch emotion {
            case .fun:
                count = viewModel.fun.value
                image = Assets.fun.image
            case .happy:
                count = viewModel.happy.value
                image = Assets.happy.image
            case .lovely:
                count = viewModel.lovely.value
                image = Assets.lovely.image
            case .angry:
                count = viewModel.angry.value
                image = Assets.angry.image
            case .helpless:
                count = viewModel.helpless.value
                image = Assets.helpless.image
            case .tired:
                count = viewModel.tired.value
                image = Assets.tired.image
            case .embarrassing:
                count = viewModel.embarrassing.value
                image = Assets.embarrassing.image
            case .depressed:
                count = viewModel.depressed.value
                image = Assets.depressed.image
            case .upset:
                count = viewModel.upset.value
                image = Assets.upset.image
            }
        }
        
        /* configure cell */
        let text = "\(description) \(count)"
        cell.configureCell(image: image, text: text)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
        
        let minimumInteritemSpacingForSectionAt = flowLayout.minimumInteritemSpacing
        let minimumLineSpacingForSectionAt = flowLayout.minimumLineSpacing
        
        let width = (collectionView.frame.width - minimumInteritemSpacingForSectionAt * 2) / 3
        let height = (collectionView.frame.height - minimumLineSpacingForSectionAt * 2) / 3
        
        return CGSize(width: width, height: height)
    }
}
