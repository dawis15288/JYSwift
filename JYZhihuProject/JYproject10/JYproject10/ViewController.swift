//
//  ViewController.swift
//  JYproject10
//
//  Created by atom on 16/3/2.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

@IBDesignable class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var people: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addNewPerson")
    }
    
    func addNewPerson() {
        
        let picker = UIImagePickerController()
        
        picker.allowsEditing = true
        
        picker.delegate = self
        
        presentViewController(picker, animated: true, completion: nil)
    
    }
    
    // MARK: imagePicker
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("\(info)")
        
        var newImage: UIImage
        
        //var newImag: UIImagePickerControllerDelegate UIImagePickerControllerEditedImage
        if let possibleImag = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            newImage = possibleImag
        
        } else if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
        
            newImage = possibleImage
            
            
        } else {
        
            return
        
        }
        
        let imageName = NSUUID().UUIDString
        
        let imagePath = getDocumentsDirectory().stringByAppendingPathComponent(imageName)
        
        if let jpegData = UIImageJPEGRepresentation(newImage, 80) {
            
            jpegData.writeToFile(imagePath, atomically: true)
        
        }
        
        let person = Person(name: "jy", image: imageName)
        
        people.append(person)
        
        collectionView.reloadData()
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func getDocumentsDirectory() -> NSString {
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        print("\(path)")
        
        let documentDirectory = path[0]
        
        return documentDirectory
        
    
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        print("\(image)")
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
       dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // MARK: collection
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return people.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("jyCell", forIndexPath: indexPath) as! JYCollectionViewCell
        
        if let name = people[indexPath.row].name as? String {
            
            cell.name.text = name
        
        }
        
        
        
        if let imageName = people[indexPath.row].image as? String {
        
            cell.imageView.image = UIImage(contentsOfFile: getDocumentsDirectory().stringByAppendingPathComponent(imageName))
        }
        
        
        
        return cell
    }

}

