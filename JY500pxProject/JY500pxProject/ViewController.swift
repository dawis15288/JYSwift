//
//  ViewController.swift
//  JY500pxProject
//
//  Created by atom on 16/4/30.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import Alamofire

let PhotoCellWithReuseIdentifier = "jycell"

let PhotoFooterWithReuseIdentifier = "jyfooter"

class ViewController: UIViewController {
    
    var downloadedPhototURLs: [NSURL]?
    
    let refreshControl = UIRefreshControl()
    
    var populatingPhotos = false
    
    var currentPage = 1
    
    var photos = Set<PhotoInfo>() /*: [PhotoInfo]? {
        
        didSet {
        
            self.photoCollectionView.reloadData()
            
        }
    
    }*/
    
    var request: Alamofire.Request?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupUIs()
        
        setNav()
        
        populatePhotos()
        
        
    }
    
     func scrollViewDidScroll(scrollView: UIScrollView) {
        
        
        if scrollView.contentOffset.y + self.view.frame.size.height > scrollView.contentSize.height * 0.8 {
        
            populatePhotos()
        }

    }
    
    private func populatePhotos() {
        
        if populatingPhotos {
            
            return
        
        }
        
        populatingPhotos = true
    
        Alamofire.request(Five500px.Router.PopularPhotos(self.currentPage)).responseJSON { (response) in
            
            func failed() { self.populatingPhotos = false }
            
            guard let jsondata = response.result.value else { failed(); return }
            
            if response.result.error != nil {
            
                failed()
                
                return
            
            }
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { 
                
                guard let photosJSONs = jsondata.valueForKey("photos") as? [[String : AnyObject]] else { failed(); return}
                
                let lastItem = self.photos.count
                
                photosJSONs.forEach{
                    
                    guard let nsfw = $0["nsfw"] as? Bool,
                    
                            let id = $0["id"] as? Int,
                    
                            let url = $0["image_url"] as? String
                    
                        where nsfw == false else { return }
                    
                    //self.photos?.append(PhotoInfo(id: id, url: url))
                    
                    self.photos.insert(PhotoInfo(id: id, url: url))
                    
                }
                
                let indexPaths = (lastItem..<self.photos.count).map {
                
                    NSIndexPath(forItem: $0, inSection: 0)
                    
                }
                
                dispatch_async(dispatch_get_main_queue()) {

                    self.photoCollectionView.insertItemsAtIndexPaths(indexPaths)
                    
                }
                
                self.currentPage = self.currentPage + 1
            })
            
        }
        
        self.populatingPhotos = false
    
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let directoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        
        var error: NSError?
        
        let urls: [AnyObject]?
        
        do {
        
            urls = try NSFileManager.defaultManager().contentsOfDirectoryAtURL(directoryURL, includingPropertiesForKeys: nil, options: [])
            
            print("\(urls)")
        
        } catch let error1 as NSError {
        
            error = error1
            
            urls = nil
        }
        
        if error == nil {
        
            downloadedPhototURLs = urls as? [NSURL]
        
        }
    }
    
    private func setNav() {
    
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        navigationItem.titleView = titleLabel
    
    }
    
    private func setupUIs() {
    
        self.navigationItem.title = "500px"
        
        self.view.addSubview(photoCollectionView)
        
        photoCollectionView.xmg_Fill(self.view)
        
        
    }
    
    private lazy var photoCollectionView: UICollectionView = {
        
        let collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: JYPhotoLayout()) //JYPhotoLayout())
        
        collectionview.dataSource = self
        
        collectionview.delegate = self
        
        collectionview.registerClass(JY500pxCell.self, forCellWithReuseIdentifier: PhotoCellWithReuseIdentifier)
        
        collectionview.registerClass(PhotoLoadingCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: PhotoFooterWithReuseIdentifier)
        
        self.refreshControl.tintColor = UIColor.whiteColor()
        
        self.refreshControl.addTarget(self, action: #selector(handleRefresh), forControlEvents: .ValueChanged)
        
        collectionview.addSubview(self.refreshControl)
        
        return collectionview
    
    }()
    
    func handleRefresh() {}
    
    private lazy var titleLabel: UILabel = {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        
        label.text = "Photomania"
        
        label.textColor = UIColor.redColor()
        
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        
        return label
    
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.photos.count ?? 0
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoCellWithReuseIdentifier, forIndexPath: indexPath) as! JY500pxCell
        
        
        
        
        
        cell.photoInfo = self.photos[self.photos.startIndex.advancedBy(indexPath.row)]
        return cell
        
        
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        print("collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath")
        return collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: PhotoFooterWithReuseIdentifier, forIndexPath: indexPath) as UICollectionReusableView
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let photoBrowserVC = PhotoBrowserViewController()
        
        photoBrowserVC.photoID = self.photos[self.photos.startIndex.advancedBy(indexPath.row)].id
        
        navigationController?.pushViewController(photoBrowserVC, animated: true)
        
    }

}

class PhotoLoadingCell: UICollectionReusableView {

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUIS()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUIS() {
        
        self.addSubview(spinner)
        
        
        
        spinner.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: self, size: nil, offset: CGPoint(x: self.center.x, y: self.center.y))
        
        spinner.startAnimating()
    }
    
    private lazy var spinner: UIActivityIndicatorView = {
    
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        spinner.center = CGPoint(x: self.center.x, y: 20.0)
        return spinner
    
    }()

}

