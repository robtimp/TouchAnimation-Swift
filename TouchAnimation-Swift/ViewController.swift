//
//  ViewController.swift
//  TouchAnimation
//
//  Playing around with Core Graphics, Core Animation and Touch Events by Yari D'areglia
//  www.thinkandbuild.it
//
//  Swift version by Rob Hudson - 5/26/15

import UIKit

class ViewController: UIViewController {
    
    var gradientView: CircleGradient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Generate the gradient view
        gradientView = CircleGradient(frame: CGRect(x: 50, y: 50, width: 200, height: 200))
        self.view.addSubview(gradientView)
        
        // Initialize gesture recognizer
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "screenPan:")
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func screenPan(gesture: UIGestureRecognizer) {
        // Get the location of the touch
        let point = gesture.locationInView(self.view)
        
        // Move the center of the gradient view if the gesture state is equal to Began or Changed
        if gesture.state == .Began || gesture.state == .Changed {
            gradientView.center = point
        }
        
        if gesture.state == .Ended {
            gradientView.fadeOut()
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            let drawPoint = touch.locationInView(self.view)
            
            // Change gradientView center and launch fadeIn animation
            gradientView.center = drawPoint
        }
        
        gradientView.fadeIn()
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        gradientView.fadeOut()
    }
    
}

