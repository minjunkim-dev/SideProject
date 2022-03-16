//
//  LEDBoardViewController.swift
//  LEDBoard
//
//  Created by beneDev on 2022/03/14.
//

import UIKit

final class LEDBoardViewController: UIViewController {

    private let mainView = LEDBoardView()
    private let viewModel = LEDBoardViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mainView.changeColorButton.addTarget(self, action: #selector(changeColorButtonClicked), for: .touchUpInside)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tap)
        
        mainView.inputTextField.addTarget(self, action: #selector(UIViewController.dismissKeyboard), for: .editingDidEndOnExit)
        
        mainView.sendTextButton.addTarget(self, action: #selector(sendTextButtonClicked), for: .touchUpInside)
        viewModel.text.bind {
            self.mainView.boardLabel.text = $0
        }
        mainView.boardLabel.text = mainView.inputTextField.placeholder
    }
    
    @objc private func sendTextButtonClicked() {
        viewModel.text.value = mainView.inputTextField.text ?? ""
    }
    
    @objc private func viewTapped() {
        if !(mainView.inputTextField.isEditing) {
            toggleContainerView()
        }
        dismissKeyboard()
    }

    @objc private func changeColorButtonClicked() {
        
        let color = UIColor.random
        mainView.changeColorButton.setTitleColor(color, for: .normal)
        mainView.boardLabel.textColor = color
    }
    
    @objc private func toggleContainerView() {
        mainView.containerView.isHidden.toggle()
    }
}
