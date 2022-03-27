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
        navigationItem.title = "title".localized()
        
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
            let indexPath = IndexPath(row: Emotion.embarrassed.rawValue, section: 0)
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
            image = emotion.image
            
            switch emotion {
            case .fun:
                count = viewModel.fun.value
            case .happy:
                count = viewModel.happy.value
            case .lovely:
                count = viewModel.lovely.value
            case .angry:
                count = viewModel.angry.value
            case .helpless:
                count = viewModel.helpless.value
            case .tired:
                count = viewModel.tired.value
            case .embarrassed:
                count = viewModel.embarrassing.value
            case .depressed:
                count = viewModel.depressed.value
            case .upset:
                count = viewModel.upset.value
            }
        }
        
        /* configure cell */
        let text = "\(description) \(count)"
        cell.configureCell(image: image, text: text)
        
        return cell
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

extension DiaryViewController {
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        let isPortrait = UIDevice.current.orientation.isPortrait
        isPortrait ?
        mainView.collectionView.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalTo(mainView.safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(mainView.collectionView.snp.width)
        } :
        mainView.collectionView.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.verticalEdges.equalTo(mainView.safeAreaLayoutGuide)
            $0.width.equalTo(mainView.collectionView.snp.height)
        }
        
        mainView.collectionView.reloadData()
    }
}
