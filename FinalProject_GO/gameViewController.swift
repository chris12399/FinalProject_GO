//
//  gameViewController.swift
//  FinalProject_GO
//
//  Created by User03 on 2019/1/6.
//  Copyright © 2019 User03. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width

class gameViewController: UIViewController {
    
    
    
    let gomoku = Gomoku.init(board: BoardView())
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gomoku.backboard.frame = CGRect(origin: CGPoint(x: 5, y: 190), size: CGSize(width: SCREEN_WIDTH - 10, height: SCREEN_WIDTH - 10))
        view.addSubview(self.gomoku.backboard)
        let returnButton = UIButton()
        returnButton.setTitle("undo", for: UIControl.State.normal)
        returnButton.setTitleColor(.black, for: .normal)
        returnButton.frame = CGRect(origin: CGPoint(x:SCREEN_WIDTH/2 + 20, y: 215
            + SCREEN_WIDTH) , size: CGSize(width: 150, height: 45))
        returnButton.layer.cornerRadius = 5
        returnButton.layer.borderWidth = 1
        returnButton.backgroundColor = UIColor(red: 240.0 / 255.0, green: 211.0 / 255.0, blue: 159.0 / 255.0, alpha: 1.0)
        returnButton.addTarget(self, action: #selector(undo), for: UIControl.Event.touchUpInside)
        /*let mainpageButton = UIButton()
        mainpageButton.setTitle("return", for: UIControl.State.normal)
        mainpageButton.setTitleColor(.black, for: .normal)
        mainpageButton.frame = CGRect(origin: CGPoint(x: 30, y: 175
            + SCREEN_WIDTH) , size: CGSize(width: 150, height: 45))
        mainpageButton.layer.cornerRadius = 5
        mainpageButton.layer.borderWidth = 1
        mainpageButton.backgroundColor = UIColor(red: 240.0 / 255.0, green: 211.0 / 255.0, blue: 159.0 / 255.0, alpha: 1.0)
        mainpageButton.addTarget(self, action: #selector(mainpage), for: UIControl.Event.touchUpInside)*/
        view.addSubview(returnButton)
        //view.addSubview(mainpageButton)
        
        self.gomoku.backboard.textfield.frame = CGRect(origin: CGPoint(x:55, y:95), size: CGSize(width: 300, height: 45))
        self.gomoku.backboard.textfield.layer.cornerRadius = 5
        self.gomoku.backboard.textfield.layer.borderWidth = 2
        self.gomoku.backboard.textfield.backgroundColor = UIColor(red: 240.0 / 255.0, green: 211.0 / 255.0, blue: 159.0 / 255.0, alpha: 1.0)
        self.gomoku.backboard.textfield.textColor = UIColor.black
        self.gomoku.backboard.textfield.font = UIFont (name: "Helvetica Neue", size: 30)
        self.gomoku.backboard.textfield.textAlignment = NSTextAlignment.center
        self.gomoku.backboard.textfield.placeholder = "Black Turn"
        view.addSubview(self.gomoku.backboard.textfield)
        
        
    }
    
    @objc func undo() {
        gomoku.backboard.undo()
    }
    
    @objc func mainpage(){
        
        performSegue(withIdentifier: "backtoMain", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
