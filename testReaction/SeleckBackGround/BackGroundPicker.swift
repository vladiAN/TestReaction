//
//  BackGroundPicker.swift
//  testReaction
//
//  Created by Андрушок on 12.12.2022.
//

import UIKit


class BackGroundPicker: UIViewController {
    
    weak var delegate: BackGroundImageDelegate?
    
    let firstBackground = "1"
    let secondBackground = "2"
    let thirdBackground = "3"
    let fourthBackground = "4"
 
    let bigStackImage = UIStackView()
    var arrayButtonImage: [UIButton] = []
    var imageView = UIImageView()
    var volume = MusicControl()
    
    let viewUnderButton: UIView = {
        let viewUnderButton = UIView()
        viewUnderButton.backgroundColor = .clear
        return viewUnderButton
    }()
    
    let buttonSelect: UIButton = {
        let buttonSelect = UIButton()
        buttonSelect.backgroundColor = .brown
        buttonSelect.layer.cornerRadius = 5
        buttonSelect.setTitle("SELECT", for: .normal)
        buttonSelect.layer.masksToBounds = false
        buttonSelect.layer.shadowColor = UIColor.gray.cgColor
        buttonSelect.layer.shadowOffset = CGSize(width: 2, height: 5)
        buttonSelect.layer.shadowOpacity = 0.5
        buttonSelect.layer.shadowRadius = 2
        return buttonSelect
    }()
    
    var arrayImageForBackground: [UIImage] {
        get {
            return [
                UIImage(named: firstBackground)!,
                UIImage(named: secondBackground)!,
                UIImage(named: thirdBackground)!,
                UIImage(named: fourthBackground)!
                ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStackImage()
        setupImageView()
        redBorderBTouch()
        addVolume()
    }

    
//MARK: - Setup Stack View
    
    func setupStackImage() {
        let rows = 2
        let cols = 2
        
        bigStackImage.spacing = 8
        bigStackImage.axis = .vertical
        bigStackImage.distribution = .fillEqually
        
        var indexArrayImageForBackground = 0
        
        for _ in 0..<rows {
            
            let smallStack = UIStackView()
            smallStack.spacing = 8
            smallStack.axis = .horizontal
            smallStack.distribution = .fillEqually

            for _ in 0..<cols {
                
                let imageBackground = UIButton()
                imageBackground.layer.cornerRadius = 5
                imageBackground.layer.masksToBounds = true
                imageBackground.layer.shadowColor = imageBackground.backgroundColor?.cgColor
                imageBackground.layer.shadowOffset = CGSize(width: 2, height: 5)
                imageBackground.layer.shadowOpacity = 0.5
                imageBackground.layer.shadowRadius = 2
                imageBackground.setBackgroundImage(arrayImageForBackground[indexArrayImageForBackground], for: .normal)
                indexArrayImageForBackground += 1
                smallStack.addArrangedSubview(imageBackground)
                arrayButtonImage.append(imageBackground)
            }
            
            bigStackImage.addArrangedSubview(smallStack)
        }
        
        view.addSubview(bigStackImage)
        
        bigStackImage.translatesAutoresizingMaskIntoConstraints = false
        
        bigStackImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bigStackImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        bigStackImage.widthAnchor.constraint(equalToConstant: 300).isActive = true
        bigStackImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true
        
        bigStackImage.addArrangedSubview(viewUnderButton)
        
        buttonSelect.translatesAutoresizingMaskIntoConstraints = false
        
        viewUnderButton.addSubview(buttonSelect)
        
        buttonSelect.widthAnchor.constraint(equalTo: viewUnderButton.widthAnchor, multiplier: 0.3).isActive = true
        buttonSelect.heightAnchor.constraint(equalTo: viewUnderButton.heightAnchor, multiplier: 0.3).isActive = true
        buttonSelect.centerXAnchor.constraint(equalTo: viewUnderButton.centerXAnchor).isActive = true
        buttonSelect.centerYAnchor.constraint(equalTo: viewUnderButton.centerYAnchor).isActive = true
        
        
        buttonSelect.addTarget(self, action: #selector(buttonActionSelect), for: .touchUpInside)
    }
    
    @objc func buttonActionSelect(sender: UIButton!) {
        MusicManager.shared.playTock()
        for i in arrayButtonImage {
            if i.layer.borderWidth == 5 {
                let indexImage = arrayButtonImage.firstIndex(of: i)
                let imageFromArray = arrayImageForBackground[indexImage!]
                self.delegate?.changeBackGround(image: imageFromArray)
                imageView.image = imageFromArray
                
                switch indexImage {
                case 0: UserDefaults.standard.set("1", forKey: "imageBackground")
                case 1: UserDefaults.standard.set("2", forKey: "imageBackground")
                case 2: UserDefaults.standard.set("3", forKey: "imageBackground")
                case 3: UserDefaults.standard.set("4", forKey: "imageBackground")
                default: print("error background")
                }
            }
        }
    }
    
    func redBorderBTouch() {
        for i in 0...arrayButtonImage.count - 1 {
            arrayButtonImage[i].addTarget(self, action: #selector(redBorder), for: .touchUpInside)
            }
    }
    
    @objc func redBorder(_ sender: UIButton) {
        MusicManager.shared.playTock()
        sender.layer.borderWidth = 5
        sender.layer.borderColor = UIColor.red.cgColor
        for i in arrayButtonImage {
            if i != sender {
                i.layer.borderWidth = 0
            }
        }
    }
    
    func setupImageView() {
        
        imageView.bounds = view.bounds
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func addVolume() {
        view.addSubview(volume)
        volume.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        volume.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
}
