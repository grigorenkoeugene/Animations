//
//  ClickListener.swift
//  Animation
//
//  Created by Евгений Григоренко on 3.02.22.
//

import UIKit

class ClickListener: UITapGestureRecognizer {
    var onClick : (() -> Void)? = nil
}
