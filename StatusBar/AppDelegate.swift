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
        
        statusItem.title = "Future"
        statusItem.menu = StatusMenu
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "getReq", userInfo: nil, repeats: true)
    
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    
    @IBAction func quitClicked(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    
    
    func update(){
        let urlStr:NSString = String(format:"http://localhost/api.php")
        let url:NSURL = NSURL(string: urlStr as String)!
        
        let request:NSURLRequest = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue:NSOperationQueue()) { (res, data, error) in
            
            //服务器返回：请求方式 = GET
            let str = NSString(data: data!, encoding:NSUTF8StringEncoding)
            
            let content = str as? String
            self.statusItem.title = content
        }
    }
    
}

