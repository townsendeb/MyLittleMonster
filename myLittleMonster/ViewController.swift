//
//  ViewController.swift
//  myLittleMonster
//
//  Created by Eric Townsend on 1/18/16.
//  Copyright © 2016 KrimsonTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    
    @IBOutlet weak var skull1Img: UIImageView!
    @IBOutlet weak var skull2Img: UIImageView!
    @IBOutlet weak var skull3Img: UIImageView!
    
    @IBOutlet weak var startOver: UIButton!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: NSTimer!
    var monsterHappy = false
    var currentItem: UInt32 = 0
    var monsterInGame = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        skull1Img.alpha = DIM_ALPHA
        skull2Img.alpha = DIM_ALPHA
        skull3Img.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        startTimer()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func startGameOver(sender: AnyObject) {
        startOver.hidden = true
        penalties = 0
        viewDidLoad()
        monsterImg.playIdleAnimation()
        
    }

    func itemDroppedOnCharacter(notif: AnyObject) {
        monsterHappy = true
        startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
    }
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changedGameState", userInfo: nil, repeats: true)
    }
    
    func changedGameState() {
        
        if !monsterHappy {
            
    
        penalties++
        if penalties == 1 {
            skull1Img.alpha = OPAQUE
            skull2Img.alpha = DIM_ALPHA
            skull3Img.alpha = DIM_ALPHA
        } else if penalties == 2 {
            skull1Img.alpha = OPAQUE
            skull2Img.alpha = OPAQUE
            skull3Img.alpha = DIM_ALPHA
        } else if penalties >= 3 {
            skull1Img.alpha = OPAQUE
            skull2Img.alpha = OPAQUE
            skull3Img.alpha = OPAQUE
        } else {
            skull1Img.alpha = DIM_ALPHA
            skull2Img.alpha = DIM_ALPHA
            skull3Img.alpha = DIM_ALPHA
        }
        
        if penalties >= MAX_PENALTIES {
            gameOver()
            startOver.hidden = false
        }
    }
        let rand = arc4random_uniform(2) // 0 or 1
        
        if rand == 0 {
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            
            heartImg.alpha = OPAQUE
            heartImg.userInteractionEnabled = true
        } else {
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
            
            foodImg.alpha = OPAQUE
            foodImg.userInteractionEnabled = true
        }
        
        currentItem = rand
        monsterHappy = false
}
    
    func gameOver() {
        timer.invalidate()
        monsterImg.playDeathAnimation()
        }
}

