//
//  ViewController.swift
//  FYLoadingView
//
//  Created by 武飞跃 on 2016/8/7.
//  Copyright © 2016年 RG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        createView()
        
        let loadingView = FYLoadingView(view: view)
        
        //模拟网络请求
        NSTimer.schedule(delay: 5) { (timer) in
            loadingView.dismiss()
        }
        
    }
    
    func createView(){
        self.view.backgroundColor = UIColor.whiteColor();
        self.navigationController?.navigationBar.translucent = false
        view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        view.frame.size.height -= 64
        
        //创建背景图片
        let imageView = UIImageView(frame:CGRect(x: 0, y: 100, width: 100, height: 100))
        imageView.center = view.center
        imageView.image = UIImage(named: "wufeiyue")
        view.addSubview(imageView)
        
        //创建上导航按钮
        let button = UIBarButtonItem.init(title: "PUSH", style: .Done, target: self, action: #selector(self.rightBarButtonAction))
        self.navigationItem.rightBarButtonItem = button
    }
    
    //上导航按钮点击响应事件
    func rightBarButtonAction(){
        navigationController?.pushViewController(FirstViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

