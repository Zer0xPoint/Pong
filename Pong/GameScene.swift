//
//  GameScene.swift
//  Pong
//
//  Created by Zer0xPoint on 2016/11/12.
//  Copyright © 2016年 Zer0xPoint. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var topLbl = SKLabelNode()
    var btmLbl = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        startGame()
        
        topLbl = self.childNode(withName: "topLbl") as! SKLabelNode
        btmLbl = self.childNode(withName: "btmLbl") as! SKLabelNode
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx:30,dy:30))
        
        let border = SKPhysicsBody(edgeLoopFrom:self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
    }
    
    func startGame() {
        
        score = [0,0]
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
    }
    
    func addScore(playerWhoWon : SKSpriteNode) {
        
        ball.position = CGPoint(x: 0,y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0,dy: 0)
        
        
        if playerWhoWon == main {
            
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx:30,dy:30))
        }
        else if playerWhoWon == enemy {
            
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx:-30,dy:-30))
        }
        
        print(score)
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.1))
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.1))
            
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.2))
        
        if ball.position.y <= main.position.y - 70 {
            
            addScore(playerWhoWon: enemy)
            
        }
        else if ball.position.y >= enemy.position.y + 70 {
            
            addScore(playerWhoWon: main)
            
        }
    }
}
