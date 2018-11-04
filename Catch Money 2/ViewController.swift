//
//  ViewController.swift
//  Catch Money
//
//  Created by Enes Reha GILBAZ on 3.11.2018.
//  Copyright © 2018 Enes Reha GILBAZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var money1: UIImageView!
    @IBOutlet weak var money2: UIImageView!
    @IBOutlet weak var money3: UIImageView!
    @IBOutlet weak var money4: UIImageView!
    @IBOutlet weak var money5: UIImageView!
    @IBOutlet weak var money6: UIImageView!
    @IBOutlet weak var money7: UIImageView!
    @IBOutlet weak var money8: UIImageView!
    @IBOutlet weak var money9: UIImageView!
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var moneyArray = [UIImageView]()
    var hideTimer = Timer()
    
    override func viewDidLoad() {
        
        scoreLabel.text = "Score:   \(score)"
        
        let highScore = UserDefaults.standard.object(forKey:"highScore")
        
        if highScore == nil {
            
            highScoreLabel.text = String(0)
            
        }
        
        if let newScore = highScore as? Int {
            
            highScoreLabel.text = String(newScore)
            
        }
        
        
        
        
        //Recognizer Group
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        
        
        //Interaction Enable Group
        
        money1.isUserInteractionEnabled = true
        money2.isUserInteractionEnabled = true
        money3.isUserInteractionEnabled = true
        money4.isUserInteractionEnabled = true
        money5.isUserInteractionEnabled = true
        money6.isUserInteractionEnabled = true
        money7.isUserInteractionEnabled = true
        money8.isUserInteractionEnabled = true
        money9.isUserInteractionEnabled = true
        
        
        //Add Recognizer Link Group
        
        money1.addGestureRecognizer(recognizer1)
        money2.addGestureRecognizer(recognizer2)
        money3.addGestureRecognizer(recognizer3)
        money4.addGestureRecognizer(recognizer4)
        money5.addGestureRecognizer(recognizer5)
        money6.addGestureRecognizer(recognizer6)
        money7.addGestureRecognizer(recognizer7)
        money8.addGestureRecognizer(recognizer8)
        money9.addGestureRecognizer(recognizer9)
        
        
        //Timers
        
        counter = 30
        timerLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideMoney), userInfo: nil, repeats: true)
       
        
        
        //Arrays
        
        moneyArray.append(money1)
        moneyArray.append(money2)
        moneyArray.append(money3)
        moneyArray.append(money4)
        moneyArray.append(money5)
        moneyArray.append(money6)
        moneyArray.append(money7)
        moneyArray.append(money8)
        moneyArray.append(money9)
        moneyArray.append(money6)
        
        hideMoney()
        
        
    }
    @objc func hideMoney(){
        
        for money in moneyArray{
            
            money.isHidden = true
            
        }
        
        let random = Int(arc4random_uniform(UInt32(moneyArray.count - 1)))
        moneyArray[random].isHidden = false
        
        
        
    }
    
    
    
    
    
    
    
    
    @objc func countDown(){
        
        counter -= 1
        timerLabel.text = String(counter)
        
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            
            if score > Int(highScoreLabel.text!)! {
                
                UserDefaults.standard.set(self.score, forKey: "highScore")
                highScoreLabel.text = String(self.score)
                
            }
            
            let alert = UIAlertController(title: "Finish", message: "Time Out", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction)
                in
                
                self.score = 0
                self.scoreLabel.text = "Score:  \(self.score)"
                self.counter = 30
                self.timerLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideMoney), userInfo: nil, repeats: true)
                
            }
            
            
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
    }
    
    @objc func increaseScore (){
        
        score += 1
        scoreLabel.text = "Score:   \(score)"
    }
    
}
