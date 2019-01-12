//
//  Gomoku.swift
//  FinalProject_GO
//
//  Created by User18 on 2019/1/12.
//  Copyright © 2019 User03. All rights reserved.
//

import Foundation
import UIKit

class Gomoku {
    var gameEnd: Bool
    
    var backboard: BoardView
    
    init(board: BoardView) {
        self.gameEnd = true
        self.backboard = board
    }
    
    func check_win_diagonal(positionx: Int, positiony: Int) -> Bool {
        var count = 1
        
        var currx = positionx - 1
        var curry = positiony - 1
        while (currx >= 0 && curry >= 0 && backboard.chessArray[currx][curry] == backboard.blackOrWhite) {
            count += 1
            currx = currx - 1
            curry = curry - 1
        }
        if (count >= 5) {
            return true
        }
        currx = positionx + 1
        curry = positiony + 1
        while (currx < 19 && curry < 19 && backboard.chessArray[currx][curry] == backboard.blackOrWhite) {
            count += 1
            currx = currx + 1
            curry = curry + 1
        }
        if (count >= 5) {
            return true
        }
        
        currx = positionx + 1
        curry = positiony - 1
        count = 1
        while (currx < 19 && curry >= 0 && backboard.chessArray[currx][curry] == backboard.blackOrWhite) {
            count += 1
            currx = currx + 1
            curry = curry - 1
        }
        if (count >= 5) {
            return true
        }
        currx = positionx - 1
        curry = positiony + 1
        while (currx >= 0 && curry < 19 && backboard.chessArray[currx][curry] == backboard.blackOrWhite) {
            count += 1
            currx = currx - 1
            curry = curry + 1
        }
        if (count >= 5) {
            return true
        }
        return false
    }
    
    func check_win_horizontal(positionx: Int, positiony: Int) -> Bool {
        var count = 1
        
        var left = positionx-1
        while (left >= 0 && backboard.chessArray[left][positiony] == backboard.blackOrWhite) {
            count += 1
            if (count >= 5) {
                return true
            }
            left = left - 1
        }
        var right = positionx + 1
        while (right < 19 && backboard.chessArray[right][positiony] == backboard.blackOrWhite) {
            count += 1
            if (count >= 5) {
                return true
            }
            right = right + 1
        }
        return false
    }
    
    func check_win_vertical(positionx: Int, positiony: Int) -> Bool {
        var count = 1
        
        var lower = positiony-1
        while (lower >= 0) {
            if (backboard.chessArray[positionx][lower] == backboard.blackOrWhite) {
                count += 1
                if (count >= 5) {
                    return true
                }
                lower = lower - 1
            } else {
                break
            }
        }
        var higher = positiony + 1
        while (higher < 19) {
            if (backboard.chessArray[positionx][higher] == backboard.blackOrWhite) {
                count += 1
                if (count >= 5) {
                    return true
                }
                higher = higher + 1
            } else {
                break
            }
        }
        return false
    }
    
}
