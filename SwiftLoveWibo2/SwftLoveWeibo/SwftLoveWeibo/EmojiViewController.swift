//
//  EmojiViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/24.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

private let EmojiCellReuseIdentifier = "EmojiCellReuseIdentifier"

class EmojiViewController: UIViewController {
    
    var selectorEmojiClosure: (emotion: Emoticon) -> Void
    
    init(callback: (emotion: Emoticon) -> Void) {
        
        //试图控制器的初始化特别！

        selectorEmojiClosure = callback
        
        super.init(nibName: nil, bundle: nil)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUIs()
        
    }
    
    private func setupUIs() {
        
        view.addSubview(EmojiCollectionView)
        
        view.addSubview(EmojiToolBar)
        
        EmojiCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        EmojiToolBar.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["EmojiCollectionView": EmojiCollectionView, "EmojiToolBar": EmojiToolBar]
        
        var viewCons = [NSLayoutConstraint]()
        
        viewCons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[EmojiCollectionView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        
        viewCons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[EmojiToolBar]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        
        viewCons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[EmojiCollectionView]-[EmojiToolBar(44)]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        
        view.addConstraints(viewCons)
    
    }
    
    @objc private func itemBarClick(item: UIBarButtonItem) {
        
        EmojiCollectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: item.tag), atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
        
    }

    private lazy var EmojiCollectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: EmojicLayout())
     
        collectionView.registerClass(EmojiCell.self, forCellWithReuseIdentifier: EmojiCellReuseIdentifier)
        
        collectionView.dataSource = self
        
        collectionView.delegate = self
        
        return collectionView
    
    }()
    
    
    private lazy var EmojiToolBar: UIToolbar = {
        
        let toolBar = UIToolbar()
        
        toolBar.tintColor = UIColor.darkGrayColor()
        
        var items = [UIBarButtonItem]()
        
        var index = 0
        
        for title in ["最近", "默认", "Emoji", "浪小花"] {
            
            let item = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(itemBarClick(_:)))
            
            items.append(item)
            
            item.tag = index
            
            index += 1
            
            items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil))
            
        }
        
        items.removeLast()
        
        toolBar.items = items
        
        return toolBar
        
    }()
    
    private lazy var emoPackages: [EmoticonPackages] = EmoticonPackages.packageList

}

class EmojicLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        
      
        
        let width = collectionView!.bounds.width / 7
        
        itemSize = CGSize(width: width, height: width)
        
        minimumLineSpacing = 0
        
        minimumInteritemSpacing = 0
        
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView?.pagingEnabled = true
        
        collectionView?.showsHorizontalScrollIndicator = false
        
        collectionView?.bounces = false
        
        let y = (collectionView!.bounds.height - 3 * width) * 0.45
        
        collectionView?.contentInset = UIEdgeInsets(top: y, left: 0, bottom: y, right: 0)
    }
}
//MARK: 扩展类，实现UICollection的数据源和代理

extension EmojiViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return emoPackages.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return emoPackages[section].emoticons?.count ?? 0
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(EmojiCellReuseIdentifier, forIndexPath: indexPath) as! EmojiCell
        
        let package = emoPackages[indexPath.section]
        
        let emoticon = package.emoticons![indexPath.item]
        
        cell.emoticon = emoticon
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.redColor() : UIColor.orangeColor()
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //let cell = collectionView.dequeueReusableCellWithReuseIdentifier(EmojiCellReuseIdentifier, forIndexPath: indexPath) as! EmojiCell
        
        let selectorEmoticon = emoPackages[indexPath.section].emoticons![indexPath.item]
        
        selectorEmoticon.times += 1
        
        emoPackages[0].appendEmoticonToNowGroup(selectorEmoticon)
        
        self.selectorEmojiClosure(emotion: selectorEmoticon)
    }

}

private class EmojiCell: UICollectionViewCell {

    var emoticon: Emoticon? {
    
        didSet {
            
            ///这里要注意cel的重用问题（button既能显示文本也能显示图片）
            
            if emoticon?.chs != nil {
                
                let image = UIImage(contentsOfFile: emoticon!.imagePath!)
            
                emojiButton.setImage(image, forState: .Normal)
            
            } else {
            
                emojiButton.setImage(nil, forState: .Normal)
            }
            
            emojiButton.setTitle(emoticon!.imageStr ?? "", forState: .Normal)
            
            if emoticon!.isRemove {
                
                emojiButton.setImage(UIImage(named: "compose_emotion_delete"), forState: .Normal)
                
                emojiButton.setImage(UIImage(named: "compose_emotion_delete_highlighted"), forState: UIControlState.Highlighted)
            
            }
        
        }
    
    }
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUIs()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUIs(){
    
        contentView.addSubview(emojiButton)
        
        let rect = contentView.bounds
        
        emojiButton.frame = CGRectInset(rect, 4, 4)
    }
    
    private lazy var emojiButton: UIButton = {
    
        let button = UIButton()
        
        button.titleLabel?.font = UIFont.systemFontOfSize(32)
        
        button.tintColor = UIColor.darkGrayColor()
        
        button.userInteractionEnabled = false
        
        return button
    }()

}
