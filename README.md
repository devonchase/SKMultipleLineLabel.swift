# SKMultipleLineLabel.swift
A take on Craigg Grummitt's fantastic work. https://gist.github.com/craiggrummitt/03bfa93c07e247ee9358

This is not completed yet. I have to do code clean up as well as proper positioning of the labels that are generated.

To use: create a SKShapeNode and pass that as the parent into a SKMultipleLineLabel

        let par = SKShapeNode(rectOfSize: CGSizeMake(200, 200))
        par.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        
        let label = SKMultipleLineLabel(parent: par, text: "Hello you person")
