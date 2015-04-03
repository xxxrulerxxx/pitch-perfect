//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Neal Rollins on 3/13/15.
//  Copyright (c) 2015 Neal Rollins. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
  
    let slow:Float = 0.5
    let fast:Float = 2.0
    let chipmunk:Float = 1000.0
    let vader:Float = -1000.0
    
    override func viewDidLoad() {
       
               // Do any additional setup after loading the view.
        
        super.viewDidLoad()
        audioPlayer  = AVAudioPlayer( contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
 
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func playAudioAtRate(rate :Float){
        audioPlayer.stop()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        
    }
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    @IBAction func stopSounds(sender: UIButton) {
        
       audioPlayer.stop()
    }
    
    @IBAction func playDarthvaderAudio(sender: AnyObject) {
        playAudioWithVariablePitch(vader)
    }
    @IBAction func playChipmunkAudio(sender: UIButton) {
        
        
        playAudioWithVariablePitch(chipmunk)
    }
    @IBAction func playFast(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        playAudioAtRate(fast)
    }
    @IBAction func PlaySlow(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        playAudioAtRate(slow)
        
        
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
}
