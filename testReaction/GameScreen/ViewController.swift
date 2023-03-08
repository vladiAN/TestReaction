//
//  ViewController.swift
//  testReaction
//
//  Created by Андрушок on 07.12.2022.
//

import UIKit




class ViewController: UIViewController {
    
    var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer: Timer!
    var startbButton = UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
    var countTouches = 0
    var startGameTime = Date()
    var timeGame = 0.0
    let storedBestTime = UserDefaults.standard
    let popUpResult =  PopUpVC()//AlertViewController()
    var countTimer = 3
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.insertSubview(imageView, at: 0)
        setupTimerLabel()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func setupGameButton() {
        startbButton.center.x = .random(in: view.safeAreaLayoutGuide.layoutFrame.minX + (startbButton.frame.width / 2)...view.safeAreaLayoutGuide.layoutFrame.maxX - (startbButton.frame.width / 2))
        startbButton.center.y = .random(in: view.safeAreaLayoutGuide.layoutFrame.minY + (startbButton.frame.height / 2)...view.safeAreaLayoutGuide.layoutFrame.maxY - (startbButton.frame.height / 2))
        startbButton.setTitle("Catch Me", for: .normal)
        startbButton.backgroundColor = .getRandomColor()
        startbButton.layer.cornerRadius = 20
        startbButton.addTarget(self, action: #selector(pressCatchMe), for: .touchUpInside)
        
        self.view.addSubview(startbButton)
    }
    
    func setupTimerLabel() {
        timerLabel.textColor = .black
        timerLabel.layer.position = view.center
        timerLabel.font = timerLabel.font.withSize(90)
    }
    
    @objc func pressCatchMe() {
        
        MusicManager.shared.playTock()
        startbButton.center.x = .random(in: view.safeAreaLayoutGuide.layoutFrame.minX + (startbButton.frame.width / 2)...view.safeAreaLayoutGuide.layoutFrame.maxX - (startbButton.frame.width / 2))
        startbButton.center.y = .random(in: view.safeAreaLayoutGuide.layoutFrame.minY + (startbButton.frame.height / 2)...view.safeAreaLayoutGuide.layoutFrame.maxY - (startbButton.frame.height / 2))
        
        startbButton.backgroundColor = .getRandomColor()
        countTouches += 1
        
        if countTouches == 2 {
            timeStarrAndFinish()
        }    
    }
    
    func timeStarrAndFinish() {
            timeGame = Double(round(100 * -startGameTime.timeIntervalSinceNow) / 100)
            
            var bestTimeGame = storedBestTime.double(forKey: "bestTime")
            
            if bestTimeGame == 0 {
                bestTimeGame = timeGame
                storedBestTime.set(timeGame, forKey: "bestTime")
            } else if bestTimeGame > timeGame {
                bestTimeGame = timeGame
                storedBestTime.set(timeGame, forKey: "bestTime")
            }
            MusicManager.shared.playOver()
            popUpResult.delegate = self
            popUpResult.labelTop.text = "Your result: \(timeGame)"
            popUpResult.labelMiddle.text = "Best result: \(bestTimeGame)"
            popUpResult.showResult()
            self.present(popUpResult, animated: true, completion: nil)
    }
    
    //MARK: - Timer
    
    @objc func updateTimer() {
        if(countTimer > 0){
            let seconds = String(countTimer % 60)
            timerLabel.text = seconds
            countTimer -= 1
            MusicManager.shared.playTick()
        }else if countTimer == 0 {
            timerLabel.text = "GO"
            countTimer -= 1
            MusicManager.shared.playStart()
        }else if countTimer == -1 {
            timerLabel.text = ""
            setupGameButton()
            startGameTime = Date()
            DispatchQueue.main.async {
                self.timer.invalidate()
            }
        }
    }
}







