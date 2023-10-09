//
//  Car.swift
//  Road Slam Z
//
//  Created by Admin on 5.10.23.
//

import Foundation
import UIKit

class Car {
    
    public let height = 120.0
    private let maxX: Double
    private let maxY: Double
    private let damageToCar = 0.1
    
    public let fuel: UIProgressView = {
        let prgressView = UIProgressView()
        prgressView.progress = 1.0
        prgressView.progressTintColor = .black
        prgressView.trackTintColor = .none
        prgressView.layer.cornerRadius = 5
        return prgressView
    }()
    
    public let health: UIProgressView = {
        let prgressView = UIProgressView()
        prgressView.progress = 1.0
        prgressView.progressTintColor = .red
        prgressView.trackTintColor = .none
        prgressView.layer.cornerRadius = 5
        return prgressView
    }()
    
    public let view: UIImageView = {
        let bg = UIImageView(image: UIImage(named: "police"))
        bg.frame.size = CGSize(width: 70, height: 120)
        return bg
    }()
    
    init(maxX: Double, maxY: Double) {
        self.maxX = maxX
        self.maxY = maxY
    }
    
    public func carSwipe(_ gesture : UISwipeGestureRecognizer) {
        let duration = 0.5
        let moveBy = maxX / 4 - 5
        let objectPosition = self.view.center.x
        let timerInterval = 0.03
        var progress = 0.0
        let timer = Timer(timeInterval: timerInterval, repeats: true, block: { [self] timer in
            progress += timerInterval
            guard progress > duration else {
                switch gesture.direction {
                case .right:
                    guard objectPosition < maxX - 150 else { return }
                    view.center.x += (moveBy) * timerInterval / duration
                case .left:
                    guard objectPosition > 150 else { return }
                    view.center.x -= (moveBy) * timerInterval / duration
                default:
                    break
                }
                return
            }
            timer.invalidate()
        })
        RunLoop.main.add(timer, forMode: .common)
    }
    
    public func damageCar() {
        health.progress -= Float(damageToCar)
    }
}
