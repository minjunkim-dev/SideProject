//
//  DiaryViewController.swift
//  EmotinalDiary
//
//  Created by beneDev on 2022/03/25.
//

import UIKit

class DiaryViewController: UIViewController, EmotionDelegate {
    
    private let mainView = DiaryView()

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        let image = UIImage(systemName: "list.dash")
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        item.tintColor = .black
        navigationItem.leftBarButtonItem = item
        navigationItem.title = "감정 다이어리"
    }
    
    func addEmotionNumber(tag: Int) {
        print(#function)
        
        if let emotion = Emotion(rawValue: tag) {
            switch emotion {
            case .fun:
                UserDefaults.fun += 1
            case .happy:
                UserDefaults.happy += 1
            case .lovely:
                UserDefaults.lovely += 1
            case .angry:
                UserDefaults.angry += 1
            case .helpless:
                UserDefaults.helpless += 1
            case .tired:
                UserDefaults.tired += 1
            case .embarrassing:
                UserDefaults.embarrassing += 1
            case .depressed:
                UserDefaults.depressed += 1
            case .upset:
                UserDefaults.upset += 1
            }
            mainView.collectionView.reloadData()
        }
    }
}

extension DiaryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmotionCollectionViewCell.reuseIdentifier, for: indexPath) as? EmotionCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.delegate = self
        
        let row = indexPath.row
        cell.tag = row
        
        if let emotion = Emotion(rawValue: row) {
            
            let description = emotion.description
            
            /* UserDefaults를 배열로 관리하면 더 깔끔하게 고칠 수 있지 않을까? */
            var count: Int
            var image: UIImage
            switch emotion {
            case .fun:
                count = UserDefaults.fun
                image = Assets.fun.image
            case .happy:
                count = UserDefaults.happy
                image = Assets.happy.image
            case .lovely:
                count = UserDefaults.lovely
                image = Assets.lovely.image
            case .angry:
                count = UserDefaults.angry
                image = Assets.angry.image
            case .helpless:
                count = UserDefaults.helpless
                image = Assets.helpless.image
            case .tired:
                count = UserDefaults.tired
                image = Assets.tired.image
            case .embarrassing:
                count = UserDefaults.embarrassing
                image = Assets.embarrassing.image
            case .depressed:
                count = UserDefaults.depressed
                image = Assets.depressed.image
            case .upset:
                count = UserDefaults.upset
                image = Assets.upset.image
            }
            
            /* configure cell */
            cell.button.setImage(image, for: .normal)
            cell.label.text = "\(description) \(count)"
        }
        
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
