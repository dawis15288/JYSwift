//
//  RecordWhistleViewController.swift
//  Project33
//
//  Created by atom on 15/11/25.
//  Copyright © 2015年 atom. All rights reserved.
//

import UIKit

import AVFoundation

class RecordWhistleViewController: UIViewController, AVAudioRecorderDelegate {
    
    var stackView: UIStackView!
    
    var recordButton: UIButton!
    
    var recordingSession: AVAudioSession!
    
    var whistleRecorder: AVAudioRecorder!
    
    override func loadView() {
        
        super.loadView()
        
        stackView = UIStackView()
        
        stackView.spacing = 30
        
        stackView.backgroundColor = UIColor.clearColor()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.distribution = UIStackViewDistribution.FillEqually
        
        stackView.alignment = UIStackViewAlignment.Center
        
        stackView.axis = .Vertical
        
        view.addSubview(stackView)
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[stackView]|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["stackView": stackView]))
        
        view.addConstraint(NSLayoutConstraint(item: stackView, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0))
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "Record your whistle"
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "record", style: .Plain, target: nil, action: nil)
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            
            try recordingSession.setActive(true)
            
            recordingSession.requestRecordPermission(){ [unowned self] (allowed: Bool) -> Void in
                
                dispatch_async(dispatch_get_main_queue()){
                    
                    if allowed {
                        
                            self.loadRecordingUI()
                    
                    } else {
                        
                        self.loadFailUI()
                    
                    }
                
                }
            
            
            }
        
        
        } catch {
            
            self.loadFailUI()
        
        }
        
    }
    
    func loadRecordingUI() {
        
        recordButton = UIButton()
        
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        
        recordButton.setTitle("Tap to record", forState: .Normal)
        
        recordButton.titleLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle1)
        
        recordButton.addTarget(self, action: "recordTapped", forControlEvents: .TouchUpInside)
        
        stackView.addArrangedSubview(recordButton)
    
    }
    
    func recordTapped() {
        
        if whistleRecorder == nil {
            
            startRecording()
        
        } else {
            
            finishRecording(success: true)
        
        }
    
    }
    
    func loadFailUI() {
        
        let failLabel = UILabel()
        
        failLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        
        failLabel.text = "Recording failed: please ensure the app has access to your microphone."
        
        failLabel.numberOfLines = 0
        
        stackView.addArrangedSubview(failLabel)
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func getDocumentsDirectory() -> NSString {
        
        //这里获取路径错了
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        let documentsDirectory = paths[0]
        
        return documentsDirectory
        
        
    }
    
    class func getWhistleURL() -> NSURL {
        
        let audioFilename = getDocumentsDirectory().stringByAppendingPathComponent("whistle.m4a")
        
        let audioURL = NSURL(fileURLWithPath: audioFilename)
        
        return audioURL
    
    }
    
    func startRecording() {
        
        view.backgroundColor = UIColor(red: 0.6, green: 0, blue: 0, alpha: 1)
        
        recordButton.setTitle("Tap to Stop", forState: .Normal)
        
        let audioURL = RecordWhistleViewController.getWhistleURL()
        
        print("---> \(audioURL.absoluteString) <---")
        
        let settings = [
            
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            
            AVSampleRateKey: 12000.0,
            
            AVNumberOfChannelsKey: 1 as NSNumber,
            
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
        
        ]
        
        do {
            
            whistleRecorder = try AVAudioRecorder(URL: audioURL, settings: settings)
            
            whistleRecorder.delegate = self
            
            whistleRecorder.record()
            
        
        } catch {
        
            finishRecording(success: false)
        
        }
    
    }
    
    func finishRecording(success success: Bool) {
        
        view.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
        
        whistleRecorder.stop()
        
        whistleRecorder = nil
        
        if success {
            
            recordButton.setTitle("Tap to Re-record", forState: .Normal)
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "next", style: .Plain, target: self, action: "nextTapped")
            
            
        
        } else {
            
            recordButton.setTitle("Tap to Record", forState: .Normal)
            
            let ac = UIAlertController(title: "Record  fail", message: "There was a problem recording your whistle; please try again.", preferredStyle: .Alert)
            
            ac.addAction(UIAlertAction(title: "ok", style: .Default, handler: nil))
            
            presentViewController(ac, animated: true, completion: nil)
        
        }
        
        
    
    }
    
    func audioRecorderBeginInterruption(recorder: AVAudioRecorder) {
        
        print("recording is started!")
        
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if !flag {
            
            finishRecording(success: false)
        
        }
        
        
    }
    
    func nextTapped() {
        
        let sc = SubmitViewController()
        
        navigationController?.pushViewController(sc, animated: true)
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
