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
            view.addSubview(oneView)
        }
        let countCircle = view.subviews.count
        
        for subView in view.subviews.filter({$0.alpha > 0}) {
            subView.setOnClickListener {
                UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.allowUserInteraction], animations: {
                    viewsArray.forEach { _ in
                        subView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                        subView.alpha = 0
                    }
                    
                    if self.view.subviews.filter({$0.alpha == 0}).count == countCircle {
                        self.reDraw()
                    }
                })
            }
        }
    }
    
    func reDraw() {
        for item in self.view.subviews {
            UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.calculationModeCubic], animations: {
                self.view.subviews.forEach { _ in
                        item.transform = CGAffineTransform(scaleX: 1, y: 1)
                    item.alpha = 1
                    
                }
                
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





