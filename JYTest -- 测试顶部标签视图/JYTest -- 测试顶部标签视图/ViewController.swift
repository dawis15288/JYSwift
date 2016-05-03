//
//  ViewController.swift
//  JYTest -- 测试顶部标签视图
//
//  Created by atom on 16/4/29.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "ok"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "add", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(add))
        
        addChildViews()
        
        setupUIS()
        
        self.scrollViewDidEndScrollingAnimation(jyScrollView)
        
    }
    
    private func setupUIS() {
        
        self.view.addSubview(jylabelView)
        
        self.view.insertSubview(jyScrollView, atIndex: 0)
        
        //CGRect(x: 0, y: 64, width: width, height: 36)
        
        let width = UIScreen.mainScreen().bounds.width
        
        let height = UIScreen.mainScreen().bounds.height
        
        jylabelView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: view, size: CGSize(width: width, height: 36), offset: CGPoint(x: 0, y: 64))
        
        jyScrollView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: view, size: CGSize(width: width, height: height),  offset: CGPoint(x: 0, y: 0))
    
    }
    
    private lazy var jylabelView: JYLabelView = {
        
        let view = JYLabelView()
        
        view.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.7)
        
        view.delegate = self
        
        
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
    
    func add() {
        
        print("ok")
    
    }
    
    private func addChildViews() {
    
        let vc1 = JYTopicViewController()
        
        vc1.view.backgroundColor = UIColor.blueColor()
        
        vc1.type = "1"
        
        let vc2 = JYTopicViewController()
        
        vc2.view.backgroundColor = UIColor.greenColor()
        
        vc1.type = "2"
        
        
        let vc3 = JYTopicViewController()
        
        vc3.view.backgroundColor = UIColor.brownColor()
        
        vc1.type = "3"
        
        let vc4 = JYTopicViewController()
        
        vc4.view.backgroundColor = UIColor.cyanColor()
        
        vc1.type = "4"
        
        let vc5 = JYTopicViewController()
        
        vc5.view.backgroundColor = UIColor.redColor()
        
        vc1.type = "5"
        
        self.addChildViewController(vc1)
        
        self.addChildViewController(vc2)
        
        self.addChildViewController(vc3)
        
        self.addChildViewController(vc4)
        
        self.addChildViewController(vc5)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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


}

extension ViewController: UIScrollViewDelegate, JJYLabelViewdelagate {

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

}

