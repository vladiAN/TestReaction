//
//  Music.swift
//  testReaction
//
//  Created by Андрушок on 23.12.2022.
//

import Foundation
import AVFoundation

extension Notification.Name {
    static let volumeName = NSNotification.Name("Control volume")
}

class MusicManager {

    
    private init() {}
    
    static var shared = MusicManager()
    
    
    var defaultVolume = "on"
    var statusVolume: String {
        get {
            UserDefaults.standard.string(forKey: "volume") ?? defaultVolume
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "volume")
        }
    }
    
    func changeValue(_ volume: String) {
        NotificationCenter.default.post(name: .volumeName, object: volume)
        statusVolume = volume
    }
    
    private func playSound(withId id: Int) {
        AudioServicesPlaySystemSoundWithCompletion(SystemSoundID(id)) {}
    }
    
    func playStart() {
        if statusVolume == "on" {
            self.playSound(withId: 1013)
        }
    }
    
    func playWin() {
        if statusVolume == "on" {
        self.playSound(withId: 1025)
        }
    }
    
    func playTick() {
        if statusVolume == "on" {
        self.playSound(withId: 1103)
        }
    }
    
    func playOver() {
        if statusVolume == "on" {
        self.playSound(withId: 1034)
        }
    }
    
    func playTock() {
        if statusVolume == "on" {
        self.playSound(withId: 1104)
        }
    }
    
    func playVggooh() {
        if statusVolume == "on" {
        self.playSound(withId: 1001)
        }
    }
    
    private var bombSoundEffect: AVAudioPlayer?
    
    func playWoow() {
        let path = Bundle.main.path(forResource: "wooow.wav", ofType: nil)!
        let url = URL(fileURLWithPath: path)

        do {
            bombSoundEffect = try AVAudioPlayer(contentsOf: url)
            bombSoundEffect?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
}
