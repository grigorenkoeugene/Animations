//
//  Circle.swift
//  Animation
//
//  Created by Евгений Григоренко on 3.02.22.
//

import UIKit

class Circle {
    func drawCircles() -> [UIView] {
        var number = 1
        var viewsArray: [UIView] = []
        
        let viewHeight = UIScreen.main.bounds.size.height
        let viewWidth = UIScreen.main.bounds.size.width
        while number <= 50 {
            let color: UIColor = .random
            
            let maxRadius: CGFloat = 80
            let rectSideSize = CGFloat.random(in: 15...maxRadius)
            
            let randomNumberOne = CGFloat.random(in: 0...viewWidth-maxRadius)
            let randomNumberTwo = CGFloat.random(in: 0...viewHeight-maxRadius)
            
            let rect = CGRect(x: randomNumberOne , y: randomNumberTwo , width: rectSideSize, height: rectSideSize)
            
            let newView = UIView(frame: rect)
            guard (viewsArray.filter { $0.isCrossing(newView) }).isEmpty else { continue }
                        
            newView.layer.cornerRadius = newView.frame.height/2
            newView.layer.masksToBounds = true
            newView.backgroundColor = color
            
            viewsArray.append(newView)
            number += 1
        }
        
        return viewsArray
        
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
