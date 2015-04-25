//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Darling Vinavong on 4/13/15.
//  Copyright (c) 2015 Mattika Vinavong. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error:nil)
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //This function stops sound and resets audioEngine. 
    // This function is called in playAudioWithVariablePitch(), stopAudio(), playAudioWithVariableRate(). 
    func stopAudio(){
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
    }
    
    //This function plays sounds with variable rated.
    //This function is called in playSlowAudio() and playFastAudio().
    func playAudioWithVariableRate(speed:Float){
        stopAudio()
        audioPlayer.rate = speed
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
        audioEngine.connect(changePitchEffect, to:audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        //Play slow audio here....
        playAudioWithVariableRate(0.5)
    }
  
    @IBAction func playFastAudio(sender: AnyObject) {
        //Play fast audio here
        playAudioWithVariableRate(2.0)
    }
    
    @IBAction func playChipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1200)
    }

    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1200)
        
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        stopAudio()
        println("In stopAudio")
    }
    
}
