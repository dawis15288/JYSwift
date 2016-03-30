//
//  WeiboPictrueViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/22.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import SVProgressHUD

let JYWeiboPictureReuseIdentifier = "PictrueCell"

class WeiboPictrueViewController: UIViewController {
    
    var weiboPiictrueURLS: [NSURL]?
    
    var weiboPiictrueindex: Int?
    
    init(index: Int, imageURL: [NSURL]) {
    
        super.init(nibName: nil, bundle: nil)
        
        weiboPiictrueURLS = imageURL
        
        weiboPiictrueindex = index
    }
    
    private func setupUI() {
        
        view.addSubview(pictrueCollectionView)
        
        pictrueCollectionView.dataSource = self
        
        pictrueCollectionView.delegate = self
        
        pictrueCollectionView.registerClass(PctrueCell.self, forCellWithReuseIdentifier: JYWeiboPictureReuseIdentifier)
        
        view.addSubview(closeButton)
        
        view.addSubview(saveButton)
        
        closeButton.xmg_AlignInner(type: XMG_AlignType.BottomLeft, referView: view, size: CGSize(width: 100, height: 35), offset: CGPoint(x: 10, y: -10))
        
        saveButton.xmg_AlignInner(type: XMG_AlignType.BottomRight, referView: view, size: CGSize(width: 100, height: 35), offset: CGPoint(x: -10, y: -10))
        
        pictrueCollectionView.frame = UIScreen.mainScreen().bounds
        
        
    
    }
    
    @objc private func closeImage() {
        
        dismissViewControllerAnimated(true, completion: nil)
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        // Do any additional setup after loading the view.
    }
    
    private lazy var closeButton: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("关闭", forState:  .Normal)
        
        button.backgroundColor = UIColor.blackColor()
        
        button.addTarget(self, action: #selector(close), forControlEvents: .TouchUpInside)
        
        return button
    
    }()
    
   @objc private func close() {
        
        dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    private lazy var saveButton: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("保存", forState:  .Normal)
        
        button.backgroundColor = UIColor.blackColor()
        
        button.addTarget(self, action: #selector(save), forControlEvents: .TouchUpInside)
        
        return button
        
    }()
    
    @objc private func save() {
    
        let index = pictrueCollectionView.indexPathsForVisibleItems().last!
        
        let cell = pictrueCollectionView.cellForItemAtIndexPath(index) as! PctrueCell
        
        let image = cell.iconView.image
        
        UIImageWriteToSavedPhotosAlbum(image!, self, #selector(images), nil)
    }
    
    @objc private func images(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:  AnyObject) {
    
        if error != nil {
            
            SVProgressHUD.showErrorWithStatus("保存失败", maskType: SVProgressHUDMaskType.Black)
        
        } else {
            
            SVProgressHUD.showSuccessWithStatus("保存成功", maskType: SVProgressHUDMaskType.Black)
        
        }
    }
    
    lazy var pictrueCollectionView: UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: WeiboPictruelayout())

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension WeiboPictrueViewController: UICollectionViewDelegate, UICollectionViewDataSource, PctrueCellDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return weiboPiictrueURLS?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(JYWeiboPictureReuseIdentifier, forIndexPath: indexPath) as! PctrueCell
        
        //cell.backgroundColor = UIColor(red: 100.0, green: 65.0, blue: CGFloat(indexPath.row), alpha: 1)
        //let imageView = UIImageView(frame: cell.contentView.frame)
        //CollectionView.scrollToItemAtIndexPath(indexPath
        //, atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)

        if let imageURL = weiboPiictrueURLS?[indexPath.row] {
        
            cell.imageURL = imageURL
            
            cell.pctrueCellDelegate = self
        
        }
        
        
        return cell
        
    }
    
    func pctrueCellDelegate(cell: PctrueCell) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }

}

class WeiboPictruelayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        
        itemSize = UIScreen.mainScreen().bounds.size
        
        minimumLineSpacing = 0
        
        minimumInteritemSpacing = 0
        
        /*collectionView?.bounces = false
        
        collectionView?.scrollEnabled = false
        
        collectionView?.showsHorizontalScrollIndicator = true*/
        
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView?.pagingEnabled = true
        
        collectionView?.bounces = false
        
        collectionView?.showsHorizontalScrollIndicator = false
    }
}
