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
                
                //This if statement generates the line
                if text.frame.width < parWidth  && lineWidth < parWidth{
                    tempLine = "\(tempLine) \(word)"
                    words?.removeFirst()
                    lineWidth = lineWidth + SKLabelNode(text: tempLine as String).frame.width
                    
                    //only call this on the last line since most likely it will fall in this if
                    if words!.count == 0{
                        tempLineList.append(tempLine)
                    }
                    
                } else if lineWidth >= parWidth{
                    //this else if adds the line to the tempLineList
                    //and resets values
                    tempLineList.append(tempLine)
                    lineWidth = 0
                    tempLine = ""
                    //so the first word in the new line isn't lost
                    //only should run once
                    if text.frame.width < parWidth  && lineWidth < parWidth{
                        tempLine = "\(tempLine) \(word)"
                        words?.removeFirst()
                        lineWidth = lineWidth + SKLabelNode(text: tempLine as String).frame.width
                    }
                }
                
            }
            
            var counter  = 0
            
            for line in tempLineList {
                
                let newLine = SKLabelNode(text: line)
//                newLine.verticalAlignmentMode = .Top
//                newLine.horizontalAlignmentMode = .Left
//                newLine.position = CGPointMake(parentNode., parentNode.frame)
                label.horizontalAlignmentMode = .Left
                label.verticalAlignmentMode = .Top
                
                //newLine.position = CGPointMake(parentNode.frame.width / 5 - 50, (parentNode.frame.height * 0.46) * -counter)
                if counter == 0 {
                    newLine.position = CGPoint(x: parentNode.frame.size.width / 5 - 50, y: (parentNode.frame.size.height * 0.30))
                } else {
                    newLine.position = CGPoint(x: parentNode.frame.size.width / 5 - 50, y: (labels[counter - 1].position.y - newLine.frame.size.height))
                }
                
                
                parentNode.addChild(newLine)
                counter = counter + 1
                labels.append(newLine)
            }
            
        } else {
            label.position = CGPointMake(parentNode.frame.width * -0.46, parentNode.frame.height * 0.46)
            parentNode.addChild(label)
            
        }
        
        
        
    }
    
}
