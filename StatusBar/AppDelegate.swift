//
//  AppDelegate.swift
//  StatusBar
//
//  Created by Andy on 15-11-23.
//  Copyright (c) 2015年 andy. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {    
    
    @IBOutlet weak var StatusMenu: NSMenu!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    
    
    // 加载完成时
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        statusItem.title = "Future"
        statusItem.menu = StatusMenu
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
    
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    
    @IBAction func quitClicked(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    
    // self defined
    func update(){
        var date = NSDate();
        var timeFormatter = NSDateFormatter();
        
        timeFormatter.dateFormat = "yyy-MM-dd 'at' HH:mm:ss.SSS"
        var strNowTime = timeFormatter.stringFromDate(date) as String
        
        //statusItem.title = getDatetime()
        var data = requestUrl()
        if !data.isEmpty {
            statusItem.title = data     // 更新数据
        }
    }
    
    // 得到当前时间
    func getDatetime() -> String {
        var date = NSDate();
        var timeFormatter = NSDateFormatter();
        
        timeFormatter.dateFormat = "yyy-MM-dd 'at' HH:mm:ss.SSS"
        var strNowTime = timeFormatter.stringFromDate(date) as String
        
        return strNowTime
    }
    
    func requestUrl() -> String{
        var url = "http://localhost/api.php?p=future"
        var content = NSString(contentsOfURL: NSURL(string: url)!, encoding: NSUTF8StringEncoding, error: nil)
        
        return content!
    }
    
}

