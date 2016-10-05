//
//  LevelTwoOverScene.swift
//  archeryShooter
//
//  Created by Brett Berry on 9/29/16.
//  Copyright © 2016 Brett Berry. All rights reserved.
//

import SpriteKit

class LevelTwoOverScene: LevelOver {
    
    init(size: CGSize, score: Int, xCount: Int, gameViewController: GameViewController) {
        super.init(size: size, text: "Level 2 Over", score: score,  xCount: xCount,  duration: 2.5, gameViewController: gameViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}