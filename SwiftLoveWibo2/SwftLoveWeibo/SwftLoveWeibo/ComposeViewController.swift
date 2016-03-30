//
//  ComposeViewController.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/24.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

import Alamofire

class ComposeViewController: UIViewController {
    
    var toolBarBttomconstraint: NSLayoutConstraint?
    
    //MARK: 加载视图
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.whiteColor()
        
        setupUIs()
        
        setupNav()
        
        setupToolbar()
        
        addChildViewController(EmojiVC)
        
        //textView.inputView = EmojiVC.view
        
       NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keybardAndToolbar(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
        
    }
    
    //MARK: 响应UIKeyboardWillChangeFrameNotification通知，获取键盘位置，修改工具的位置
    
    @objc private func keybardAndToolbar(notification: NSNotification) {
        
        let animationCurve = notification.userInfo!["UIKeyboardAnimationCurveUserInfoKey"] as! NSNumber
        
        let value = notification.userInfo!["UIKeyboardFrameEndUserInfoKey"]!.CGRectValue
        
       let heght = UIScreen.mainScreen().bounds.height
        
        toolBarBttomconstraint?.constant = -( heght - value.origin.y)
        
        let dur = notification.userInfo!["UIKeyboardAnimationDurationUserInfoKey"]! as! Double
        
        UIView.animateWithDuration(dur, animations: { () -> Void in
            
            ///设置动画曲线，消除切换键盘，工具条跳动的问题
            
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: animationCurve.integerValue)!)
        
            self.view.layoutIfNeeded()
        })
    
    }
    
    //MARK: 在控制器消失的时候删除注册的通知
    
    deinit {
    
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    //MARK: 在视图完全显示的时候在弹出键盘，工具条就不会看起来像是从侧边出来的
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        textView.becomeFirstResponder()
        
        
    }
    
    //MARK: 在视图消失的时候放弃键盘，这样就能销毁视图了
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        textView.resignFirstResponder()
    }
    //MARK: 设置导航条，包括左右按钮和标题视图
    private func setupNav() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(close))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(sendWeibo(_:)))
        
        navigationItem.rightBarButtonItem?.enabled = false
        
        navigationItem.titleView = titleView
        
       
    
    }
    //MARK: 设置工具条
    private func setupToolbar() {
        
        view.addSubview(toolbar)
        
        let width = UIScreen.mainScreen().bounds.width
        
        let cns = toolbar.xmg_AlignInner(type: XMG_AlignType.BottomLeft, referView: view, size: CGSize(width: width, height: 44))
        
        toolBarBttomconstraint = toolbar.xmg_Constraint(cns, attribute: NSLayoutAttribute.Bottom)
    
    }
    
    //MARK: 关闭发送微博视图
    @objc private func close(){
        
        dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    //MARK: 发送微博
    
    func sendWeibo(items: UIBarButtonItem) {
        
        print(self.textView.emoticonAttributesText())
        
        let ac = UIAlertController(title: "发送成功", message: "\(self.textView.emoticonAttributesText())", preferredStyle: UIAlertControllerStyle.Alert)
        
        ac.addAction(UIAlertAction(title: "ok", style: .Default, handler: nil))
        
        self.presentViewController(ac, animated: true, completion: nil)
    
        /*let request = NSMutableURLRequest(URL: NSURL(string: targetURLString)!)
         
         request.HTTPMethod = "GET"
         
         request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")*/
        
        
            
        if let weiboAccessToken = UserAccount.loadAccount()?.access_token {
            
           
         //let postURLString = "https://api.weibo.com/2/statuses/update.json?access_token=\(weiboAccessToken)&status=\(textView.text)"
            
            /*Alamofire.request(.POST, "https://api.weibo.com/2/statuses/update.json", parameters: ["access_token": weiboAccessToken, "status": textView.text]).responseJSON(completionHandler: { (response) -> Void in
                
                if response.response?.statusCode == 200 {
                
                    let ac = UIAlertController(title: "发送成功", message: "success", preferredStyle: UIAlertControllerStyle.Alert)
                    ac.addAction(UIAlertAction(title: "ok", style: .Default, handler: nil))
                    
                    self.presentViewController(ac, animated: true, completion: nil)
                }
                
            })*/
        }
    
    }
    
    //MARK: 添加输入视图和提示label
    
    private func setupUIs() {
    
        view.addSubview(textView)
        
        textView.addSubview(placeholdLabel)
        
        
        
        textView.xmg_Fill(view)
        
        
        
        placeholdLabel.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: textView, size: nil, offset: CGPoint(x: 5, y: 8))
    }
//MARK: 内存警告
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    //MARK: 初始化textV
    private lazy var textView: UITextView = {
        
        let textView = UITextView()
        
        //这里没有设置字体大小，所以导致插入图片表情的时候程序崩溃，使用系统键盘，就不能切换表情键盘和模拟器键盘，导致点击只能出现表情键盘
        
        textView.font = UIFont.systemFontOfSize(18)
        
        textView.alwaysBounceHorizontal = true
        
        textView.alwaysBounceVertical = true
        
        textView.keyboardDismissMode = .OnDrag
        
        textView.delegate = self
        
        return textView
    
    }()
    //MARK: 初始化提示label
    private lazy var placeholdLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "分享新鲜事..."
        
        label.font = UIFont.systemFontOfSize(13)
        
        label.textColor = UIColor.darkGrayColor()
        
        return label
    
    }()
    //MARK: 初始化导航栏标题
    private lazy var titleView: UIView = {
        
        let view = UIView()
        
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 32)
    
        let label1 = UILabel()
        
        label1.text = "发送微博"
        
        label1.textColor = UIColor.grayColor()
        
        label1.font = UIFont.systemFontOfSize(15)
        
        label1.sizeToFit()
        
        
        let label2 = UILabel()
        
        if let user = NSUserDefaults.standardUserDefaults().objectForKey("userName") as? String {
        
            label2.text = user
            
            label2.textColor = UIColor.grayColor()
            
            label2.font = UIFont.systemFontOfSize(13)
            
            label2.sizeToFit()
        
        }
        
        view.addSubview(label1)
        
        view.addSubview(label2)
        
        label1.xmg_AlignInner(type: XMG_AlignType.TopCenter, referView: view, size: nil)
        
        label2.xmg_AlignInner(type: XMG_AlignType.BottomCenter, referView: view, size: nil)
        
        return view
    
    }()
    //MARK: 初始化工具条
    private lazy var toolbar: UIToolbar = {
        
        let toolbar = UIToolbar()
        
        var items = [UIBarButtonItem]()
        
        var itemTag = 0
        
        let itemSettings = [["imageName": "compose_toolbar_picture", "action": "selectPicture"],
                            ["imageName": "compose_mentionbutton_background"],
                            ["imageName": "compose_trendbutton_background"],
                            ["imageName": "compose_emoticonbutton_background", "action": "inputEmoticon"],
                            ["imageName": "compose_addbutton_background"]]
        
        for dict in itemSettings {
            
            let image = UIImage(named: dict["imageName"]!)
            
            
            
            let item = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(selectPicture(_:)))
            
            item.tag = itemTag
            
            itemTag += 1
            
            items.append(item)
            
            items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil))
        
        }
        
        items.removeLast()
        
        toolbar.items = items
        
        return toolbar
    
    }()
    //MARK: 工具条item执行的action
    @objc private func selectPicture(item: UIBarButtonItem) {
        
        print("当前点击的item是\(item.tag)")
        
        textView.resignFirstResponder()
        
        print("\(textView.inputView)")
        
        textView.inputView = (textView.inputView == nil) ? EmojiVC.view : nil
        
        textView.becomeFirstResponder()
        
        
    }
    
    //MARK: 添加表情键盘
   
    private lazy var EmojiVC: EmojiViewController = EmojiViewController(callback: { [unowned self] (emotion) -> Void in
        
            self.textView.insetEmoticonImage(emotion)
        
        // 主动触发代理，隐藏提示内容！
        
            self.textViewDidChange(self.textView)
        
        })
}

//MARK: 扩展类，实现textV的代理方法
extension ComposeViewController: UITextViewDelegate {
    
    func textViewDidChange(textView: UITextView) {
        
        if textView.hasText() {
        
             placeholdLabel.hidden = true
            
            navigationItem.rightBarButtonItem?.enabled = true
            
        }
        
       
    }

}
