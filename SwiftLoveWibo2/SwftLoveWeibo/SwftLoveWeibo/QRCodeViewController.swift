//
//  QRCodeViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/14.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import AVFoundation

class QRCodeViewController: UIViewController {
    @IBOutlet weak var tabBar: UITabBar!

    @IBOutlet weak var scanLineView: UIImageView!
    
    @IBOutlet weak var containHeightCons: NSLayoutConstraint!
    @IBOutlet weak var scanLinCons: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tabBar.selectedItem = tabBar.items![0]
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        startAnmiation()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        startAnmiation()
        
        startScan()
    }
    
    func startAnmiation() {
    
        self.scanLinCons.constant = -self.containHeightCons.constant
        
        view.layoutIfNeeded()
        
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            
            UIView.setAnimationRepeatCount(MAXFLOAT)
            
            self.scanLinCons.constant = self.containHeightCons.constant
            
            self.view.layoutIfNeeded()
            
        })
    }
    
    @IBAction func closeButton(sender: AnyObject) {
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
        NSNotificationCenter.defaultCenter().postNotificationName(JYRootViewControllerSwitchNotification, object: true)
        
    }
    
    private lazy var session: AVCaptureSession = AVCaptureSession()
    
    private lazy var deviceInput: AVCaptureDeviceInput? = {
        
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
        
        do {
        
            let input = try AVCaptureDeviceInput(device: device)
            
            return input
            
        } catch {
        
            print(error)
            
            return nil
        }
    
    }()
    
    private lazy var outPut: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
    
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        
        layer.frame = UIScreen.mainScreen().bounds
        
        return layer
    
    }()
    
    private func startScan() {
        
        if !session.canAddInput(deviceInput) {
            
            print("!session.canAddInput(deviceInput)")
        
            return
        }
        
        if !session.canAddOutput(outPut) {
            
            return
        }
        
        session.addInput(deviceInput)
        
        session.addOutput(outPut)
        
        outPut.metadataObjectTypes = outPut.availableMetadataObjectTypes
            
        outPut.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        scanLineView.layer.insertSublayer(previewLayer, atIndex: 0)
        
        session.startRunning()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
    
        print(metadataObjects)
    
    }


}


