//
//  ViewController.swift
//  Test Assessment Ideaslab
//
//  Created by USER-MAC-GLIT-007 on 23/01/23.
//

import UIKit

class Canvas: UIView {
    
    override func draw(_ rect: CGRect) {
        // custom drawing
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // here are my lines
        // dummy data
        //        let startPoint = CGPoint(x: 0, y: 0)
        //        let endPoint = CGPoint(x: 100, y: 100)
        //
        //        context.move(to: startPoint)
        //        context.addLine(to: endPoint)
        
        context.setStrokeColor(UIColor.blue.cgColor)
        context.setLineWidth(10)
        context.setLineCap(.butt)
        
        lines.forEach { (line) in
            for (i, p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        
        context.strokePath()
        
    }
    
    // let's ditch this line
    //    var line = [CGPoint]()
    
    var lines = [[CGPoint]]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    // track the finger as we move across screen
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        //        print(point)
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.append(point)
        lines.append(lastLine)
        
        //        var lastLine = lines.last
        //        lastLine?.append(point)
        
        //        line.append(point)
        
        setNeedsDisplay()
    }
    
}

class ViewController: UIViewController {
    
    
    //MARK: this is for create lines
    //    let canvas = Canvas()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        view.addSubview(canvas)
        //        canvas.backgroundColor = .white
        //        canvas.frame = view.frame
        
        //MARK: this is for double tap to create a line
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGestureRecognizer.numberOfTouchesRequired = 2
        view.addGestureRecognizer(doubleTapGestureRecognizer)
    }
    
    @objc func handleDoubleTap(sender: UITapGestureRecognizer) {
        // Get the location of the two fingers
        let finger1 = sender.location(ofTouch: 0, in: view)
        let finger2 = sender.location(ofTouch: 1, in: view)
        
        // Connect the two fingers with a line
        let path = UIBezierPath()
        path.move(to: finger1)
        path.addLine(to: finger2)
        
        // Draw the line on the screen
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 3
        view.layer.addSublayer(shapeLayer)
    }
}

