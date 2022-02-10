//
//  ViewController.swift
//  Animation
//
//  Created by Евгений Григоренко on 28.01.22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showCircle()
    }
    
    func showCircle(){
        let viewsArray = Circle().drawCircles()
        for oneView in viewsArray {
            oneView.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
            Circle.animate(withDuration: 1, animations: {
                oneView.transform = CGAffineTransform(scaleX: 1, y: 1)
                oneView.alpha = 1
                self.view.addSubview(oneView)
                self.OnClickListener()
            })
        }
        
        
    }
    func OnClickListener(){

        let viewsArray = Circle().drawCircles()
        for subView in view.subviews.filter({$0.alpha > 0}) {
            subView.setOnClickListener {
                
                Circle.animate(withDuration: 1, animations: {
                    viewsArray.forEach { _ in
                        subView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                        subView.alpha = 0
                    }
                }, completion: { (finished: Bool) -> Void in
                    subView.removeFromSuperview()
                    if self.view.subviews.count == 0 {
                        self.reDraw()
                    }
                    
                })
                
            }
        }
    }
    func reDraw() {
        let viewsArray = Circle().drawCircles()
        for oneView in viewsArray {
            oneView.alpha = 0
            oneView.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
            Circle.animate(withDuration: 2, animations: {
                oneView.transform = CGAffineTransform(scaleX: 1, y: 1)
                oneView.alpha = 1
                self.view.addSubview(oneView)
                    self.OnClickListener()
            })
        }
    }
}



extension UIView {
    func setOnClickListener(action :@escaping () -> Void){
        let tapRecogniser = ClickListener(target: self, action: #selector(onViewClicked(sender:)))
        tapRecogniser.onClick = action
        self.addGestureRecognizer(tapRecogniser) 
    }
    
    @objc func onViewClicked(sender: ClickListener) {
        if let onClick = sender.onClick {
            onClick()
        }
    }
    
    func isCrossing(_ view: UIView) -> Bool {
        let firstParams = (midX: Float(self.frame.midX), midY: Float(self.frame.midY), radius: Float(self.frame.width/2))
        let secondParams = (midX: Float(view.frame.midX), midY: Float(view.frame.midY), radius: Float(view.frame.width/2))
        let distance = (firstParams.midX - secondParams.midX, firstParams.midY - secondParams.midY)
        let hypotenuse = sqrtf(powf(distance.0, 2) + powf(distance.1, 2))
        
        return hypotenuse - (firstParams.radius + secondParams.radius) <= 0 ? true : false
    }
}





