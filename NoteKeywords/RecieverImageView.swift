//
//  RecieverImageView.swift
//  NoteKeywords
//
//  Created by zhangyingjie on 2018/7/16.
//  Copyright © 2018年 zhangyingjie. All rights reserved.
//

import Cocoa

class RecieverImageView: NSImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initReciever()
        
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        initReciever()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    
    
    func initReciever() -> Void {
        self.registerForDraggedTypes([NSPasteboard.PasteboardType.fileURL])
        self.wantsLayer = true
        self.layer?.cornerRadius = 35
        self.layer?.borderWidth = 5
        self.layer?.borderColor = NSColor.red.cgColor
        self.layer?.masksToBounds = true

    }
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let sourceDragMask = sender.draggingSourceOperationMask()
        let pb = sender.draggingPasteboard()
        let dragTypes = pb.types! as NSArray
        if dragTypes.contains(NSPasteboard.PasteboardType.fileURL) {
            if sourceDragMask.contains([.copy]) {
                return .copy
            }
            if sourceDragMask.contains([.link]) {
                return .link
            }

        }
        return .generic
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        
        let pboard = sender.draggingPasteboard()
        let dragTypes = pboard.types! as NSArray
        if dragTypes.contains(NSPasteboard.PasteboardType.fileURL) {
            
            
            
            let fileBefore = pboard.propertyList(forType: NSPasteboard.PasteboardType.fileURL) as! NSString
            
            let file = fileBefore as String
            
            let fileURL = NSURL.fileURL(withPath: file)
            let fileContent = NSURL.init(fileURLWithPath: file)
            
            do {
                let fileContent = try NSString.init(contentsOfFile: file, encoding: String.Encoding.utf8.rawValue)
                NSLog("%@",fileContent)
            } catch {
                NSLog("111")
            }
            NSLog("333")
            
            
            
        }
        return true
        
        
    }
    
}
