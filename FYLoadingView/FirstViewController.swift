//
//  FirstViewController.swift
//  FYLoadingView
//
//  Created by 武飞跃 on 2016/8/7.
//  Copyright © 2016年 RG. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    private var tableView:UITableView!
    private var loadingView:FYLoadingView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        //初始化，内部已做好处理，不可再进行addSubview添加
        loadingView = FYLoadingView(view: view)
        
        sendRequest()
        
    }
    //模拟网络请求
    func sendRequest(){
        
        NSTimer.schedule(delay: 5) { (timer) in
            self.loadingView.dismiss()
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("tableViewCellIentifier")
        
        if cell == nil {
            cell = UITableViewCell.init(style: .Default, reuseIdentifier: "tableViewCellIentifier")
        }
        
        let str = indexPath.row
        
        cell!.textLabel?.text = "这里是\(str)个cell"
        
        return cell!
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
