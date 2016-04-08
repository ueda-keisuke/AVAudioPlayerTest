//
//  ViewController.swift
//  AVPlayerTest
//
//  Created by Neuro Leap on 2016/04/05.
//  Copyright © 2016年 Neuro Leap. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    let filename = "audio.m4a"
    var recording = false
    
    @IBOutlet weak var record_button: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func playAudioInBundle(sender: UIButton)
    {
        if let url = NSBundle.mainBundle().URLForResource("1", withExtension: "m4a")
        {
            play(url)
        }
    }
    
    @IBAction func playAudioInDocumentDirectory(sender: UIButton)
    {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let filePath = documentDirectory + "/" + filename
        let url = NSURL(fileURLWithPath: filePath)
        
        play(url)
    }
    
    @IBAction func record(sender: UIButton)
    {
        if recording == false
        {
            setupAudioRecorder()
            audioRecorder?.record()

            record_button.setTitle("Stop recording", forState: .Normal)

            recording = true
        }
        else
        {
            audioRecorder?.stop()
            
            // added
            let session = AVAudioSession.sharedInstance()
            try! session.setActive(false)
            
            record_button.setTitle("Record", forState: .Normal)
            recording = false
        }
    }
    
    
    
    
    
    func setupAudioRecorder() {
        
        let audio_directory_path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let file_path = "\(audio_directory_path)" + "/" + filename
        let url = NSURL(fileURLWithPath: file_path)
        
        let recordSettings: [String: AnyObject] =
            [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVEncoderAudioQualityKey: AVAudioQuality.Low.rawValue,
                AVEncoderBitRateKey: 16000,
                AVNumberOfChannelsKey: 1,
                AVSampleRateKey: 8000.0,
                AVLinearPCMBitDepthKey: 8
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(URL: url, settings: recordSettings)
            
            // added
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryRecord)
            try session.setActive(true)
            
        } catch {
            audioRecorder = nil
        }
        
    }
    
    
    
    func play(url: NSURL)
    {
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: url)
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSessionCategoryAmbient)
            
            audioPlayer?.play()
        }
        catch
        {
            print("Error loading \(url): \(error)")
        }
    }
    
    

}

