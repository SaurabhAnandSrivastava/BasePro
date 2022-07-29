//
//  LineView.swift
//  fsNew
//
//  Created by Saurabh Srivastav on 19/01/22.
//

import UIKit

class LineView: UIView {

    public override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
            let lineWidth: CGFloat = rect.size.height
            context.setLineWidth(lineWidth)
        context.setStrokeColor(UIColor.red.cgColor)
            let startingPoint = CGPoint(x: 0, y: rect.size.height - lineWidth)
            let endingPoint = CGPoint(x: rect.size.width, y: rect.size.height - lineWidth)
            context.move(to: startingPoint )
            context.addLine(to: endingPoint )
            context.strokePath()
    }

}
