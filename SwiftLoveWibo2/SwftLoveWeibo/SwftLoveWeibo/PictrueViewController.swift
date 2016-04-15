//
//  PictrueViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/30.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class PictrueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUIS()
        
    }
    
    private func setupUIS() {
        
        view.addSubview(EmoticonPictrue)
        
        EmoticonPictrue.translatesAutoresizingMaskIntoConstraints = false
        
        var cons = [NSLayoutConstraint]()
        
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[EmoticonPictrue]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["EmoticonPictrue": EmoticonPictrue])
        
        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[EmoticonPictrue]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["EmoticonPictrue": EmoticonPictrue])
        
        view.addConstraints(cons)
    
    }
    
    private  lazy var EmoticonPictrue: EmoticonPictrueCollectionView = {
        
        let emtcnVew = EmoticonPictrueCollectionView(frame: CGRectZero, collectionViewLayout: EmoticonPictrueFlowLayout())
        
        emtcnVew.registerClass(EmoticoPictrueCell.self, forCellWithReuseIdentifier: EmoticonPictrueReuseIdentifier)
        
        
        emtcnVew.dataSource = self
        
        emtcnVew.delegate = self
        
        return emtcnVew
    
    }()
        //EmoticonPictrueFlowLayout())

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var images = [UIImage]()
    
    let imagePcker = UIImagePickerController()

}

extension PictrueViewController: UICollectionViewDelegate, UICollectionViewDataSource, EmoticoPictrueCellDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count + 1
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(EmoticonPictrueReuseIdentifier, forIndexPath: indexPath) as! EmoticoPictrueCell
        
        cell.backgroundColor = UIColor.redColor()
        
        cell.delegate = self
            
        print("++++++++++++++\(images.count)+++\(indexPath.item)+++++++++++++")
        
        cell.image = (images.count == indexPath.item) ? nil : images[indexPath.item]
        
        return cell
    
    }
    
    func EmoticonPictrueDidRemove(cell: EmoticoPictrueCell) {
        
        let indexPath = self.EmoticonPictrue.indexPathForCell(cell)
        
        images.removeAtIndex(indexPath!.item)
        
        self.EmoticonPictrue.reloadData()
        
    }
    
    func EmoticonPictrueDidSelector(cell: EmoticoPictrueCell) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            
            print("UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary")
        
        }
        
        imagePcker.allowsEditing = true
        
        imagePcker.delegate = self
        
        presentViewController(imagePcker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        if !images.contains(image) {
            
            print("氧吧韩这张\(image)")
            
            images.append(image)
            
            self.EmoticonPictrue.reloadData()
        
        }
        
        imagePcker.dismissViewControllerAnimated(true, completion: nil)
        
    }

}
