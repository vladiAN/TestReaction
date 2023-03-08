//
//  MusicControl.swift
//  testReaction
//
//  Created by Андрушок on 26.12.2022.
//

import UIKit

class MusicControl: UIButton {
    
    
     
    var imageButtonMusicOn = UIImage()
    var imageButtonMusicOf = UIImage()
    var volume : Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupButton() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(musicChange), name: .volumeName, object: nil)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let boldConfig = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 35))
        imageButtonMusicOn = UIImage(systemName: "speaker.wave.3.fill", withConfiguration: boldConfig)!
        imageButtonMusicOf = UIImage(systemName: "speaker.fill", withConfiguration: boldConfig)!
        setImage(imageButtonMusicOn, for: .normal)
        
        setupImageVolume(state: MusicManager.shared.statusVolume)
    }
    
    @objc func musicOn() {
        MusicManager.shared.changeValue("on")
    }
    
    @objc func musicOff() {
        MusicManager.shared.changeValue("of")
    }
    
    @objc func musicChange(_ notification: NSNotification) {
        guard let state = notification.object as? String else {
            print("no state provided")
            return
        }
        setupImageVolume(state: state)
    }
    
    func setupImageVolume(state: String) {
        if state == "of" {
            setImage(imageButtonMusicOf, for: .normal)
            addTarget(self, action: #selector(musicOn), for: .touchUpInside)
        } else {
            setImage(imageButtonMusicOn, for: .normal)
            addTarget(self, action: #selector(musicOff), for: .touchUpInside)
        }
    }
}
