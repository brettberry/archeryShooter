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

    var previousAngle: CGFloat = 0.0
    var currentAngle: CGFloat = 0.0
    
    var previousPower: CGFloat = 0.0
    var currentPower: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = view as? SKView
        gameScene = GameScene(size: view.bounds.size)
        skView?.presentScene(gameScene)
        
        gameScene.backgroundColor = UIColor.whiteColor()
        gameScene.physicsWorld.contactDelegate = self
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
            
            
            let shrink = SKAction.scaleBy(0.75, duration: 1.5)
            arrow?.runAction(shrink)
        }
    }
    
    func aimArrow(translation: CGPoint) {
        
        let changeInAngle = translation.x
        let changeInPower = translation.y
        let powerScale: CGFloat = 2.0
        let angleScale: CGFloat = -100.0
        
        var power = (previousPower + changeInPower) / powerScale
        power = min(power, 100)
        power = max(power, 0)
        
        let angle = (previousAngle + changeInAngle) / angleScale
        
        let arrow = gameScene.childNodeWithName("arrow\(currrentArrowIndex)")
//        arrow?.zRotation = angle
        arrow?.position = CGPointMake(translation.x, gameScene.arrowPoint.y)
        
        print("power: \(power)")
        
        currentAngle = angle
        currentPower = power
    }
}


extension GameViewController: SKPhysicsContactDelegate {

    func didBeginContact(contact: SKPhysicsContact) {
        
//        let secondNode = contact.bodyB.node
        
        if (contact.bodyA.categoryBitMask == PhysicsType.arrow && contact.bodyB.categoryBitMask == PhysicsType.target) ||
            (contact.bodyA.categoryBitMask == PhysicsType.target && contact.bodyB.categoryBitMask == PhysicsType.arrow) {
            print("hit")
        }
    }

}
