//
//  PhotoBrowserViewController.swift
//  JY500pxProject
//
//  Created by atom on 16/5/1.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import Alamofire

import QuartzCore

class PhotoBrowserViewController: UIViewController {
    
    var photoID: Int = 0
    
    var photoInfo: PhotoInfo?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUIS()
        
        loadPhoto()
        
    }
    
    private func loadPhoto() {
        
        Alamofire.request(Five500px.Router.PhotoInfo(self.photoID, Five500px.ImageSize.Large)).validate().responseObject { (response: Response<PhotoInfo, NSError>) in
            
            guard response.result.error == nil else { return }
            
            let photoInfo = response.result.value
            
            self.photoInfo = photoInfo
            
            dispatch_async(dispatch_get_main_queue(), { 
                
                self.addButtonBar()
                
                self.title = photoInfo?.url
                
            })
            
            Alamofire.request(.GET, photoInfo!.url).validate().responseImage({ (response) in
                
                guard let image = response.result.value else { return }
                
                self.photoImageview.image = image
                
                self.spinner.stopAnimating()
                
                self.centerscrollViewContents()
            })
            
            
        }
    
    
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if self.photoInfo != nil {
            
            navigationController?.setToolbarHidden(false, animated: true)
        
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setToolbarHidden(true, animated: true)
    }
    
    func addButtonBar() {
    
        var items = [UIBarButtonItem]()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        
        let barButtonItem = barButtonItemWithImageNamed("hamburger", title: nil, action: #selector(showDetails))
        
        items.append(barButtonItem)
        
        if photoInfo?.commentsCount > 0 {
            
            let commentsbarButtonItem = barButtonItemWithImageNamed("bubble", title: "\(photoInfo?.commentsCount ?? 0)", action: #selector(showComments))
        
            items.append(commentsbarButtonItem)
        
        }
        
        items.append(flexibleSpace)
        
        items.append(UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(showActions)))
        
        items.append(flexibleSpace)
        
        let likebarButtonItem = barButtonItemWithImageNamed("like", title: "\(photoInfo?.votesCount ?? 0 )", action: nil)
        
        items.append(likebarButtonItem)
        
        let heart = barButtonItemWithImageNamed("heart", title: "\(photoInfo?.votesCount ?? 0)", action: nil)
        
        items.append(heart)
        
        self.setToolbarItems(items, animated: true)
        
        navigationController?.setToolbarHidden(false, animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: userInfoViewForPhotoInfo(photoInfo!))
    }
    
    func userInfoViewForPhotoInfo(photoInfo: PhotoInfo?) -> UIView {
        
        let userProfileImageView = UIImageView(frame: CGRect(x: 0, y: 10.0, width: 30.0, height: 30.0))
        
        userProfileImageView.layer.cornerRadius = 3.0
        
        userProfileImageView.layer.masksToBounds = true
        
        return userProfileImageView
    
    }
    
    func showDetails() {
        
        print("showDetails")
        
        let photoDetailsViewController = PhotoDetailsViewController()
        
        photoDetailsViewController.modalPresentationStyle = .OverCurrentContext //.Popover //
        
        photoDetailsViewController.modalTransitionStyle = .CoverVertical
        
        photoDetailsViewController.photoInfo = self.photoInfo
        
        presentViewController(photoDetailsViewController, animated: true) { 
            
        }
    
    }
    
    func showActions() {}
    
    func showComments() {
    
        let photoCommentsViewController = PhotoCommentsViewController()
        
        photoCommentsViewController.modalPresentationStyle = .Popover
        
        photoCommentsViewController.modalTransitionStyle = .CoverVertical
        
        photoCommentsViewController.photoID = self.photoID
        
        photoCommentsViewController.popoverPresentationController?.delegate = self
        
        presentViewController(photoCommentsViewController, animated: true) { 
            
        }
        
    
    }
    
    func barButtonItemWithImageNamed(imageName: String?, title: String?, action: Selector?) -> UIBarButtonItem {
        
        let button = UIButton(type: UIButtonType.Custom)
        
        if let imageName = imageName {
            
            button.setImage(UIImage(named: imageName)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: .Normal)
        
        
        }
        
        if let title = title {
        
            button.setTitle(title, forState: UIControlState.Normal)
            
            button.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 0.0)
            
            let font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
            
            button.titleLabel?.font = font
        
        }
    
        let size = button.sizeThatFits(CGSize(width: 90.0, height: 30.0))
        
        button.frame.size = CGSize(width: min(size.width + 10.0, 60), height: size.height)
        
        if let action = action {
        
            button.addTarget(self, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        
        }
        
        let barButton = UIBarButtonItem(customView: button)
        
        return barButton
    }
    
    private func  setupUIS() {
        
        navigationController?.setToolbarHidden(false, animated: true)
    
        self.view.addSubview(scrollView)
        
        
        
        self.view.addSubview(spinner)
        
        //self.view.addSubview(photoImageview)
        
        //photoImageview.xmg_Fill(self.view)
        
        //photoImageview.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: self.view, size: nil, offset: CGPoint(x: 0, y: 84))
        
        let width = self.view.frame.width
        
        let height = self.view.frame.height
        
        scrollView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: self.view, size: CGSize(width: width, height: height), offset: CGPoint(x: 0, y: 64.0))
        
        scrollView.addSubview(photoImageview)
        
        photoImageview.xmg_Fill(scrollView)
        
    }
    
    
    private lazy var scrollView: UIScrollView = {
        
        let scrollview = UIScrollView()
        
        scrollview.delegate = self
        
        scrollview.minimumZoomScale = 1.0
        
        scrollview.maximumZoomScale = 3.0
        
        scrollview.zoomScale = 1.0
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        
        doubleTapRecognizer.numberOfTapsRequired = 2
        
        doubleTapRecognizer.numberOfTouchesRequired = 1
        
        let singleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(_:)))
        
        singleTapRecognizer.numberOfTapsRequired = 1
        
        singleTapRecognizer.numberOfTouchesRequired = 1
        
        singleTapRecognizer.requireGestureRecognizerToFail(doubleTapRecognizer)
        
        scrollview.addGestureRecognizer(doubleTapRecognizer)
        
        scrollview.addGestureRecognizer(singleTapRecognizer)
        
        return scrollview
    
    
    }()
    
    
    private lazy var photoImageview: UIImageView = {
    
        let imageView = UIImageView()
        
        imageView.contentMode = .ScaleAspectFill
        
        return imageView
    
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        
        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        indicatorView.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
        
        indicatorView.startAnimating()
        
        
        return indicatorView
    }()
    
    

    
    func handleDoubleTap(recognizer: UITapGestureRecognizer) {
    
    
    }
    
    func handleSingleTap(recognizer: UITapGestureRecognizer){}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

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

extension PhotoBrowserViewController: UIScrollViewDelegate, UIPopoverPresentationControllerDelegate {
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.OverCurrentContext
    }

    func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        let navController = UINavigationController(rootViewController: controller.presentedViewController)
        
        
        
        return navController
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        self.centerscrollViewContents()
    }
    
    func centerscrollViewContents() {
    
        let boundsSize = scrollView.frame
        
        var contentsFrame = self.photoImageview.frame
        
        if contentsFrame.size.width < boundsSize.width {
        
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.width) / 2.0
            
            
        } else {
            
            contentsFrame.origin.x = 0.0
        
        }
        
        if contentsFrame.height < boundsSize.height {
        
            contentsFrame.origin.y = (boundsSize.height - scrollView.scrollIndicatorInsets.top - scrollView.scrollIndicatorInsets.bottom - contentsFrame.height) / 2.0
        
        } else {
            
            contentsFrame.origin.y = 0.0
        
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.photoImageview
    }
    
    func zoomInZoomOut(point: CGPoint!) {
        
        let newZoomscale = self.scrollView.zoomScale > (self.scrollView.maximumZoomScale / 2) ? self.scrollView.minimumZoomScale : self.scrollView.maximumZoomScale
    
        let scrollViewSiez = self.scrollView.bounds.size
        
        let width = scrollViewSiez.width / newZoomscale
        
        let height = scrollViewSiez.height / newZoomscale
        
        let x = point.x - ( width / 2.0)
        
        let y = point.y - (height / 2.0)
        
        let rectToZoom = CGRect(x: x, y: y, width: width, height: height)
        
        self.scrollView.zoomToRect(rectToZoom, animated: true)
    }

}
