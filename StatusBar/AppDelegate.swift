//
//  AppDelegate.swift
//  StatusBar
//
//  Created by Andy on 15-11-23.
//  Copyright (c) 2015年 andy. All rights reserved.
//

import Cocoa
import Alamofire

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {    
    
    @IBOutlet weak var StatusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system().statusItem(withLength: -1)
    
    // 加载完成时
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        statusItem.title = "Future"
        statusItem.menu = StatusMenu
        
        var _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(AppDelegate.update), userInfo: nil, repeats: true)
    
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
    
    // self defined
    func update(){
        let date = Date();
        let timeFormatter = DateFormatter();
        
        timeFormatter.dateFormat = "yyy-MM-dd 'at' HH:mm:ss.SSS"
        var _ = timeFormatter.string(from: date) as String
        
        //statusItem.title = getDatetime()
        let data = reqUrl()
        if !data.isEmpty {
            statusItem.title = data     // 更新数据
        }
    }
    
    // 得到当前时间
    func getDatetime() -> String {
        let date = Date();
        let timeFormatter = DateFormatter();
        
        timeFormatter.dateFormat = "yyy-MM-dd 'at' HH:mm:ss.SSS"
        let strNowTime = timeFormatter.string(from: date) as String
        
        return strNowTime
    }
    
//    func requestUrl() -> String{
//        var url = "http://localhost/api.php"
//        var content = NSString(contentsOfURL: NSURL(string: url)!, encoding: NSUTF8StringEncoding, error: nil)
//        
//        return content!
//    }
    
    func reqUrl() -> String {
        let url = "http://localhost/api.php"
        let status = statusItem
        Alamofire.request(url, method: .get).responseString { (response) in
            let result = "\(response.result.value!)";
            status.title = result
        }
        return "";
    }
}

