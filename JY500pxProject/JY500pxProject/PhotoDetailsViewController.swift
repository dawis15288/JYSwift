//
//  PhotoDetailsViewController.swift
//  JY500pxProject
//
//  Created by atom on 16/5/1.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    var photoInfo: PhotoInfo? {
        
        didSet {
            
            highestLabel.text = NSString(format: "高度：  %.1f", photoInfo!.highest ?? 0) as String
            pulseLabel.text = NSString(format: "脉冲：  %.1f", photoInfo!.pulse ?? 0) as String
            viewsLabel.text = "views：  \(photoInfo!.views ?? 0)"
            cameraLabel.text = photoInfo!.camera
            focalLengthLabel.text = photoInfo!.focalLength
            shutterSpeedLabel.text = photoInfo!.shutterSpeed
            apertureLabel.text = photoInfo!.aperture
            isoLabel.text = photoInfo!.iso
            categoryLabel.text = photoInfo!.category?.description
            takenLabel.text = photoInfo!.taken
            uploadedLabel.text = photoInfo!.uploaded
            descriptionLabel.text = photoInfo!.desc
        
        }
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        
        tap.numberOfTapsRequired = 1
        
        tap.numberOfTouchesRequired = 1
        
        view.addGestureRecognizer(tap)
        
        self.view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        setupUIS()
    }
    
    func dismissVC() {
        
        dismissViewControllerAnimated(true) { 
            
        }
    
    }
    
    private func setupUIS() {
        
        self.view.addSubview(highestLabel)
        self.view.addSubview(pulseLabel)
        self.view.addSubview(viewsLabel)
        self.view.addSubview(cameraLabel)
        self.view.addSubview(focalLengthLabel)
        self.view.addSubview(shutterSpeedLabel)
        self.view.addSubview(apertureLabel)
        self.view.addSubview(isoLabel)
        self.view.addSubview(categoryLabel)
        self.view.addSubview(takenLabel)
        self.view.addSubview(uploadedLabel)
        self.view.addSubview(descriptionLabel)
        
        //let labelviews = [highestLabel, pulseLabel, viewsLabel, cameraLabel, focalLengthLabel, shutterSpeedLabel, apertureLabel, isoLabel, categoryLabel, takenLabel, uploadedLabel, descriptionLabel]
        
        let highestLabeloffset = CGPoint(x: 10, y: 64)
        
        let otherOffset = CGPoint(x: 0, y: 10)
        
       highestLabel.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: self.view, size: nil, offset: highestLabeloffset)
        
        pulseLabel.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: highestLabel, size: nil, offset: otherOffset)
        
        viewsLabel.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: pulseLabel, size: nil, offset: otherOffset)
        
        cameraLabel.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: viewsLabel, size: nil, offset: otherOffset)
        
        focalLengthLabel.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: cameraLabel, size: nil, offset: otherOffset)
        
        shutterSpeedLabel.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: focalLengthLabel, size: nil, offset: otherOffset)
        
        apertureLabel.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: shutterSpeedLabel, size: nil, offset: otherOffset)
        
        isoLabel.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: apertureLabel, size: nil, offset: otherOffset)
        
        categoryLabel.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: isoLabel, size: nil, offset: otherOffset)
        
        takenLabel.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: categoryLabel, size: nil, offset: otherOffset)
        
        uploadedLabel.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: takenLabel, size: nil, offset: otherOffset)
        
        descriptionLabel.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: uploadedLabel, size: nil, offset: otherOffset)
    
    }
    
    private lazy var highestLabel: UILabel = {
    
        let lab = UILabel()
        
        lab.textColor = UIColor.whiteColor()
        
        return lab
    
    }()
    private lazy var pulseLabel: UILabel = {
        
        let lab = UILabel()
        
        lab.textColor = UIColor.whiteColor()
        
        return lab
        
    }()
    private lazy var viewsLabel: UILabel = {
        
        let lab = UILabel()
        
        lab.textColor = UIColor.whiteColor()
        
        return lab
        
    }()
    private lazy var cameraLabel: UILabel = {
        
        let lab = UILabel()
        
        lab.textColor = UIColor.whiteColor()
        
        return lab
        
    }()
    private lazy var focalLengthLabel: UILabel = {
        
        let lab = UILabel()
        
        lab.textColor = UIColor.whiteColor()
        
        return lab
        
    }()
    private lazy var shutterSpeedLabel: UILabel = {
        
        let lab = UILabel()
        
        lab.textColor = UIColor.whiteColor()
        
        return lab
        
    }()
    private lazy var apertureLabel: UILabel = {
        
        let lab = UILabel()
        
        lab.textColor = UIColor.whiteColor()
        
        return lab
        
    }()
    private lazy var isoLabel: UILabel = {
        
        let lab = UILabel()
        
        lab.textColor = UIColor.whiteColor()
        
        return lab
        
    }()
    private lazy var categoryLabel: UILabel = {
        
        let lab = UILabel()
        
        lab.textColor = UIColor.whiteColor()
        
        return lab
        
    }()
    private lazy var takenLabel: UILabel = {
        
        let lab = UILabel()
        
        lab.textColor = UIColor.whiteColor()
        
        return lab
        
    }()
    private lazy var uploadedLabel: UILabel = {
        
        let lab = UILabel()
        
        lab.textColor = UIColor.whiteColor()
        
        return lab
        
    }()
    private lazy var descriptionLabel: UILabel = {
        
        let lab = UILabel()
        
        lab.textColor = UIColor.whiteColor()
        
        return lab
        
    }()

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
