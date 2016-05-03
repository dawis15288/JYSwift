 //
//  HomeViewController.swift
//  JYDYTabBar
//
//  Created by atom on 16/4/18.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

let width = UIScreen.mainScreen().bounds.width

class HomeViewController: UIViewController, UIScrollViewDelegate {
    
    var indicatorView: UIView?
    
    var selectorButton: UIButton?
    
    var labelView: UIView?
    
    var subController: [UIViewController]?
    
    var jyscrollView: UIScrollView?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addSubController()
        
        //addButton()

        setupNav()
        
        setupUIS()
        
        self.scrollViewDidEndScrollingAnimation(jyScrollView)
        
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    private func setupNav() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "MainTagSubIcon"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(tagSub))
    }
    
    private func setupUIS() {
        
        self.view.addSubview(jylabelView)
        
        self.view.insertSubview(jyScrollView, atIndex: 0)
        
        //CGRect(x: 0, y: 64, width: width, height: 36)
        
        let width = UIScreen.mainScreen().bounds.width
        
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        jylabelView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: view, size: CGSize(width: width, height: 36), offset: CGPoint(x: 0, y: 64))
        
        jyScrollView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: view, size: CGSize(width: width, height: screenHeight),  offset: CGPoint(x: 0, y: 0))
        
    }
    
    private lazy var jylabelView: JYLabelView = {
        
        let view = JYLabelView()
        
        view.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.7)
        
        view.delegate = self
        
        //LabelView(frame: CGRect(x: 0, y: 64, width: width, height: 36))
        
        return view
        
        
    }()
    
    private lazy var jyScrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        
        scrollView.delegate = self
        
        scrollView.frame = self.view.bounds
        
        scrollView.backgroundColor = UIColor.whiteColor()
        
        let count = CGFloat(self.childViewControllers.count)
        
        
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width *  count , height: 0)
        
        scrollView.pagingEnabled = true
        
        return scrollView
        
    }()
    
    private func  titleclick(button: UIButton) {
        
        self.jylabelView.selectorButton?.enabled = true
        
        button.enabled = false
        
        self.jylabelView.selectorButton = button
        
        UIView.animateWithDuration(0.25) {
            
            let margin = button.frame.width * CGFloat(integerLiteral: button.tag - 10)
            
            let x = CGFloat(31.5)
            
            self.jylabelView.jyIndview!.frame.origin.x = x + margin
            
        }
        
    }
    
    /*private func  addButton() {
        
        labelView = jyLabelView
        
        let titles = ["全部","图片","视频","最新","声音"]
        
        let buttonWidth = width / CGFloat(integerLiteral: titles.count)
        
        for i in 0..<titles.count {
            
            let btton = UIButton()
            
            btton.tag = i
            
            btton.setTitle(titles[i], forState: UIControlState.Normal)
            
            btton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            
            btton.setTitleColor(UIColor.redColor(), forState: UIControlState.Disabled)
            
            btton.titleLabel?.font = UIFont.systemFontOfSize(15)
            
            btton.addTarget(self, action: #selector(titleclick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            btton.frame =  CGRect(x: buttonWidth * CGFloat(integerLiteral:  i), y: 0, width: buttonWidth, height: labelView!.frame.size.height)
            
            self.jyButton?.append(btton)
            
            labelView!.addSubview(btton)
            
            
            
            if i == 0 {
                
                self.titleclick(btton)
                
            }
            
        }
        
       
        
        self.view.addSubview(labelView!)
        
        self.indicatorView = jyview
        
        labelView!.addSubview(jyview)
    
    }*/
    
    
    /*func titleclick(button: UIButton) {
        
        self.selectorButton?.enabled = true
        
        button.enabled = false
        
        self.selectorButton = button
        
        UIView.animateWithDuration(0.25) {
            
            let margin = CGFloat(integerLiteral: button.tag * 75 )
            
            self.indicatorView?.frame.origin.x = 24.5 + margin
            
        }
        
        var offset = jyScrollView!.contentOffset
        
        let tag = CGFloat(integerLiteral: button.tag)
        
        offset.x = tag * jyScrollView!.frame.width
        
        jyScrollView!.setContentOffset(offset, animated: true)
        
    }*/
    
   /* private lazy var jyLabelView: UIView = {
    
        let view = UIView(frame: CGRect(x: 0, y: 64, width: width, height: 36))
        
        view.tag = 10
        
        view.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.7)
        
        return view
        
    }()*/
    
    /*private lazy var jyview: UIView = {
    
        let view = UIView()
    
        view.frame.size.height = 2
    
        view.frame.origin.y = self.labelView!.frame.size.height - 2
    
        view.frame.size.width = 26
    
        view.frame.origin.x = 24.5
    
        view.backgroundColor = UIColor.redColor()
        
        view.tag = -1
        
        return view
    
    }()*/
    
    private func addSubController() {
        
        //1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
        
        let vc1 = JYTopicViewController()
        
        vc1.type = "1"
        
        let vc2 = JYTopicViewController()
        
        vc2.type = "29"
        
        
        let vc3 = JYTopicViewController()
        
        vc3.type = "41"
        
        let vc4 = JYTopicViewController()
        
        vc4.view.backgroundColor = UIColor.cyanColor()
        
        vc4.type = "31"
        
        let vc5 = JYTopicViewController()
        
        vc5.type = "10"
        
        self.addChildViewController(vc1)
        
        self.addChildViewController(vc2)
        
        self.addChildViewController(vc3)
        
        self.addChildViewController(vc4)
        
        self.addChildViewController(vc5)
    
        /*let allVC = AllViewController()
        
        let videoVC = VideoViewController()
        
        let pictrueVC = PictrueViewController()
        
        let newVC = NewViewController()
        
        let redioVC = RedioViewController()
        
        self.addChildViewController(allVC)
        
        self.addChildViewController(videoVC)
        
        self.addChildViewController(pictrueVC)
        
        self.addChildViewController(newVC)
        
        self.addChildViewController(redioVC)*/
        
        
    
    }
    
    func tagSub() {
        
        let JYTagSubVC = MainTagSubViewController()
        
        navigationController?.pushViewController(JYTagSubVC, animated: true)
    
    }
    
    

}

 extension HomeViewController: JJYLabelViewdelagate {
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        let width = scrollView.frame.width
        
        let offset = scrollView.contentOffset.x
        
        let index = Int(offset / width)
        
        let vc = self.childViewControllers[index]
        
        vc.view.frame.origin.x = offset
        
        vc.view.frame.size.height = scrollView.frame.size.height
        
        scrollView.addSubview(vc.view)
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        self.scrollViewDidEndScrollingAnimation(scrollView)
        
        let width = scrollView.frame.width
        
        let offset = scrollView.contentOffset.x
        
        let buttonIndex = Int( offset / width) + 10
        
        print(buttonIndex)
        
        let button = self.jylabelView.viewWithTag(buttonIndex) as? UIButton
        
        print(button)
        
        self.titleclick(button!)
        
    }
    
    func buttontitleClick(button: UIButton) {
        
        var offset = self.jyScrollView.contentOffset
        
        offset.x = CGFloat(integerLiteral: button.tag - 10) * self.jyScrollView.frame.size.width
        
        self.jyScrollView.setContentOffset(offset, animated: true)
        
    }

    /*func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        let width = scrollView.frame.width
        
        let offset = scrollView.contentOffset.x
        
        let index = Int(offset / width)
        
        let vc = self.childViewControllers[index]
        
        vc.view.frame.origin.x = offset
        
        vc.view.frame.size.height = scrollView.frame.size.height
        
        //vc.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        
        scrollView.addSubview(vc.view)
        
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        self.scrollViewDidEndScrollingAnimation(scrollView)
        
        let width = scrollView.frame.width
        
        let offset = scrollView.contentOffset.x
        
        let buttonIndex = Int( offset / width)
        
        let button = self.labelView?.viewWithTag(buttonIndex) as! UIButton
        
        
        
        self.titleclick(button)
        
        
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }*/

}
