//
//  TicTacToeModel.swift
//  myTicTacToe
//
//  Created by SHUNPAN LO on 20/4/2016.
//  Copyright © 2016年 imukmuk. All rights reserved.
//

import Foundation

enum Mark: String {
    case Nought = "X"
    case Circle = "O"
    case Empty = "E"
}

struct Cell {
    let xCoordinate: Int
    let yCoordinate: Int
    var mark: Mark
}

class Board {
    let boardSize: Int
    var cells: [Cell]
    
    init(boardSize: Int) {
        self.boardSize = boardSize
        self.cells = []
        for row in 1...self.boardSize {
            for column in 1...self.boardSize {
                self.cells.append(Cell(xCoordinate: row, yCoordinate: column, mark: .Empty))
            }
        }
    }
    
    func isThreeInARow() -> Bool {
        // Check win condition for column
        let column = [0, 1, 2]
        for i in column {
            if (cells[i].mark != .Empty) && (cells[i].mark == cells[i+3].mark && cells[i].mark == cells[i+6].mark) {
                return true
            }
        }
        // Check win condition for row
        let row = [0, 3, 6]
        for i in row {
            if (cells[i].mark != .Empty) && (cells[i].mark == cells[i+1].mark && cells[i].mark == cells[i+2].mark) {
                return true
            }
        }
        // Check win condition for X
        if (cells[0].mark != .Empty) && (cells[0].mark == cells[4].mark && cells[0].mark == cells[8].mark) {
            return true
        }
        if (cells[2].mark != .Empty) && (cells[2].mark == cells[4].mark && cells[2].mark == cells[6].mark) {
            return true
        }
        // No win condition
        return false
    }
    
    func isThreeInARowNext(player: Player) -> Int {
        for i in 0...8 {
            if (cells[i].mark == .Empty) {
                cells[i].mark = player.side
                if isThreeInARow() {
                    cells[i].mark = .Empty
                    return i
                }
                cells[i].mark = .Empty
            }
        }
        return -1
    }
}

protocol Player {
    var side: Mark { get set }
}

class HumanPlayer: Player {
    var side: Mark
    
    init(side: Mark) {
        self.side = side
    }
}

class computerPlayer: Player {
    var side: Mark
    
    init(side: Mark) {
        self.side = side
    }
}
