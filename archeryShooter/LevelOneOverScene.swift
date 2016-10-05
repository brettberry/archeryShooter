//
//  GameOverScene.swift
//  archeryShooter
//
//  Created by Brett Berry on 9/26/16.
//  Copyright © 2016 Brett Berry. All rights reserved.
//

import SpriteKit

class LevelOneOverScene: LevelOver {

    init(size: CGSize, score: Int, xCount: Int, gameViewController: GameViewController) {
        super.init(size: size, text: "Level 1 Over", score: score, xCount: xCount, duration: 0, gameViewController: gameViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}