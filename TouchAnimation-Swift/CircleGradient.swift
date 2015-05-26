//
//  CircleGradient.swift
//  TouchAnimation
//
//  Playing around with Core Graphics, Core Animation and Touch Events by Yari D'areglia
//  www.thinkandbuild.it
//
//  Swift version by Rob Hudson - 5/26/15

import UIKit

class CircleGradient: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.contents = self.generateRadial().CGImage
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func generateRadial() -> UIImage {
        // Define the gradient
        var colorSpace: CGColorSpaceRef
        var gradient: CGGradientRef
        
        let locations: [CGFloat] = [0.0, 0.4, 0.5, 0.6, 1.0]
        let components: [CGFloat] = [   1.0, 0.0, 0.0, 0.2,
                                        1.0, 0.0, 0.0, 1.0,
                                        1.0, 0.0, 0.0, 0.8,
                                        1.0, 0.0, 0.0, 0.4,
                                        1.0, 0.0, 0.0, 0.0]
        
        colorSpace = CGColorSpaceCreateDeviceRGB()
        gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, locations.count)
        
        // Define gradient positions
        
        // We want these exactly at the center of the view
        
        // Start point
        let startPoint = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        
        // End point
        let endPoint = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        
        // Generate the image
        // Begin an image context
        UIGraphicsBeginImageContext(self.frame.size)
        let imageContext = UIGraphicsGetCurrentContext()
        
        // Use CG to draw the radial gradient into the image context
        CGContextDrawRadialGradient(imageContext, gradient, startPoint, 0, endPoint, self.frame.size.width / 2, 0)
        
        // Get the image from the context
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result
    }
    
    func fadeIn() {
        // Define the property through a Key
        let fadein = CABasicAnimation(keyPath: "opacity")
        
        // Initial and the final values
        fadein.fromValue = NSNumber(int: 0)
        fadein.toValue = NSNumber(int: 1)
        
        // Duration of the animation
        fadein.duration = 0.3
        
        // Attach the animation to the layer for a custom key... let's call it "fade"
        self.layer.addAnimation(fadein, forKey: "fade")
    }
    
    func fadeOut() {
        // Create the Fadeout animation, and assign it to the layer
        let fadeout = CABasicAnimation(keyPath: "opacity")
        fadeout.delegate = self
        fadeout.fromValue = NSNumber(int: 1)
        fadeout.toValue = NSNumber(int: 0)
        fadeout.duration = 0.2
        fadeout.fillMode = kCAFillModeForwards
        fadeout.removedOnCompletion = false
        
        self.layer.addAnimation(fadeout, forKey: "fade")
    }

}
