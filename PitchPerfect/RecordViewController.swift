//
//  ViewController.swift
//  PitchPerfect
//
//  Created by AMJAD - on 11/01/1441 AH.
//  Copyright © 1441 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController , AVAudioRecorderDelegate {
    
    var audioRecorder : AVAudioRecorder!

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recordAudio(_ sender: Any) {
//        recordingLabel.text = "Recordinig is Progress"
//        stopRecordingButton.isEnabled = true
//        recordButton.isEnabled = false
         setRecordingState(true)
        

        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
//        recordButton.isEnabled = true
//        stopRecordingButton.isEnabled = false
//        recordingLabel.text = "Tap to Recording"
        setRecordingState(false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func setRecordingState(_ isRecording: Bool) {
        stopRecordingButton.isEnabled = isRecording // to disable the button
        recordButton.isEnabled = !isRecording // to enable the button
        recordingLabel.text = !isRecording ? "Tap to Record" : "Recording in Progress"
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
           print("recording was not successful")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let PlaySoundVC = segue.destination as! PlaySoundViewController
            let recordedAudioURL = sender as! URL
            PlaySoundVC.recordedAudioURL = recordedAudioURL
            
        }
    }

}

