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
    var score: Int = 0
    
    var targetHit: SKPhysicsJointFixed!
    var fiveRing: SKShapeNode!
    var arrow: SKShapeNode!
    var arrowRect: CGRect!
    var fiveRingSize: CGSize!
    var sixRing: SKShapeNode!
    var arrowhead: SKShapeNode!
    
    override init(size: CGSize) {
        super.init(size: size)
        createTarget()
        createArrowWithIndex(0)
        createScoreLabel(score)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createTarget() {
        
        let target = size.width / 3
        let targetVertOffset = size.height / 4
        
        fiveRingSize = CGSizeMake(target + 50, target + 50)
        let fiveRingPoint = CGPointMake((size.width - fiveRingSize.width) / 2, (size.height - fiveRingSize.height) / 2 + targetVertOffset)
        let fiveRingRect = CGRectMake(fiveRingPoint.x, fiveRingPoint.y, fiveRingSize.width, fiveRingSize.height)
        let fiveRingPath = CGPathCreateWithEllipseInRect(fiveRingRect, nil)
        fiveRing = SKShapeNode(path: fiveRingPath)
        fiveRing.fillColor = Colors.darkBlue
        fiveRing.strokeColor = Colors.darkBlue
        fiveRing.name = "Five"
        addChild(fiveRing)
        
        let fiveCenter = CGPointMake(fiveRingPoint.x + fiveRingSize.width / 2, fiveRingPoint.y + fiveRingSize.height / 2)
        let fiveBody = SKPhysicsBody(circleOfRadius: fiveRingSize.width / 2, center: fiveCenter)
        fiveBody.affectedByGravity = false
        fiveBody.categoryBitMask = PhysicsType.target
        fiveBody.collisionBitMask = PhysicsType.none
        fiveBody.contactTestBitMask = PhysicsType.arrow
        fiveBody.dynamic = false
//        fiveBody.usesPreciseCollisionDetection = true
        fiveRing.physicsBody = fiveBody
        
        let sixRingSize = CGSizeMake(target + 25, target + 25)
        let sixRingPoint = CGPointMake((size.width - sixRingSize.width) / 2, (size.height - sixRingSize.height) / 2 + targetVertOffset)
        let sixRingRect = CGRectMake(sixRingPoint.x, sixRingPoint.y, sixRingSize.width, sixRingSize.height)
        let sixRingPath = CGPathCreateWithEllipseInRect(sixRingRect, nil)
        sixRing = SKShapeNode(path: sixRingPath)
        sixRing.fillColor = Colors.blue
        sixRing.strokeColor = Colors.blue
        sixRing.name = "Six"
        addChild(sixRing)
        
        let sixCenter = CGPointMake(sixRingPoint.x + sixRingSize.width / 2, sixRingPoint.y + sixRingSize.height / 2)
        let sixBody = SKPhysicsBody(circleOfRadius: sixRingSize.width / 2, center: sixCenter)
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
        sevenRing.fillColor = Colors.darkRed
        sevenRing.strokeColor = Colors.darkRed
        sevenRing.name = "Seven"
        addChild(sevenRing)
        
        let sevenCenter = CGPointMake(sevenRingPoint.x + sevenRingSize.width / 2, sevenRingPoint.y + sevenRingSize.height / 2)
        let sevenBody = SKPhysicsBody(circleOfRadius: sevenRingSize.width / 2, center: sevenCenter)
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
        eightRing.name = "Eight"
        addChild(eightRing)
        
        let eightCenter = CGPointMake(eightRingPoint.x + eightRingSize.width / 2, eightRingPoint.y + eightRingSize.height / 2)
        let eightBody = SKPhysicsBody(circleOfRadius: eightRingSize.width / 2, center: eightCenter)
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
        nineRing.fillColor = Colors.darkYellow
        nineRing.strokeColor = Colors.darkYellow
        nineRing.name = "Nine"
        addChild(nineRing)
        
        let nineCenter = CGPointMake(nineRingPoint.x + nineRingSize.width / 2, nineRingPoint.y + nineRingSize.height / 2)
        let nineBody = SKPhysicsBody(circleOfRadius: nineRingSize.width / 2, center: nineCenter)
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
        tenRing.name = "Ten"
        addChild(tenRing)
        
        let tenCenter = CGPointMake(tenRingPoint.x + tenRingSize.width / 2, tenRingPoint.y + tenRingSize.height / 2)
        let tenBody = SKPhysicsBody(circleOfRadius: tenRingSize.width / 2, center: tenCenter)
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
        xRing.name = "X"
        addChild(xRing)
        
        let xCenter = CGPointMake(xRingPoint.x + xRingSize.width / 2, xRingPoint.y + xRingSize.height / 2)
        let xBody = SKPhysicsBody(circleOfRadius: xRingSize.width / 2, center: xCenter)
        xBody.affectedByGravity = false
        xBody.categoryBitMask = PhysicsType.xRing
        xBody.collisionBitMask = PhysicsType.none
        xBody.contactTestBitMask = PhysicsType.arrow
        xBody.usesPreciseCollisionDetection = true
        xRing.physicsBody = xBody
        
        let xLabel = SKLabelNode(text: "x")
        xLabel.fontColor = UIColor.darkGrayColor()
        xLabel.verticalAlignmentMode = .Center
        xLabel.horizontalAlignmentMode = .Center
        xLabel.fontSize = UIFont.systemFontSize() * 1.5
        xLabel.position = CGPointMake(xRingPoint.x + xRingSize.width / 2, xRingPoint.y + xRingSize.height / 2)
        xRing.addChild(xLabel)
    }
    
    func createArrowWithIndex(index: Int) {
        
        let arrowSize = CGSizeMake(5, 150)
        let arrowPoint = CGPointMake((size.width - arrowSize.width) / 2, size.height / 4 )
        arrowRect = CGRectMake(arrowPoint.x, arrowPoint.y, arrowSize.width, arrowSize.height)
        let arrowPath = CGPathCreateWithRect(arrowRect, nil)
        arrow = SKShapeNode(path: arrowPath)
        arrow.fillColor = UIColor.grayColor()
        arrow.strokeColor = UIColor.clearColor()
        arrow.alpha = 0.0
        arrow.name = "arrow\(index)"
        addChild(arrow)
        
        let center = CGPointMake(arrowPoint.x + arrowSize.width / 2, arrowPoint.y + arrowSize.height / 2)
        let arrowBody = SKPhysicsBody(rectangleOfSize: arrowSize, center: center)
        arrowBody.affectedByGravity = false
        arrowBody.categoryBitMask = PhysicsType.arrow
        arrowBody.contactTestBitMask = PhysicsType.target
        arrowBody.collisionBitMask = PhysicsType.none
//        arrowBody.usesPreciseCollisionDetection = true
        arrow.physicsBody = arrowBody
        
        let fletchSize = CGSizeMake(arrowSize.width * 2, arrowSize.height / 4)
        let fletchPoint1 = CGPointMake(arrowPoint.x + arrowSize.width, arrowPoint.y)
        let fletchRect1 = CGRectMake(fletchPoint1.x, fletchPoint1.y, fletchSize.width, fletchSize.height)
        let fletchPath1 = CGPathCreateWithRect(fletchRect1, nil)
        let fletch1 = SKShapeNode(path: fletchPath1)
        fletch1.fillColor = UIColor.greenColor()
        fletch1.strokeColor = UIColor.clearColor()
        arrow.addChild(fletch1)
        
        let fletchPoint2 = CGPointMake(arrowPoint.x - 2 * arrowSize.width, arrowPoint.y)
        let fletchRect2 = CGRectMake(fletchPoint2.x, fletchPoint2.y, fletchSize.width, fletchSize.height)
        let fletchPath2 = CGPathCreateWithRect(fletchRect2, nil)
        let fletch2 = SKShapeNode(path: fletchPath2)
        fletch2.fillColor = UIColor.greenColor()
        fletch2.strokeColor = UIColor.clearColor()
        arrow.addChild(fletch2)
        
        let arrowHeadSize = CGSizeMake(arrowSize.width, arrowSize.width)
        let arrowHeadPoint = CGPoint(x: arrowPoint.x, y: arrowPoint.y + arrowSize.height - arrowHeadSize.height / 2)
        let arrowHeadRect = CGRectMake(arrowHeadPoint.x, arrowHeadPoint.y, arrowHeadSize.width, arrowHeadSize.height)
        let arrowHeadPath = CGPathCreateWithEllipseInRect(arrowHeadRect, nil)
        arrowhead = SKShapeNode(path: arrowHeadPath)
        arrowhead.fillColor = UIColor.blackColor()
        arrowhead.strokeColor = UIColor.blackColor()
        arrowhead.name = "arrowhead\(index)"
        addChild(arrowhead)
        
        let arrowheadCenter = CGPointMake(arrowPoint.x + arrowHeadSize.width / 2, arrowPoint.y + arrowSize.height + arrowHeadSize.height / 2)
        let arrowheadBody = SKPhysicsBody(circleOfRadius: arrowSize.width / 2, center: arrowheadCenter)
        arrowheadBody.affectedByGravity = false
        arrowheadBody.categoryBitMask = PhysicsType.arrow
        arrowheadBody.contactTestBitMask = PhysicsType.target
        arrowheadBody.collisionBitMask = PhysicsType.none
        arrowhead.physicsBody = arrowheadBody
        
        let arrowJoint = SKPhysicsJointFixed.jointWithBodyA(arrow.physicsBody!, bodyB: arrowhead.physicsBody!, anchor: CGPoint.zero)
        physicsWorld.addJoint(arrowJoint)
        
        let fadeIn = SKAction.fadeInWithDuration(0.5)
        arrow.runAction(fadeIn)
    }
    
    func createScoreLabel(score: Int) {
        scoreLabel = SKLabelNode()
        scoreLabel.text = "\(score)"
        scoreLabel.fontSize = UIFont.systemFontSize() * 4
        scoreLabel.fontColor = UIColor.lightGrayColor()
        scoreLabel.position = CGPointMake(size.width / 2, size.height * (10/11))
        addChild(scoreLabel)
    }
    
    func joinArrowToTarget(physicsBodyA: SKPhysicsBody, physicsBodyB: SKPhysicsBody) {
        targetHit = SKPhysicsJointFixed.jointWithBodyA(physicsBodyA, bodyB: physicsBodyB, anchor: CGPointZero)
        physicsWorld.addJoint(targetHit)
    }
}


struct Colors {
    static let blue = UIColor(red: 105/255, green: 127/255, blue: 1, alpha: 1)
    static let red = UIColor(red: 1, green: 97/255, blue: 76/255, alpha: 1)
    static let yellow = UIColor(red: 1, green: 246/255, blue: 116/255, alpha: 1)
    static let darkBlue = UIColor(red: 80/255, green: 97/255, blue: 194/255, alpha: 1)
    static let darkRed = UIColor(red: 245/255, green: 46/255, blue: 11/255, alpha: 1)
    static let darkYellow = UIColor(red: 247/255, green: 206/255, blue: 66/255, alpha: 1)
}
