//
//  GameViewController.swift
//  archeryShooter
//
//  Created by Brett Berry on 9/17/16.
//  Copyright (c) 2016 Brett Berry. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var gameScene: GameScene!
    var currrentArrow = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = view as? SKView
        gameScene = GameScene(size: view.bounds.size)
        skView?.presentScene(gameScene)
        
        gameScene.backgroundColor = UIColor.whiteColor()
        configurePanGesture()
        skView?.showsPhysics
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    private func configurePanGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        pan.minimumNumberOfTouches = 1
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        
        if recognizer.state == .Ended {
            let force: CGFloat = 1.0
            let gestureVelocity = recognizer.velocityInView(recognizer.view)
            let (xVel, yVel) = (gestureVelocity.x / 6, gestureVelocity.y / 6)
            let impulse = CGVectorMake(xVel * force, yVel * force)
            let arrow = gameScene.childNodeWithName("arrow\(currrentArrow)")
            arrow?.physicsBody?.applyImpulse(impulse)
//            arrow?.physicsBody?.affectedByGravity = true
        }
    }
    
    
}


extension GameViewController: SKPhysicsContactDelegate {

    func didBeginContact(contact: SKPhysicsContact) {
        print("hit")
    }

}
