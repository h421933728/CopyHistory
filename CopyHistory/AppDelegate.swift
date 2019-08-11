//
//  AppDelegate.swift
//  CopyHistory
//
//  Created by Wang,Wei(ACG-T102) on 2019/8/4.
//  Copyright © 2019 Wang,Wei(ACG-T102). All rights reserved.
//

import Cocoa
import HotKey

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var statusMenu: NSMenu!

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    let clipboard = Clipboard()
    var copyStringMap = [NSMenuItem: String]()

    let hotKey = HotKey(key: .c, modifiers: [.command])


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

        hotKey.keyDownHandler = {
            print("dddd")
        }

    }

    @IBAction func statusItemAction(_ sender: AnyObject) {
       // NSRunningApplication.current.activate(options: NSApplication.ActivationOptions.activateIgnoringOtherApps)
       // let window = NSApp.windows[0]
       // window.orderFront(self)

         // NSApp.activate(ignoringOtherApps: true)
        // NSApp.activate(ignoringOtherApps: true)
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
        let new_content = content.trimmingCharacters(in: .whitespaces)
        let subStringTo18 = String(new_content.prefix(18))

        let item = NSMenuItem(title: subStringTo18, action: #selector(AppDelegate.menuItemClick(_:)), keyEquivalent: "")
        self.statusMenu.insertItem(item, at: 0)

        self.copyStringMap[item] = content

        var index = 0
        for item in self.statusMenu.items {
            if index >= 10 || index >= (self.statusMenu.items.count - 1) {
                break
            }
            //NSLog("len:%d", self.statusMenu.items.count)
            item.keyEquivalent = String(index)
            index = index + 1
        }
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

    @IBAction func PreferencesClicked(_ sender: NSMenuItem) {
    }

}

