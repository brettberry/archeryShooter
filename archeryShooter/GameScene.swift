//
//  GameScene.swift
//  archeryShooter
//
//  Created by Brett Berry on 9/17/16.
//  Copyright (c) 2016 Brett Berry. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var scoreLabel: SKLabelNode!
    var targetHit: SKPhysicsJointFixed!
    var fiveRing: SKShapeNode!
    var arrow: SKShapeNode!
    var arrowRect: CGRect!
    
    override init(size: CGSize) {
        super.init(size: size)
        createTarget()
        createArrowWithIndex(0)
        createScoreLabel(0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createTarget() {
        
        let target = size.width / 3
        let targetVertOffset = size.height / 5
        
        let fiveRingSize = CGSizeMake(target + 50, target + 50)
        let fiveRingPoint = CGPointMake((size.width - fiveRingSize.width) / 2, (size.height - fiveRingSize.height) / 2 + targetVertOffset)
        let fiveRingRect = CGRectMake(fiveRingPoint.x, fiveRingPoint.y, fiveRingSize.width, fiveRingSize.height)
        let fiveRingPath = CGPathCreateWithEllipseInRect(fiveRingRect, nil)
        fiveRing = SKShapeNode(path: fiveRingPath)
        fiveRing.fillColor = Colors.blue
        fiveRing.strokeColor = Colors.blue
        addChild(fiveRing)
        
        let center = CGPointMake(fiveRingPoint.x + fiveRingSize.width / 2, fiveRingPoint.y + fiveRingSize.height / 2)
        let fiveBody = SKPhysicsBody(circleOfRadius: fiveRingSize.width / 2, center: center)
        fiveBody.affectedByGravity = false
        fiveBody.categoryBitMask = PhysicsType.target
        fiveBody.collisionBitMask = PhysicsType.none
        fiveBody.contactTestBitMask = PhysicsType.arrow
        fiveBody.dynamic = false
        fiveBody.usesPreciseCollisionDetection = true
        fiveRing.physicsBody = fiveBody
        
        let sixRingSize = CGSizeMake(target + 25, target + 25)
        let sixRingPoint = CGPointMake((size.width - sixRingSize.width) / 2, (size.height - sixRingSize.height) / 2 + targetVertOffset)
        let sixRingRect = CGRectMake(sixRingPoint.x, sixRingPoint.y, sixRingSize.width, sixRingSize.height)
        let sixRingPath = CGPathCreateWithEllipseInRect(sixRingRect, nil)
        let sixRing = SKShapeNode(path: sixRingPath)
        sixRing.fillColor = Colors.blue
        sixRing.strokeColor = Colors.blue
        addChild(sixRing)
        
        let sixBody = SKPhysicsBody(circleOfRadius: sixRingSize.width / 2, center: sixRingPoint)
        sixBody.affectedByGravity = false
        sixBody.categoryBitMask = PhysicsType.sixRing
        sixBody.collisionBitMask = PhysicsType.none
        sixBody.contactTestBitMask = PhysicsType.arrow
        sixBody.usesPreciseCollisionDetection = true
        sixRing.physicsBody = sixBody
        
        let sevenRingSize = CGSizeMake(target, target)
        let sevenRingPoint = CGPointMake((size.width - sevenRingSize.width) / 2, (size.height - sevenRingSize.height) / 2 + targetVertOffset)
        let sevenRingRect = CGRectMake(sevenRingPoint.x, sevenRingPoint.y, sevenRingSize.width, sevenRingSize.height)
        let sevenRingPath = CGPathCreateWithEllipseInRect(sevenRingRect, nil)
        let sevenRing = SKShapeNode(path: sevenRingPath)
        sevenRing.fillColor = Colors.red
        sevenRing.strokeColor = Colors.red
        addChild(sevenRing)
        
        let sevenBody = SKPhysicsBody(circleOfRadius: sevenRingSize.width / 2, center: sevenRingPoint)
        sevenBody.affectedByGravity = false
        sevenBody.categoryBitMask = PhysicsType.sevenRing
        sevenBody.collisionBitMask = PhysicsType.none
        sevenBody.contactTestBitMask = PhysicsType.arrow
        sevenBody.usesPreciseCollisionDetection = true
        sevenRing.physicsBody = sevenBody
    
        let eightRingSize = CGSizeMake(target - 25, target - 25)
        let eightRingPoint = CGPointMake((size.width - eightRingSize.width) / 2, (size.height - eightRingSize.height) / 2 + targetVertOffset)
        let eightRingRect = CGRectMake(eightRingPoint.x, eightRingPoint.y, eightRingSize.width, eightRingSize.height)
        let eightRingPath = CGPathCreateWithEllipseInRect(eightRingRect, nil)
        let eightRing = SKShapeNode(path: eightRingPath)
        eightRing.fillColor = Colors.red
        eightRing.strokeColor = Colors.red
        addChild(eightRing)
        
        let eightBody = SKPhysicsBody(circleOfRadius: eightRingSize.width / 2, center: eightRingPoint)
        eightBody.affectedByGravity = false
        eightBody.categoryBitMask = PhysicsType.eightRing
        eightBody.collisionBitMask = PhysicsType.none
        eightBody.contactTestBitMask = PhysicsType.arrow
        eightBody.usesPreciseCollisionDetection = true
        eightRing.physicsBody = eightBody
        
        let nineRingSize = CGSizeMake(target - 50, target - 50)
        let nineRingPoint = CGPointMake((size.width - nineRingSize.width) / 2, (size.height - nineRingSize.height) / 2 + targetVertOffset)
        let nineRingRect = CGRectMake(nineRingPoint.x, nineRingPoint.y, nineRingSize.width, nineRingSize.height)
        let nineRingPath = CGPathCreateWithEllipseInRect(nineRingRect, nil)
        let nineRing = SKShapeNode(path: nineRingPath)
        nineRing.fillColor = Colors.yellow
        nineRing.strokeColor = Colors.yellow
        addChild(nineRing)
        
        let nineBody = SKPhysicsBody(circleOfRadius: nineRingSize.width / 2, center: nineRingPoint)
        nineBody.affectedByGravity = false
        nineBody.categoryBitMask = PhysicsType.nineRing
        nineBody.collisionBitMask = PhysicsType.none
        nineBody.contactTestBitMask = PhysicsType.arrow
        nineBody.usesPreciseCollisionDetection = true
        nineRing.physicsBody = nineBody
        
        let tenRingSize = CGSizeMake(target - 75, target - 75)
        let tenRingPoint = CGPointMake((size.width - tenRingSize.width) / 2, (size.height - tenRingSize.height) / 2 + targetVertOffset)
        let tenRingRect = CGRectMake(tenRingPoint.x, tenRingPoint.y, tenRingSize.width, tenRingSize.height)
        let tenRingPath = CGPathCreateWithEllipseInRect(tenRingRect, nil)
        let tenRing = SKShapeNode(path: tenRingPath)
        tenRing.fillColor = Colors.yellow
        tenRing.strokeColor = Colors.yellow
        addChild(tenRing)
        
        let tenBody = SKPhysicsBody(circleOfRadius: tenRingSize.width / 2, center: tenRingPoint)
        tenBody.affectedByGravity = false
        tenBody.categoryBitMask = PhysicsType.tenRing
        tenBody.collisionBitMask = PhysicsType.none
        tenBody.contactTestBitMask = PhysicsType.arrow
        tenBody.usesPreciseCollisionDetection = true
        tenRing.physicsBody = tenBody
        
        let xRingSize = CGSizeMake(target - 100, target - 100)
        let xRingPoint = CGPointMake((size.width - xRingSize.width) / 2, (size.height - xRingSize.height) / 2 + targetVertOffset)
        let xRingRect = CGRectMake(xRingPoint.x, xRingPoint.y, xRingSize.width, xRingSize.height)
        let xRingPath = CGPathCreateWithEllipseInRect(xRingRect, nil)
        let xRing = SKShapeNode(path: xRingPath)
        xRing.fillColor = Colors.yellow
        xRing.strokeColor = UIColor.clearColor()
        addChild(xRing)
        
        let xBody = SKPhysicsBody(circleOfRadius: xRingSize.width / 2, center: xRingPoint)
        xBody.affectedByGravity = false
        xBody.categoryBitMask = PhysicsType.xRing
        xBody.collisionBitMask = PhysicsType.none
        xBody.contactTestBitMask = PhysicsType.arrow
        xBody.usesPreciseCollisionDetection = true
        xRing.physicsBody = xBody
    }
    
    func createArrowWithIndex(index: Int) {
        
        let arrowSize = CGSizeMake(5, 150)
        let arrowPoint = CGPointMake((size.width - arrowSize.width) / 2, (size.height - arrowSize.height) / 2 - 100)
        arrowRect = CGRectMake(arrowPoint.x, arrowPoint.y, arrowSize.width, arrowSize.height)
        let arrowPath = CGPathCreateWithRect(arrowRect, nil)
        arrow = SKShapeNode(path: arrowPath)
        arrow.fillColor = UIColor.blackColor()
        arrow.strokeColor = UIColor.clearColor()
        arrow.name = "arrow\(index)"
        addChild(arrow)
        
        let center = CGPointMake(arrowPoint.x + arrowSize.width / 2, arrowPoint.y + arrowSize.height / 2)
        let arrowBody = SKPhysicsBody(rectangleOfSize: arrowSize, center: center)
        arrowBody.affectedByGravity = false
        arrowBody.categoryBitMask = PhysicsType.arrow
        arrowBody.contactTestBitMask = PhysicsType.target
        // PhysicsType.xRing | PhysicsType.tenRing | PhysicsType.nineRing | PhysicsType.eightRing | PhysicsType.sevenRing | PhysicsType.sixRing | PhysicsType.fiveRing
        
        arrowBody.collisionBitMask = PhysicsType.none
        arrowBody.usesPreciseCollisionDetection = true
        arrow.physicsBody = arrowBody
        
        let fadeIn = SKAction.fadeInWithDuration(1.0)
        arrow.runAction(fadeIn)
    }
    
    func createScoreLabel(score: Int) {
        scoreLabel = SKLabelNode()
        scoreLabel.text = "\(score)"
        scoreLabel.fontSize = UIFont.systemFontSize() * 5
        scoreLabel.fontColor = UIColor.lightGrayColor()
        scoreLabel.position = CGPointMake(size.width / 2, size.height - 75)
        addChild(scoreLabel)
    }
    
    func joinArrowToTarget() {
        targetHit = SKPhysicsJointFixed.jointWithBodyA(arrow.physicsBody!, bodyB: fiveRing.physicsBody!, anchor: CGPointZero)
        physicsWorld.addJoint(targetHit)
    }
}


struct Colors {
    static let blue = UIColor(red: 105/255, green: 127/255, blue: 1, alpha: 1)
    static let red = UIColor(red: 1, green: 97/255, blue: 76/255, alpha: 1)
    static let yellow = UIColor(red: 1, green: 246/255, blue: 116/255, alpha: 1)
}
