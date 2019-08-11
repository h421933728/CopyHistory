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

    @IBOutlet weak var statusMenu: NSMenu!

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    let clipboard = Clipboard()
    var copyStringMap = [NSMenuItem: String]()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        //statusItem.button?.image = NSImage(named: NSImage.Name(rawValue:"ddd"))
        statusItem.button?.title = "copy"
        statusItem.menu = statusMenu

        clipboard.startListening()
        clipboard.onNewCopy { (content) in
            print(content)
            self.handleCopyEvent(content: content)
        }

    }

    func handleCopyEvent(content:String) {
        for (item, value) in copyStringMap {
            NSLog("%@ %@", item, value)
            if content == value {
                self.statusMenu.removeItem(item)
                self.statusMenu.insertItem(item, at: 0)
                return
            }
        }

        if self.statusMenu.items.count > 15 {
            let remove_item = self.statusMenu.item(at: self.statusMenu.items.count - 2)
            self.statusMenu.removeItem(remove_item!)
            self.copyStringMap.removeValue(forKey: remove_item!)
        }

        let item = NSMenuItem(title: content, action: #selector(AppDelegate.menuItemClick(_:)), keyEquivalent: "")
        self.statusMenu.insertItem(item, at: 0)
        self.copyStringMap[item] = content
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApp.terminate(self)
    }

    @IBAction func menuItemClick(_ sender: NSMenuItem) {
        let item = sender
        let str = self.copyStringMap[item]!
        if str.isEmpty == false {
            NSLog("copy txt:%@", str)
            self.clipboard.copy(str)
        }
    }
}

