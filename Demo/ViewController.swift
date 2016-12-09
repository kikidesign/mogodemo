//
//  ViewController.swift
//  Demo
//
//  Created by leo on 2016/12/7.
//  Copyright © 2016年 leo. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    var items  = ["A","B","C","D","E"]
    
    var itemsColor = [UIColor(red: 0.91, green: 0.84, blue: 0.75, alpha: 1),
                      UIColor(red: 0.96, green: 0.74, blue: 0.36, alpha: 1),
                      UIColor(red: 0.71, green: 0.59, blue: 0.44, alpha: 1),
                      UIColor(red: 0.29, green: 0.48, blue: 0.71, alpha: 1),
                      UIColor(red: 0.18, green: 0.16, blue: 0.18, alpha: 1)
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath as IndexPath)
        cell.textLabel!.text = items[indexPath.row]
        cell.backgroundColor = itemsColor[indexPath.row]
        cell.textLabel!.textColor = UIColor.white
        
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
