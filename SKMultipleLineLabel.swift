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
    var parentNode : SKNode
    
    init(parent : SKNode, text : String="", font: String="Ariel"){
        //wondering if I need to keep. Brought in some of these for ease of modification
        self.text = text
        self.font = font
        self.parentNode = parent
        
        super.init()
        
        self.createMultiLineLabels()
        self.displayLabels()
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
        
        let parWidth = parentNode.frame.size.width
        if label.frame.width > parWidth {
            var widthOver = parentNode.frame.size.width - label.frame.size.width
            
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
                    lineWidth = lineWidth + SKLabelNode(text: tempLine as String).frame.size.width
                    
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
            
            for line in tempLineList {
                
                let newLine = SKLabelNode(text: line)

                labels.append(newLine)
            }
            
        } else {
            label.position = CGPointMake(parentNode.frame.size.width * -0.46, parentNode.frame.size.height * 0.46)
            labels.append(label)
            
        }
    }
    
    func displayLabels(){
        
        var counter = 0
        for label in labels {
            label.horizontalAlignmentMode = .Left
            label.verticalAlignmentMode = .Top
            label.fontSize = 30
            label.fontColor = UIColor.blackColor()
            label.zPosition = 2
            
            if counter == 0 {
                label.position = CGPoint(x: CGRectGetMinX(parentNode.frame) + 10, y: (parentNode.frame.size.height / -2  - 20))
            } else {
                label.position = CGPoint(x: CGRectGetMinX(parentNode.frame) + 10, y: (labels[counter - 1].position.y - label.frame.size.height))
            }
            
            parentNode.addChild(label)
            counter += 1
        }
        
        
    }
    
}
