//
//  GameScene.swift
//  archeryShooter
//
//  Created by Brett Berry on 9/17/16.
//  Copyright (c) 2016 Brett Berry. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var score: Int = 0
    var xCount: Int = 0
    var scoreLabel = SKLabelNode()
    var xCountLabel = SKLabelNode()
    
    var fiveRing: SKShapeNode!
    var sixRing: SKShapeNode!
    var sevenRing: SKShapeNode!
    var eightRing: SKShapeNode!
    var nineRing: SKShapeNode!
    var tenRing: SKShapeNode!
    var xRing: SKShapeNode!
    var xLabel: SKLabelNode!

    var arrow: SKShapeNode!
    var arrowhead: SKShapeNode!
    var targetHit: SKPhysicsJointFixed!
    
    var gameScene: SKScene!
    var gameDelegate: GameDelegate!
    var targetSize: CGSize!

    init(size: CGSize, gameDelegate: GameDelegate) {
        super.init(size: size)
        self.gameDelegate = gameDelegate
        self.targetSize = CGSizeMake(size.width / 3 + 50, size.width / 3 + 50)
   }
    
    func setupGameScene() {
        
        if gameScene == nil {
            gameScene = SKScene(size: frame.size)
        }
        
        let transition = SKTransition.fadeWithColor(UIColor.darkGrayColor(), duration: 1.0)
        view?.presentScene(gameScene, transition: transition)
        
        createRings()
        addTargetNodes()
        createScoreLabel(score, withXCount: xCount)

        gameDelegate.gameShouldStart()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createRings() {
        fiveRing = configureRingNode("Five", color: Colors.darkBlue, offset: 0, category: PhysicsType.fiveRing, dynamic: false)
        sixRing = configureRingNode("Six", color: Colors.blue, offset: 25, category: PhysicsType.sixRing, dynamic: true)
        sevenRing = configureRingNode("Seven", color: Colors.darkRed, offset: 50, category: PhysicsType.sevenRing, dynamic: true)
        eightRing = configureRingNode("Eight", color: Colors.red, offset: 75, category: PhysicsType.eightRing, dynamic: true)
        nineRing = configureRingNode("Nine", color: Colors.darkYellow, offset: 100, category: PhysicsType.nineRing, dynamic: true)
        tenRing = configureRingNode("Ten", color: Colors.yellow, offset: 125, category: PhysicsType.tenRing, dynamic: true)
        xRing = configureRingNode("X", color: Colors.yellow, offset: 140, category: PhysicsType.xRing, dynamic: true)

        xLabel = SKLabelNode(text: "x")
        xLabel.fontColor = UIColor.darkGrayColor()
        xLabel.verticalAlignmentMode = .Center
        xLabel.horizontalAlignmentMode = .Center
        xLabel.fontSize = UIFont.systemFontSize() * 1.5
//      xLabel.position = CGPointMake(xRingPoint.x + xRingSize.width / 2, xRingPoint.y + xRingSize.height / 2)
//      xRing.addChild(xLabel)
    }
    
    func configureRingNode(name: String, color: UIColor, offset: CGFloat, category: UInt32, dynamic: Bool) -> SKShapeNode {
        let yOffset = size.height / 6
        let nodeSize = CGSizeMake(targetSize.width - offset, targetSize.height - offset)
        let point = CGPointMake((size.width - nodeSize.width) / 2, (size.height - nodeSize.height) / 2 + yOffset)
        let rect = CGRectMake(point.x, point.y, nodeSize.width, nodeSize.height)
        let path = CGPathCreateWithEllipseInRect(rect, nil)
        let node = SKShapeNode(path: path)
        node.fillColor = color
        node.strokeColor = color
        node.name = name
        
        let center = CGPointMake(point.x + nodeSize.width / 2 , point.y + nodeSize.height / 2)
        let physicsBody = SKPhysicsBody(circleOfRadius: nodeSize.width / 2, center: center)
        physicsBody.affectedByGravity = false
        physicsBody.categoryBitMask = category
        physicsBody.collisionBitMask = PhysicsType.none
        physicsBody.contactTestBitMask = PhysicsType.arrow
        physicsBody.dynamic = dynamic
        node.physicsBody = physicsBody
        return node
    }
    
    private func addTargetNodes() {
        addChild(fiveRing)
        addChild(sixRing)
        addChild(sevenRing)
        addChild(eightRing)
        addChild(nineRing)
        addChild(tenRing)
        addChild(xRing)
    }
    
    func createArrowWithIndex(index: Int) {
        let arrowSize = CGSizeMake(5, 150)
        let arrowPoint = CGPointMake((size.width - arrowSize.width) / 2, size.height / 4 )
        let arrowRect = CGRectMake(arrowPoint.x, arrowPoint.y, arrowSize.width, arrowSize.height)
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
        
        let arrowheadSize = CGSizeMake(arrowSize.width, arrowSize.width)
        let arrowheadPoint = CGPoint(x: arrowPoint.x, y: arrowPoint.y + arrowSize.height)
        let arrowheadRect = CGRectMake(arrowheadPoint.x, arrowheadPoint.y, arrowheadSize.width, arrowheadSize.height)
        let arrowheadPath = CGPathCreateWithEllipseInRect(arrowheadRect, nil)
        arrowhead = SKShapeNode(path: arrowheadPath)
        arrowhead.fillColor = UIColor.blackColor()
        arrowhead.lineWidth = 0
        arrowhead.name = "arrowhead\(index)"
        addChild(arrowhead)
        
        let arrowheadCenter = CGPointMake(arrowPoint.x + arrowheadSize.width / 2, arrowPoint.y + arrowSize.height + arrowheadSize.height / 2)
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
    
    func createScoreLabel(score: Int, withXCount: Int) {
        scoreLabel.text = "\(score)"
        scoreLabel.fontSize = UIFont.systemFontSize() * 4
        scoreLabel.fontColor = UIColor.lightGrayColor()
        scoreLabel.position = CGPointMake(size.width / 2, size.height * (9/10))
        addChild(scoreLabel)
        
        xCountLabel.text = "\(xCount) x"
        xCountLabel.fontSize = UIFont.systemFontSize() * 2
        xCountLabel.position = CGPointMake(size.width / 2, scoreLabel.position.y - xCountLabel.fontSize - 10)
        xCountLabel.fontColor = UIColor.lightGrayColor()
        xCountLabel.alpha = 0.75
        addChild(xCountLabel)
    }
    
    func joinToTarget(physicsBodyA: SKPhysicsBody, physicsBodyB: SKPhysicsBody) {
        targetHit = SKPhysicsJointFixed.jointWithBodyA(physicsBodyA, bodyB: physicsBodyB, anchor: CGPointZero)
        physicsWorld.addJoint(targetHit)
    }

    func moveTargetWithDuration(duration: Double) {
        let moveRight = SKAction.moveToX(100, duration: duration)
        let moveLeft = SKAction.moveToX(-100, duration: duration)
        let moveSequence = SKAction.sequence([moveRight, moveLeft])
        let loopAction = SKAction.repeatActionForever(moveSequence)
        fiveRing.runAction(loopAction)
        sixRing.runAction(loopAction)
        sevenRing.runAction(loopAction)
        eightRing.runAction(loopAction)
        nineRing.runAction(loopAction)
        tenRing.runAction(loopAction)
        xRing.runAction(loopAction)
    }
    
    func moveTargetVerticalWithDuration(duration: Double) {
        let moveUp = SKAction.moveToY(100, duration: duration)
        let moveDown = SKAction.moveToY(-100, duration: duration)
        let sequence = SKAction.sequence([moveUp, moveDown])
        let loopAction = SKAction.repeatActionForever(sequence)
        fiveRing.runAction(loopAction)
        sixRing.runAction(loopAction)
        sevenRing.runAction(loopAction)
        eightRing.runAction(loopAction)
        nineRing.runAction(loopAction)
        tenRing.runAction(loopAction)
        xRing.runAction(loopAction)
    }
    
    func moveCrissCrossWithDuration(duration: Double) {
        let moveRight = SKAction.moveToX(100, duration: duration)
        let moveLeft = SKAction.moveToX(-100, duration: duration)
        let moveUp = SKAction.moveToY(100, duration: duration)
        let moveDown = SKAction.moveToY(-100, duration: duration)
        let moveCenterX = SKAction.moveToX(0, duration: duration / 2)
        let moveCenterY = SKAction.moveToY(0, duration: duration / 2)
        let sequence = SKAction.sequence([moveRight, moveLeft, moveCenterX, moveUp, moveDown, moveCenterY])
        let loopAction = SKAction.repeatActionForever(sequence)
        fiveRing.runAction(loopAction)
        sixRing.runAction(loopAction)
        sevenRing.runAction(loopAction)
        eightRing.runAction(loopAction)
        nineRing.runAction(loopAction)
        tenRing.runAction(loopAction)
        xRing.runAction(loopAction)
    }
}


