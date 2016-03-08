//
//  QRCodeViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/5.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import AVFoundation

class QRCodeViewController: UIViewController {
    @IBOutlet weak var customTabBar: UITabBar!
    @IBOutlet weak var contrainerheight: NSLayoutConstraint!

    @IBOutlet weak var contrainerWidth: NSLayoutConstraint!
    @IBOutlet weak var scanlineCons: NSLayoutConstraint!
    
    @IBOutlet weak var scanlineConsView: UIImageView!
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        startAnimation()
        
        startScan()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        customTabBar.selectedItem = customTabBar.items![0]
        
        customTabBar.delegate = self
    }
    @IBAction func cloaseItemClick(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
     func startAnimation() {
        
        scanlineCons.constant = -contrainerheight.constant
        
        view.layoutIfNeeded()
        
        UIView.animateWithDuration(2.0, animations: { [unowned self] () -> Void in
            
            
            UIView.setAnimationRepeatCount(MAXFLOAT)
            
            self.scanlineCons.constant = self.contrainerheight.constant
            
            self.view.layoutIfNeeded()
        
        })
    
    }
    
    private lazy var session: AVCaptureSession  = AVCaptureSession()
    
    private lazy var inputDevice: AVCaptureInput? = {
        
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        do {
            
            return try AVCaptureDeviceInput(device: device)
        
        } catch _ {
        
            return nil
        }
    
    }()
    
    private lazy var output: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        
        layer.frame = self.view.frame
        
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        return layer
    
    }()
    
    private func startScan() {
        
        print(session)
        
        if !session.canAddInput(inputDevice) {
            
            print("!session.canAddInput(inputDevice)这里需要真机调试")
            
            return
        
        }
        
        if !session.canAddOutput(output) {
            
            print("!session.canAddOutput(output)")
            
            return
        
        }
        
        session.addInput(inputDevice)
        
        print("添加前:\(output.metadataObjectTypes)")
        
        session.addOutput(output)
        
        print("添加前:\(output.metadataObjectTypes)")
        
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        output.setMetadataObjectsDelegate(self, queue:dispatch_get_main_queue())
        
        view.layer.addSublayer(previewLayer)
        
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

extension QRCodeViewController: UITabBarDelegate {
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        print(item.tag)
        
        contrainerheight.constant = item.tag == 1 ? 300 * 0.5 : 300
        
        self.scanlineConsView.layer.removeAllAnimations()
        
        startAnimation()
    }

}

extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        print(metadataObjects.last)
    }

}
