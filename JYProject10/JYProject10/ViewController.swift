//
//  ViewController.swift
//  JYProject10
//
//  Created by atom on 16/2/1.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var people = [Person]()
    
    //var peroples: Array<Person> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addNewPerson:")
        
    }
    
    func addNewPerson(item: UIBarButtonItem) {
        
        let picker = UIImagePickerController()
        
        picker.allowsEditing = true
        
        picker.delegate = self
        
        presentViewController(picker, animated: true, completion: nil)
    
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
       
        var newImage: UIImage
        
        if let possiableImage = info["UIImagePickerControllerEditedImage"] as?UIImage {
            
            newImage = possiableImage
        
        } else if let possiableImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
        
            newImage = possiableImage
        
        } else {
            
            return
        
        }
        
        let imageName = NSUUID().UUIDString
        
        let imagePath = getDocumentsDirectory().stringByAppendingPathComponent("/\(imageName)")
        
        if let jpegData = UIImageJPEGRepresentation(newImage, 80) {
            
            jpegData.writeToFile(imagePath, atomically: true)
        
        }
        
        let person = Person(name: imagePath, image: imageName)
        
        people.append(person)
        
        collectionView.reloadData()
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return people.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Person", forIndexPath: indexPath) as! JYCollectionViewCell
        
        let person = people[indexPath.row]
        
        cell.name.text = person.name
        
        let path = getDocumentsDirectory().stringByAppendingPathComponent("/\(person.image)")
        
        cell.imageView.image = UIImage(contentsOfFile: path)
        
        cell.imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).CGColor
        
        cell.imageView.layer.borderWidth = 2
        
        cell.imageView.layer.cornerRadius = 3
        
        cell.layer.cornerRadius = 7 
        
        return cell
    
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let person = people[indexPath.row]
        
        let ac = UIAlertController(title: "Renme person", message: nil, preferredStyle: .Alert)
        
        ac.addTextFieldWithConfigurationHandler(nil)
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        ac.addAction(UIAlertAction(title: "ok", style: .Default) { [unowned self, ac] _ in
            
            let newName = ac.textFields![0]
            
            person.name = newName.text!
            
            self.collectionView.reloadData()
            
        })
        
       presentViewController(ac, animated: false, completion: nil)
        
        
    }
    
    func getDocumentsDirectory() -> NSString {
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        let documentDirectory = paths[0]
        
        print(documentDirectory)
        
        return documentDirectory
    
    }


}

