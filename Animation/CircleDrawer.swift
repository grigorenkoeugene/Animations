//
//  Circle.swift
//  Animation
//
//  Created by Евгений Григоренко on 3.02.22.
//

import UIKit

class Circle: UIView {
    func drawCircles() -> [Circle] {
        var number = 1
        var viewsArray: [Circle] = []
        
        let viewHeight = UIScreen.main.bounds.size.height
        let viewWidth = UIScreen.main.bounds.size.width
        while number <= 5
        {
            let color: UIColor = .random
            
            let maxRadius: CGFloat = 80
            let minRadius: CGFloat = 15
            let rectSideSize = CGFloat.random(in: minRadius...maxRadius)
            
            let randomX = CGFloat.random(in: 0...viewWidth-maxRadius)
            let randomY = CGFloat.random(in: 0...viewHeight-maxRadius)
            
            let rect = CGRect(x: randomX , y: randomY , width: rectSideSize, height: rectSideSize)
            
            let newView = Circle(frame: rect)
            guard viewsArray.first(where: { $0.isCrossing(newView) }) == nil  else { continue }
            newView.layer.cornerRadius = newView.frame.height/2
            newView.layer.masksToBounds = true
            newView.backgroundColor = color


            newView.alpha = 0

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
