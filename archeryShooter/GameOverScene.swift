//
//  GameOverScene.swift
//  archeryShooter
//
//  Created by Brett Berry on 9/26/16.
//  Copyright © 2016 Brett Berry. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {

    init(size: CGSize, score: Int, xCount: Int, gameViewController: GameViewController) {
        super.init(size: size)
        addGameOverLabels(score, xCount: xCount)
        
        let delay = SKAction.waitForDuration(2.0)
        let replay = SKAction.runBlock() {
            let gameView = self.view
            let gameScene = GameScene(size: size, gameDelegate: gameViewController)
            gameViewController.gameScene = gameScene
            gameScene.setupGameScene()
            gameScene.delegate = gameViewController
            gameView?.presentScene(gameScene)
        }
        let reload = SKAction.sequence([delay, replay])
        runAction(reload)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addGameOverLabels(score: Int, xCount: Int) {
        let gameOverLabel = SKLabelNode(text: "Game Over")
        gameOverLabel.position = CGPointMake(size.width / 2, size.height * 2/3)
        gameOverLabel.fontSize = UIFont.systemFontSize() * 4
        gameOverLabel.fontColor = UIColor.lightGrayColor()
        addChild(gameOverLabel)
        
        let totalScoreLabel = SKLabelNode()
        totalScoreLabel.text = "\(score) points"
        totalScoreLabel.position = CGPointMake(frame.width / 2, frame.height / 2)
        totalScoreLabel.fontSize = UIFont.systemFontSize() * 4
        totalScoreLabel.fontColor = UIColor.lightGrayColor()
        addChild(totalScoreLabel)
        
        let totalXCountLabel = SKLabelNode()
        totalXCountLabel.text = "\(xCount) x"
        totalXCountLabel.position = CGPointMake(frame.width / 2, frame.height / 2 - 75)
        totalXCountLabel.fontSize = UIFont.systemFontSize() * 3
        totalXCountLabel.fontColor = UIColor.lightGrayColor()
        addChild(totalXCountLabel)
    }
}