//
//  ViewController.swift
//  Scribe
//
//  Created by Руслан Акберов on 19.11.2017.
//  Copyright © 2017 Ruslan Akberov. All rights reserved.
//

import UIKit
import Speech
import AVKit

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var transcriptionTextField: UITextView!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.isHidden = true
        transcriptionTextField.isEditable = false
    }
    
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { authstatus in
            if authstatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                    } catch {
                        print("Error")
                    }
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let error = error {
                            print("There is an error \(error)")
                        } else {
                            self.transcriptionTextField.text = result?.bestTranscription.formattedString
                        }
                    }
                }
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }

    @IBAction func playButtonPressed(_ sender: UIButton) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuth()
    }
    

}
