//
//  BoardView.swift
//  FinalProject_GO
//
//  Created by User03 on 2019/1/6.
//  Copyright © 2019 User03. All rights reserved.
//

import UIKit
//import AVFoundation
class BoardView: UIView {
    //var name = ""
    //var audioPlayer = AVAudioPlayer()
    let chessPieceNumber = 19
    var blackOrWhite = 1
    var chessArray = Array(repeating: Array(repeating: 0, count: 19), count: 19)
    var allChessView = Array<UIView>()
    var allChessPosition = Array<(Int,Int)>()
    var textfield = UITextField()
    
    func start(){
        self.blackOrWhite = 1
        var i = 0
        var j = 0
        while(i < 19){
            while(j < 19){
                self.chessArray[i][j] = 0
                j+=1
            }
            i+=1
        }
    }
    
    func check_Win(Position_X: Int, Position_Y: Int) -> Bool{ //black = 1, while = 2
        if (check_Win_horizontal(Position_X: Position_X, Position_Y: Position_Y)){
            return true
        }
        if (check_Win_vertical(Position_X: Position_X, Position_Y: Position_Y)){
            return true
        }
        if (check_Win_diagonal(Position_X: Position_X, Position_Y: Position_Y)){
            return true
        }
        return false
    }
    
    func check_Win_horizontal(Position_X: Int, Position_Y: Int) -> Bool{
        var count = 1
        
        var left = Position_X - 1
        while(left >= 0 && chessArray[left][Position_Y] == blackOrWhite){
            count += 1
            if(count >= 5){
                return true
            }
            left = left - 1
        }
        var right = Position_X + 1
        while(right < 19 && chessArray[right][Position_Y] == blackOrWhite){
            count += 1
            if(count >= 5){
                return true
            }
            right = right + 1
        }
        return false
    }
    
    ///////
    func check_Win_vertical(Position_X: Int, Position_Y: Int) -> Bool{
        var count = 1
        
        var lower = Position_Y - 1
        while(lower >= 0){
            if (chessArray[Position_X][lower] == blackOrWhite){
                count += 1
                if(count >= 5){
                    return true
                }
                lower = lower - 1
            } else{
                break
            }
        }
        var higher = Position_Y + 1
        while(higher < 19){
            if (chessArray[Position_X][higher] == blackOrWhite){
                count += 1
                if(count >= 5){
                    return true
                }
                higher = higher + 1
            }else{
                break
            }
        }
        return false
    }
    
    func check_Win_diagonal(Position_X: Int, Position_Y: Int) -> Bool{
        var count = 1
        
        var curr_X = Position_X - 1
        var curr_Y = Position_Y - 1
        while(curr_X >= 0 && curr_Y >= 0 && chessArray[curr_X][curr_Y] == blackOrWhite){
            count += 1
            curr_X = curr_X - 1
            curr_Y = curr_Y - 1
        }
        if(count >= 5){
            return true
        }
        curr_X = Position_X + 1
        curr_Y = Position_Y + 1
        while(curr_X < 19 && curr_Y < 19 && chessArray[curr_X][curr_Y] == blackOrWhite){
            count += 1
            curr_X = curr_X + 1
            curr_Y = curr_Y + 1
        }
        if(count >= 5){
            return true
        }
        
        curr_X = Position_X + 1
        curr_Y = Position_Y - 1
        count = 1
        while(curr_X < 19 && curr_Y >= 0 && chessArray[curr_X][curr_Y] == blackOrWhite){
            count += 1
            curr_X = curr_X + 1
            curr_Y = curr_Y - 1
        }
        if(count >= 5){
            return true
        }
        curr_X = Position_X - 1
        curr_Y = Position_Y + 1
        while(curr_X >= 0 && curr_Y < 19 && chessArray[curr_X][curr_Y] == blackOrWhite){
            count += 1
            curr_X = curr_X - 1
            curr_Y = curr_Y + 1
        }
        if(count >= 5){
            return true
        }
        return false
    }
    
    func update_turn(){
        if(blackOrWhite == 1){
            textfield.placeholder = "White Turn"
        }else{
            textfield.placeholder = "Black Turn"
        }
    }
    
    func undo(){
        allChessView.popLast()?.isHidden = true
        update_turn()
        var lastAction: (Int, Int)
        lastAction = (allChessPosition.popLast())!
        blackOrWhite = chessArray[lastAction.0][lastAction.1]
        chessArray[lastAction.0][lastAction.1] = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor(red: 240.0/255.0, green: 211.0/255.0, blue: 159.0/255.0, alpha: 1.0)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        let boardsize = Double(frame.size.width - 20)
        let interval = boardsize / Double(chessPieceNumber - 1)
        context?.setLineWidth(1.0)
        
        for i in 0..<chessPieceNumber{
            context?.move(to: CGPoint(x: 10, y: 10 + interval * Double(i)))
            context?.addLine(to: CGPoint(x: 10 + boardsize, y: 10 + interval * Double(i)))
            context?.strokePath()
        }
        
        for i in 0..<chessPieceNumber{
            context?.move(to: CGPoint(x: 10 + interval * Double(i), y: 10))
            context?.addLine(to: CGPoint(x: 10 + interval * Double(i), y: 10 + boardsize))
            context?.strokePath()
        }
        
        for i in 0...2 {
            for j in 0...2 {
                context?.beginPath()
                context?.addArc(center: CGPoint(x:Double(3+6*i)*interval+0.5 * interval-0.5,y:Double(3+6*j)*interval+0.5 * interval-0.5), radius: 3, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
                context?.strokePath()
            }
        }
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapBoard)))
    }
    
        
    func restart() {
        chessArray = Array(repeating: Array(repeating: 0, count: 19), count: 19)
        for each in subviews{
            each.isHidden = true
        }
    }
        
    @objc func tapBoard(tap: UITapGestureRecognizer){
        let boardsize = Double(frame.size.width - 20)
        let interval = boardsize / Double(19 - 1)
        //black = 1, white = 2
        let point = tap.location(in: tap.view)
        var y = Int(floor((Double(lroundf(Float(Double(point.x - 10)/interval))) * interval+2 - 2) / ((386 - 2) / 19)))
        var x = Int(floor((Double(lroundf(Float(Double(point.y - 10)/interval))) * interval+2 - 2) / ((386 - 2) / 19)))
        if x == 19 {
            x = 18
        }
        if y == 19 {
            y = 18
        }
        if chessArray[x][y] == 0 {
            let chessView = UIView()
            
            let chesspoint = CGPoint(x: Double(lroundf(Float(Double(point.x - 10)/interval))) * interval+2, y: Double(lroundf(Float(Double(point.y - 10)/interval))) * interval + 2)
            
            chessView.frame = CGRect(origin: chesspoint,
                                     size: CGSize(width: Double(15), height: Double(15)))
            chessView.layer.cornerRadius = 7.5
            chessArray[x][y] = blackOrWhite
            allChessView.append(chessView)
            allChessPosition.append((x, y))
            addSubview(chessView)
            update_turn()
            
            if(check_Win(Position_X: x, Position_Y: y)) {
                restart()
                if(blackOrWhite == 1){
                    let alert = UIAlertView(title: "Black Win", message: "Black has won", delegate: self, cancelButtonTitle: "Restart")
                    alert.show()
                    //audioPlayer.pause()
                }else{
                    let alert = UIAlertView(title: "White Win", message: "White has won", delegate: self, cancelButtonTitle: "Restart")
                    alert.show()
                    
                    
                }
                // restart and set blackorwhite to 1
                blackOrWhite = 1
                
            }else {
                if blackOrWhite == 1{
                    chessView.backgroundColor = UIColor.black
                    blackOrWhite = 2
                }else{
                    chessView.backgroundColor = UIColor.white
                    blackOrWhite = 1
                }
            }
            
        }else{
                let alert = UIAlertView(title: "Error", message: "Position aleady been taken", delegate: self, cancelButtonTitle: "OK")
        }
        /*func playMP3(){
            do{
                
                let audioPath = Bundle.main.path(forResource: name, ofType: "mp3")
                try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
                audioPlayer.prepareToPlay()
            }
            catch{
                print(error)
            }
        }*/
    }
    
    
}
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
