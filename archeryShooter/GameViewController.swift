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
    var currrentArrowIndex = 0
    var currentPower: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = view as? SKView
        gameScene = GameScene(size: view.bounds.size)
        skView?.presentScene(gameScene)
        gameScene.physicsWorld.contactDelegate = self
        gameScene.delegate = self
        configurePanGesture()
//        skView?.showsPhysics = true 
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    private func configurePanGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        
        if recognizer.state == .Began {
        
        }
        
        if recognizer.state == .Changed {
            let translation = recognizer.translationInView(recognizer.view)
            aimArrow(translation)
        }
        
        if recognizer.state == .Ended {
            
            let force: CGFloat = 1.0
            let gestureVelocity = recognizer.velocityInView(recognizer.view)
            let (xVel, yVel) = (gestureVelocity.x / 6, gestureVelocity.y / 6)
            let impulse = CGVectorMake(xVel * force, yVel * force)
            
            let arrow = gameScene.childNodeWithName("arrow\(currrentArrowIndex)")
            arrow?.physicsBody?.applyImpulse(CGVectorMake(impulse.dx, currentPower))
            
            let respawnDelay = SKAction.waitForDuration(1.0)
            let respawn = SKAction.runBlock() {
                
                let hits = self.gameScene.arrowhead.physicsBody!.allContactedBodies()
                print(hits.contains(self.gameScene.childNodeWithName("X")!.physicsBody!))
                self.scoreArrow(hits)
                self.currrentArrowIndex += 1
                self.gameScene.createArrowWithIndex(self.currrentArrowIndex)
            }
            
            let reload = SKAction.sequence([respawnDelay, respawn])
            arrow?.runAction(reload)
        }
    }
    
    func aimArrow(translation: CGPoint) {
        let changeInPower = translation.y
        let powerScale: CGFloat = 3.0
        var power = changeInPower / powerScale
        power = max(0, power)
        power = min(power, 100)
        
        let arrow = gameScene.childNodeWithName("arrow\(currrentArrowIndex)")
        arrow?.position = CGPointMake(translation.x, -translation.y)
        currentPower = power
    }
    
    func scoreArrow(hits: [SKPhysicsBody]) {
        if hits.contains(self.gameScene.childNodeWithName("X")!.physicsBody!) || hits.contains(self.gameScene.childNodeWithName("Ten")!.physicsBody!) {
            gameScene.score += 10
            gameScene.scoreLabel.text = "\(gameScene.score)"
        } else if hits.contains(self.gameScene.childNodeWithName("Nine")!.physicsBody!) {
            gameScene.score += 9
            gameScene.scoreLabel.text = "\(gameScene.score)"
        } else if hits.contains(self.gameScene.childNodeWithName("Eight")!.physicsBody!) {
            gameScene.score += 8
            gameScene.scoreLabel.text = "\(gameScene.score)"
        } else if hits.contains(self.gameScene.childNodeWithName("Seven")!.physicsBody!) {
            gameScene.score += 7
            gameScene.scoreLabel.text = "\(gameScene.score)"
        } else if hits.contains(self.gameScene.childNodeWithName("Six")!.physicsBody!) {
            gameScene.score += 6
            gameScene.scoreLabel.text = "\(gameScene.score)"
        } else if hits.contains(self.gameScene.childNodeWithName("Five")!.physicsBody!) {
            gameScene.score += 5
            gameScene.scoreLabel.text = "\(gameScene.score)"
        }
    }
}

extension GameViewController: SKSceneDelegate {
    
    func update(currentTime: NSTimeInterval, forScene scene: SKScene) {
        
        let arrowNode = scene.childNodeWithName("arrow\(currrentArrowIndex)")
        let lowestPoint = ((gameScene.size.height - gameScene.fiveRingSize.height) / 2) + (gameScene.size.height / 5) - 250
        
        if arrowNode?.position.y > lowestPoint {
            gameScene.joinArrowToTarget((arrowNode?.physicsBody)!, physicsBodyB: (gameScene.fiveRing?.physicsBody)!)
            
            let delay = SKAction.waitForDuration(0.5)
            let fade = SKAction.fadeOutWithDuration(0.1)
            let arrowExit = SKAction.sequence([delay, fade])
            arrowNode?.runAction(arrowExit)
        }
    }
}


extension GameViewController: SKPhysicsContactDelegate {
    
    func didEndContact(contact: SKPhysicsContact) {
        
        
    }
}

