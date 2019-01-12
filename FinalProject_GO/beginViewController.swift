//
//  beginViewController.swift
//  FinalProject_GO
//
//  Created by User03 on 2019/1/6.
//  Copyright © 2019 User03. All rights reserved.
//

import UIKit
import AVFoundation
class beginViewController: UIViewController {

    var name = ""
    var audioPlayer = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //audioPlayer.play()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func startGame(_ sender: UIButton) {
        playMP3()
        audioPlayer.play()
    }
    
    func playMP3(){
        do{
            
            let audioPath = Bundle.main.path(forResource: name, ofType: "mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.prepareToPlay()
        }
        catch{
            print(error)
        }
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
