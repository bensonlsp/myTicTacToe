//
//  ViewController.swift
//  myTicTacToe
//
//  Created by SHUNPAN LO on 12/4/2016.
//  Copyright © 2016年 imukmuk. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController {

    var moveCount = 0
    var gameEnd = false
    let board = Board(boardSize: 3)
    let human = HumanPlayer(side: Mark.Circle)
    let computer = computerPlayer(side: Mark.Nought)
    
    @IBOutlet var xoButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        replay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func replayButton() {
        replay()
    }

    @IBAction func x1Button() {
        buttonHit(0)
    }
    
    @IBAction func x2Button() {
        buttonHit(1)
    }
    
    @IBAction func x3Button() {
        buttonHit(2)
    }
    
    @IBAction func x4Button() {
        buttonHit(3)
    }
    
    @IBAction func x5Button() {
        buttonHit(4)
    }
    
    @IBAction func x6Button() {
        buttonHit(5)
    }
    
    @IBAction func x7Button() {
        buttonHit(6)
    }
    
    @IBAction func x8Button() {
        buttonHit(7)
    }
    
    @IBAction func x9Button() {
        buttonHit(8)
    }
    
    func replay() {
        for button in xoButtons {
            button.setTitle(" ", forState: UIControlState.Normal)
        }
        moveCount = 0
        gameEnd = false
        for index in 0..<board.cells.count {
            board.cells[index].mark = .Empty
        }
    }
    
    func buttonHit(buttonRef: Int) {
        if board.cells[buttonRef].mark == Mark.Empty && gameEnd != true {
            makeAMove(human, move: buttonRef)
            if gameEnd != true {
                makeAMove(computer, move: getComputerMove())
            }
        }
    }
    
    func getComputerMove() -> Int {
        var resultIsThreeInARowNext = board.isThreeInARowNext(computer)
        if resultIsThreeInARowNext >= 0 {
            return resultIsThreeInARowNext
        }
        
        resultIsThreeInARowNext = board.isThreeInARowNext(human)
        if resultIsThreeInARowNext >= 0 {
            return resultIsThreeInARowNext
        }
        
        var randomNumber = GKRandomSource.sharedRandom().nextIntWithUpperBound(board.cells.count)
        
        while board.cells[randomNumber].mark != .Empty {
            randomNumber = GKRandomSource.sharedRandom().nextIntWithUpperBound(board.cells.count)
        }
        
        return randomNumber
    }
    
    func makeAMove(player: Player, move: Int) {
        xoButtons[move].setTitle(player.side.rawValue, forState: UIControlState.Normal)
        board.cells[move].mark = player.side
        if board.isThreeInARow() {
            showAlertBox("Game Over", withMessage: "\(player.side.rawValue) win!")
            gameEnd = true;
        }
        moveCount += 1
        if moveCount >= (board.boardSize * board.boardSize) {
            showAlertBox("Draw Game", withMessage: "Thank you for playing!")
            gameEnd = true
        }
    }
    
    func showAlertBox(withTitle: String, withMessage: String? = nil, style: UIAlertControllerStyle = .Alert) {
        let alert = UIAlertController(title: withTitle, message: withMessage, preferredStyle: style)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .Default, handler: dismissAlert)
        alert.addAction(dismissAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func dismissAlert(sender: UIAlertAction) {
        replay()
    }
}
