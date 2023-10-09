//
//  Zombie.swift
//  Road Slam Z
//
//  Created by Admin on 4.10.23.
//

import Foundation
import UIKit

class Walker {
    
    public lazy var maxX = road.maxX
    public lazy var maxY = road.maxY
    public let positionBorder = 45.0
    public let walkerSize = 35.0
    public let walkerGif = UIImage.gifImageWithName("walking-dead")
    public let walkerGifRev = UIImage.gifImageWithName("walking-dead")?.withHorizontallyFlippedOrientation()
    
    public let isRev: Bool
    public let view: UIImageView
    private let road: Road
    
    init(isRev: Bool, road: Road) {
        self.isRev = isRev
        self.view = isRev ? UIImageView(image: walkerGifRev) : UIImageView(image: walkerGif)
        self.road = road
    }

    public func checkCarHit(walker: Walker, car: Car) -> Bool {
        guard !walker.view.frame.intersects(car.view.frame) else {
            car.damageCar()
            walker.view.image = UIImage(named: "blood")
            road.score += 50
            road.labelScore.text = "Score: \(road.score)"
            MusicPlayer.shared.startDeadSound()
            if car.health.progress <= 0 {
                road.parent.showAlert(alertTitle: "LOSE", alertMessage: "Car crash... You have scored: \(road.score) and earned \(Double(road.score) / 10.0)💸")
                MusicPlayer.shared.startLoseSound()
                MusicPlayer.shared.stopBackgroundMusic()
                road.stopRoad()
                
            }
            else {
                UIView.animate(withDuration: road.speed / 2, delay: 0, animations: {
                    walker.view.frame.origin.y = (self.maxY)
                }, completion: { _ in
                    walker.view.removeFromSuperview()
                })
            }
            return true
        }
        return false
    }
}
