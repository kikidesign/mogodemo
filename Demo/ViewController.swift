//
//  ViewController.swift
//  Demo
//
//  Created by leo on 2016/12/7.
//  Copyright © 2016年 leo. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    var items  = ["A","B","C","D","E"]
    
    var itemsColor = [UIColor(red: 0.91, green: 0.84, blue: 0.75, alpha: 1),
                      UIColor(red: 0.96, green: 0.74, blue: 0.36, alpha: 1),
                      UIColor(red: 0.71, green: 0.59, blue: 0.44, alpha: 1),
                      UIColor(red: 0.29, green: 0.48, blue: 0.71, alpha: 1),
                      UIColor(red: 0.18, green: 0.16, blue: 0.18, alpha: 1)
                      ]
    
    var urlArr = [
                  "http://v.juhe.cn/weixin/query?key=00a45b7be43fd6e66d7a190a7eb30ee5",
                  "http://japi.juhe.cn/calendar/day?date=2016-12-8&key=a9720f2c1b2ef8907cc7c510a915e55a",
                  "http://apis.juhe.cn/ip/ip2addr?ip=www.juhe.cn&key=acc892c63e16cd77f3f75f21d24ad774",
                  "http://v.juhe.cn/toutiao/index?type=top&key=%202450c9c901ab95e8cab6e5dcb6c1f089",
                  "http://v.juhe.cn/toutiao/index?type=top&key= 2450c9c901ab95e8cab6e5dcb6c9"
    ]
    
    //获取屏幕大小
    let height:CGFloat = UIScreen.main.bounds.size.height;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func loadView() {
        super.loadView()
        self.initTV()
    }
    
    func initTV(){
        let tv:UITableView = UITableView ()
        tv.separatorStyle = UITableViewCellSeparatorStyle.none
        tv.separatorInset = UIEdgeInsets.zero
        tv.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tv.dataSource = self
        tv.delegate = self
        self.view.addSubview(tv)
    }
    
    //prama marks
    //uitableView delegate and dataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.items.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        cell.textLabel!.text = items[indexPath.row]
        cell.backgroundColor = itemsColor[indexPath.row]
        cell.textLabel!.textColor = UIColor.white
        cell.detailTextLabel?.text = "加载中..."
        cell.detailTextLabel?.textColor = UIColor.white
        
        let url:URLConvertible = urlArr[indexPath.row]
        
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if( response.result.value != nil  ){
                let JSON = response.result.value
                print("JSON: \(JSON)")
                cell.detailTextLabel?.text = "加载完成!!"
            }else{
                cell.detailTextLabel?.text = "加载失败"
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return false
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete){
            
            self.items .remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        return UITableViewCellEditingStyle.delete
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let heightRow = Int(height)/self.items.count+1;
        
        return CGFloat(heightRow)
        
        
    }
    
}
