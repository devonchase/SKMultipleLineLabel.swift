//
//  SKMultipleLineLabel.swift
//  testing
//
//  Created by Devon Chase on 6/10/16.
//  Copyright © 2016 Rude Sheep Studios. All rights reserved.
//

import SpriteKit

class SKMultipleLineLabel: SKNode {
    
    var text : String
    var font : String
    var labels : [SKLabelNode] = []
    var fontSize : CGFloat = 20
    var fontColor : UIColor = UIColor.blackColor()
    var parentNode : SKShapeNode
    
    init(parent : SKShapeNode, text : String="", font: String="Ariel"){
        //wondering if I need to keep. Brought in some of these for ease of modification
        self.text = text
        self.font = font
        self.parentNode = parent
        
        super.init()
        
        self.createMultiLineLabels()
    }
    
    //req init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
        createMultiLineLabels
     */
    
    func createMultiLineLabels(){
        let label = SKLabelNode(fontNamed: font)
        label.text = text
        label.fontSize = 15
        label.fontColor = UIColor.blueColor()
        
        let parWidth = parentNode.frame.width
        if label.frame.width > parWidth {
            var widthOver = parentNode.frame.width - label.frame.width
            
            if widthOver < 0 {
                widthOver = widthOver * -1
            }
            
            var words = label.text?.componentsSeparatedByString(" ")
            var lineWidth = CGFloat(0)

            
            var tempLineList : [String] = []
            var tempLine = ""
                
            for word in words! {
                    
                let text = SKLabelNode(text: word)
                if text.frame.width < parWidth  && lineWidth < parWidth{
//                    tempLineList.append(word)
                    tempLine = "\(tempLine) \(word)"
                    words?.removeFirst()
                    lineWidth = lineWidth + SKLabelNode(text: tempLine as String).frame.width
                } else if lineWidth >= parWidth{
                    //tempLineList.removeLast()
                    tempLineList.append(tempLine)
                    lineWidth = 0
                    tempLine = ""
                    
                    //so the first word in the new line isn't lost
                    if text.frame.width < parWidth  && lineWidth < parWidth{
                        //                    tempLineList.append(word)
                        tempLine = "\(tempLine) \(word)"
                        words?.removeFirst()
                        lineWidth = lineWidth + SKLabelNode(text: tempLine as String).frame.width
                    }
                }
                
            }
   
            for line in tempLineList {
                var counter = 1
                var newLine = SKLabelNode(text: line)
//                newLine.verticalAlignmentMode = .Top
//                newLine.horizontalAlignmentMode = .Left
                
//                newLine.position = CGPointMake(parentNode., parentNode.frame)
                newLine.position = CGPoint(x: 2, y: -2)
                parentNode.addChild(newLine)
                counter += 1
            }
            
        } else {
            
            parentNode.addChild(label)
            
        }
        
        
        
    }
    
}
