//
//  AppDelegate.swift
//  CopyHistory
//
//  Created by Wang,Wei(ACG-T102) on 2019/8/4.
//  Copyright © 2019 Wang,Wei(ACG-T102). All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var StatusMenu: NSMenu!
    
     let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        //statusItem.button?.image = NSImage(named: NSImage.Name(rawValue:"ddd"))
        statusItem.button?.title = "copy"
        statusItem.menu = StatusMenu

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApp.terminate(self)
    }
}

