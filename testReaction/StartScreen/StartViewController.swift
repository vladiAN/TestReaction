//
//  StartViewController.swift
//  testReaction
//
//  Created by Андрушок on 13.12.2022.
//

import UIKit


class StartViewController: UIViewController {
    
    lazy var volume = MusicControl()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var changeBackgroundButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        [playButton, infoButton, changeBackgroundButton].forEach {
            setupButton($0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.insertSubview(imageView, at: 0)
        setBackground()
        addVolume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationGameVC: ViewController = segue.destination as! ViewController
        destinationGameVC.imageView = imageView
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        MusicManager.shared.playTock()
    }
    
    @IBAction func infoButton(_ sender: UIButton) {
        let infoAlert = PopUpVC()
        MusicManager.shared.playTock()
        MusicManager.shared.playVggooh()
        infoAlert.showInfo()
        present(infoAlert, animated: true, completion: nil)
    }
    
    @IBAction func changeBackgroundButtonTapped(_ sender: Any) {
        let backGroundPicker = BackGroundPicker()
        MusicManager.shared.playTock()
        
        backGroundPicker.modalPresentationStyle = .pageSheet
        backGroundPicker.delegate = self
        
        let imageBack = self.imageView.image
        
        if imageView.image == nil {
            backGroundPicker.view.backgroundColor = .white
        } else {
            backGroundPicker.imageView.image = imageBack
        }
        MusicManager.shared.playVggooh()
        show(backGroundPicker, sender: self)
       
    }
    
    func setupButton(_ button: UIButton) {
        button.layer.masksToBounds = false
        button.layer.shadowColor = button.backgroundColor?.cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 5)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2
    }
    
    func setBackground() {
        if let storedBackground = UserDefaults.standard.string(forKey: "imageBackground") {
            imageView.image = UIImage(named: storedBackground)
        } else {
            view.backgroundColor = .white
        }
    }
    
    func addVolume() {
        view.addSubview(volume)
        volume.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        volume.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
}


