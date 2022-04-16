//
//  FilmViewController.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/16.
//

import UIKit

final class FilmViewController: UIViewController {

    private let mainView = FilmView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = "영화"
        let font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        let filterItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonClicked))
        configureNavigation(title: title, titleColor: .black, titleFont: font, rightItems: [filterItem], barTintColor: .black)
    }
    
    @objc func filterButtonClicked() {
        
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
