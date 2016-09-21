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
    
    var previousPower: CGFloat = 0.0
    var currentPower: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = view as? SKView
        gameScene = GameScene(size: view.bounds.size)
        skView?.presentScene(gameScene)
        
        gameScene.backgroundColor = UIColor.whiteColor()
        gameScene.physicsWorld.contactDelegate = self
        gameScene.physicsWorld.gravity = CGVectorMake(0.0, -6.0)
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
            
            print("xVel: \(gestureVelocity.x), yVel: \(gestureVelocity.y)")
            
            let arrow = gameScene.childNodeWithName("arrow\(currrentArrowIndex)")
            arrow?.physicsBody?.applyImpulse(CGVectorMake(impulse.dx, currentPower))
            arrow?.physicsBody?.affectedByGravity = true
            
            let shrink = SKAction.scaleBy(0.75, duration: 0.5)
            arrow?.runAction(shrink)
        }
    }
    
    func aimArrow(translation: CGPoint) {
        
        let changeInPower = translation.y
        let powerScale: CGFloat = 5.0
        
        var power = (previousPower + changeInPower) / powerScale
        power = min(power, 100)
        power = max(power, 0)
        
        let arrow = gameScene.childNodeWithName("arrow\(currrentArrowIndex)")
        arrow?.position = CGPointMake(translation.x, -translation.y)
        
        print("power: \(power)")
        currentPower = power
    }
}


extension GameViewController: SKPhysicsContactDelegate {

    func didBeginContact(contact: SKPhysicsContact) {
        
//        let secondNode = contact.bodyB.node
        
        if (contact.bodyA.categoryBitMask == PhysicsType.arrow && contact.bodyB.categoryBitMask == PhysicsType.xRing) ||
            (contact.bodyA.categoryBitMask == PhysicsType.xRing && contact.bodyB.categoryBitMask == PhysicsType.arrow) {
            print("x hit")
        }
        
        if (contact.bodyA.categoryBitMask == PhysicsType.arrow && contact.bodyB.categoryBitMask == PhysicsType.tenRing) ||
            (contact.bodyA.categoryBitMask == PhysicsType.tenRing && contact.bodyB.categoryBitMask == PhysicsType.arrow) {
            print("10 hit")
        }
        
        if (contact.bodyA.categoryBitMask == PhysicsType.arrow && contact.bodyB.categoryBitMask == PhysicsType.nineRing) ||
            (contact.bodyA.categoryBitMask == PhysicsType.nineRing && contact.bodyB.categoryBitMask == PhysicsType.arrow) {
            print("9 hit")
        }
        
        if (contact.bodyA.categoryBitMask == PhysicsType.arrow && contact.bodyB.categoryBitMask == PhysicsType.eightRing) ||
            (contact.bodyA.categoryBitMask == PhysicsType.eightRing && contact.bodyB.categoryBitMask == PhysicsType.arrow) {
            print("8 hit")
        }
        
        if (contact.bodyA.categoryBitMask == PhysicsType.arrow && contact.bodyB.categoryBitMask == PhysicsType.sevenRing) ||
            (contact.bodyA.categoryBitMask == PhysicsType.sevenRing && contact.bodyB.categoryBitMask == PhysicsType.arrow) {
            print("7 hit")
        }
        
        if (contact.bodyA.categoryBitMask == PhysicsType.arrow && contact.bodyB.categoryBitMask == PhysicsType.sixRing) ||
            (contact.bodyA.categoryBitMask == PhysicsType.sixRing && contact.bodyB.categoryBitMask == PhysicsType.arrow) {
            print("6 hit")
        }
        
        if (contact.bodyA.categoryBitMask == PhysicsType.arrow && contact.bodyB.categoryBitMask == PhysicsType.fiveRing) ||
            (contact.bodyA.categoryBitMask == PhysicsType.fiveRing && contact.bodyB.categoryBitMask == PhysicsType.arrow) {
            print("5 hit")
        }

    }
}




