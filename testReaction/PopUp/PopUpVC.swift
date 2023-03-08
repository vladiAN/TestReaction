//
//  PopUpVC.swift
//  testReaction
//
//  Created by Андрушок on 22.12.2022.
//

import UIKit

class PopUpVC: UIViewController {
    
    weak var delegate: AlertViewControllerDelegate?
    
    let widthLabelMultiplier = 0.6
    let letheightLabel: CGFloat = 50
    var volume = MusicControl()

    let labelTop: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = label.font.withSize(22)
        label.textAlignment = .center
        label.layer.cornerRadius = 7
        label.layer.masksToBounds = true
        label.backgroundColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelMiddle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.cornerRadius = 7
        label.layer.masksToBounds = true
        label.textColor = .white
        label.font = label.font.withSize(22)
        label.backgroundColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let buttonAction: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 22.0, weight: .regular)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let buttonMenu: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 22.0, weight: .regular)
        button.backgroundColor = .blue
        button.setTitle("Menu", for: .normal)
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goMenu), for: .touchUpInside)
        return button
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = UIStackView.Alignment.center
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(stackView)
        isModalInPresentation = true
        setupStackView()
        setupLabel()
        addVolume()
    }
    
    func setupLabel() {
        labelTop.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthLabelMultiplier).isActive = true
        labelTop.heightAnchor.constraint(equalToConstant: letheightLabel).isActive = true
        
        labelMiddle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthLabelMultiplier).isActive = true
        labelMiddle.heightAnchor.constraint(equalToConstant: letheightLabel).isActive = true
        
        buttonAction.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthLabelMultiplier / 2).isActive = true
        buttonAction.heightAnchor.constraint(equalToConstant: letheightLabel).isActive = true
        
        buttonMenu.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthLabelMultiplier / 2).isActive = true
        buttonMenu.heightAnchor.constraint(equalToConstant: letheightLabel).isActive = true
    }
    
    func setupStackView() {
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        stackView.addArrangedSubview(labelTop)
        stackView.addArrangedSubview(labelMiddle)
        stackView.addArrangedSubview(buttonAction)
        stackView.addArrangedSubview(buttonMenu)
        
        stackView.setCustomSpacing(1, after: labelTop)
        stackView.setCustomSpacing(15, after: labelMiddle)
        stackView.setCustomSpacing(5, after: buttonAction)
    }
    
    func showInfo() {
        labelTop.text = "How to play?"
        labelMiddle.text = "Just Tap"
        buttonAction.setTitle("Go", for: .normal)
        buttonAction.addTarget(self, action: #selector(closeInfo), for: .touchUpInside)
        buttonMenu.isHidden = true
    }
    
    @objc func closeInfo() {
        MusicManager.shared.playTock()
        self.dismiss(animated: true, completion: nil)
    }
    
    func showResult() {
        MusicManager.shared.playTock()
        //labelTop.text = "Your result"
        buttonAction.setTitle("Restart", for: .normal)
        buttonAction.addTarget(self, action: #selector(restartGameButton), for: .touchUpInside) 
    }
    
    @objc func restartGameButton() {
        MusicManager.shared.playTock()
        self.delegate?.restartGame()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func goMenu() {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    func addVolume() {
        view.addSubview(volume)
        volume.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        volume.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
}
