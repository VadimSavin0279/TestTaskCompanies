//
//  LoaderView.swift
//  TestTaskCompanies
//
//  Created by 123 on 13.04.2023.
//

import Foundation
import UIKit

@IBDesignable
class LoaderView: UIView {
    var animationIsWorking = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !animationIsWorking {
            addLoader()
        }
    }
    
    func addLoader() {
        let shapeLayer = CAShapeLayer()
        let loader = UIBezierPath(ovalIn: bounds.insetBy(dx: 3, dy: 3))
        shapeLayer.path = loader.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.strokeEnd = 0.4
        shapeLayer.lineCap = .square
        layer.addSublayer(shapeLayer)
        startAnimating()
    }

    func startAnimating() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        rotation.isRemovedOnCompletion = false
        layer.add(rotation, forKey: "rotationAnimation")
        animationIsWorking = true
    }
}
