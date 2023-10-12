//
//  Road.swift
//  Road Slam Z
//
//  Created by Admin on 4.10.23.
//

import Foundation
import UIKit

class Road {
    
    public var speed: Double
    public let parent: GameViewController
    public let car: Car
    
    public var score = 0
    public let startDelay = 3.0
    
    public var timerFuel: Timer?
    public var timerSpawning: Timer?
    public var timerScore: Timer?
    
    public lazy var maxX = parent.view.frame.maxX
    public lazy var maxY = parent.view.frame.maxY
    private var animator: UIViewPropertyAnimator?
    public var timersArr = [Timer]()
    public var walkersArr = [Walker]()
    
    private let roadBackgroundFirst: UIImageView = {
        let bg = UIImageView(image: UIImage(named: "road"))
        return bg
    }()
    
    private let roadBackgroundSecond: UIImageView = {
        let bg = UIImageView(image: UIImage(named: "road"))
        return bg
    }()
    
    public let labelScore: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .systemRed
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 24)
        return lbl
    }()
    
    public let labelUserName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .systemRed
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .center
        lbl.text = Settings.showUserName == false ? "" : Settings.userName
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    
    init(speed: Double, parent: GameViewController, car: Car) {
        self.speed = speed
        self.parent = parent
        self.car = car
    }
    
    public func startRoad() {
        parent.view.insertSubview(roadBackgroundFirst, at: 1)
        parent.view.insertSubview(roadBackgroundSecond, at: 1)
        
        roadBackgroundFirst.frame = CGRect(x: 0, y: 0, width: maxX, height: maxY)
        roadBackgroundSecond.frame = CGRect(x: 0, y: -maxY, width: maxX, height: maxY)
        
        car.view.center = CGPoint(x: parent.view.center.x, y: maxY + 100)
        UIView.animate(withDuration: startDelay, animations: { [self] in
            car.view.frame.origin.y -= car.height + 100
        })
        
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: speed, delay: startDelay, options: [.repeat, .curveLinear], animations: { [self] in
            UIView.setAnimationRepeatCount(.infinity)
            roadBackgroundFirst.frame = CGRect(x: 0, y: maxY, width: maxX, height: maxY)
            roadBackgroundSecond.frame = CGRect(x: 0, y: 0, width: maxX, height: maxY)
        })
        animator?.startAnimation()
        
        addCar()
    }
    
    public func restart() {
        MusicPlayer.shared.startBackgroundMusic()
        
        roadBackgroundFirst.frame = CGRect(x: 0, y: 0, width: maxX, height: maxY)
        roadBackgroundSecond.frame = CGRect(x: 0, y: -maxY, width: maxX, height: maxY)
        
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: speed, delay: 0, options: [.repeat, .curveLinear], animations: { [self] in
            UIView.setAnimationRepeatCount(.infinity)
            roadBackgroundFirst.frame = CGRect(x: 0, y: maxY, width: maxX, height: maxY)
            roadBackgroundSecond.frame = CGRect(x: 0, y: 0, width: maxX, height: maxY)
        })
        animator?.startAnimation()
        
        car.view.center = CGPoint(x: parent.view.center.x, y: maxY - car.height)
        addGesturesForCar()
        
        score = 0
        car.fuel.progress = 1.0
        car.health.progress = 1.0
        addStatusBarsForCar()
        
        startSpawning()
    }
    
    public func stopRoad() {
        animator?.stopAnimation(true)
        parent.view.gestureRecognizers?.removeAll()
        timerFuel?.invalidate()
        timerSpawning?.invalidate()
        timerScore?.invalidate()
        
        for walker in walkersArr {
            walker.view.removeFromSuperview()
        }
        
        walkersArr.removeAll()
        
        for timer in timersArr {
            timer.invalidate()
        }
    }
    
    private func addCar() {
        car.view.center = CGPoint(x: parent.view.center.x, y: maxY - car.height)
        parent.view.insertSubview(car.view, at: 3)
        RunLoop.main.add(Timer(timeInterval: startDelay, repeats: false, block: { [self] _ in
            addStatusBarsForCar()
            addGesturesForCar()
        }), forMode: .default)
    }
    
    private func addGesturesForCar() {
        parent.view.isUserInteractionEnabled = true
        let gestureSwipeRight = UISwipeGestureRecognizer(target: parent, action: #selector(GameViewController.swipe))
        let gestureSwipeLeft = UISwipeGestureRecognizer(target: parent, action: #selector(GameViewController.swipe))
        
        gestureSwipeRight.direction = .right
        gestureSwipeLeft.direction = .left
        
        parent.view.addGestureRecognizer(gestureSwipeRight)
        parent.view.addGestureRecognizer(gestureSwipeLeft)
    }
    
    private func addStatusBarsForCar() {
        parent.view.insertSubview(car.health, at: 5)
        parent.view.insertSubview(car.fuel, at: 5)
        parent.view.insertSubview(labelScore, at: 5)
        parent.view.insertSubview(labelUserName, at: 5)
        
        labelScore.text = "Score: \(score)"
        
        car.health.snp.makeConstraints{
            $0.top.equalTo(60)
            $0.left.equalTo(30)
            $0.right.equalTo(-30)
        }
        
        car.fuel.snp.makeConstraints{
            $0.top.equalTo(car.health).offset(30)
            $0.left.equalTo(30)
            $0.right.equalTo(-30)
        }
        
        timerFuel = Timer(timeInterval: 0.2, repeats: true){ [self] timer in
            guard car.fuel.progress <= 0 else {
                car.fuel.progress -= 0.008
                return
            }
            parent.showAlert(alertTitle: "LOSE", alertMessage: "Out of fuel... You have scored: \(score) and earned \(Double(score) / 10.0)💸")
            stopRoad()
            MusicPlayer.shared.startLoseSound()
            MusicPlayer.shared.stopBackgroundMusic()
            timer.invalidate()
        }
        RunLoop.main.add(timerFuel ?? Timer(), forMode: .default)
        
        labelScore.snp.makeConstraints{
            $0.top.equalTo(car.fuel).offset(30)
            $0.left.equalTo(30)
            $0.right.equalTo(-30)
        }
        
        labelUserName.snp.makeConstraints{
            $0.top.equalTo(labelScore).offset(32)
            $0.left.equalTo(30)
            $0.right.equalTo(-30)
        }

        timerScore = Timer(timeInterval: parent.difficulty, repeats: true){ [self] timer in
            score += 1
            labelScore.text = "Score: \(score)"
        }
        RunLoop.main.add(timerScore ?? Timer(), forMode: .default)
    }
    
    public func startSpawning() {
        timerSpawning = Timer(timeInterval: parent.difficulty, repeats: true) { [self] timer in
            guard Int.random(in: 0...6) > 2 else { return }
            addWalker(walker: Walker(isRev: (Int.random(in: 0...1) != 0), road: self))
        }
        RunLoop.main.add(timerSpawning ?? Timer(), forMode: .default)
    }
    
    public func addWalker(walker: Walker) {
        walkersArr.append(walker)
        let startPosWalker = Int.random(in: Int(walker.positionBorder)...Int(walker.maxX / 2))
        let startPosWalkerRev = Int.random(in: Int(walker.maxX / 2)...Int(walker.maxX - walker.positionBorder))
        let startPos = walker.isRev ? startPosWalkerRev : startPosWalker
        let moveBy = walker.isRev ? -50.0 : 50.0
        
        walker.view.frame.size = CGSize(width: walker.walkerSize, height: walker.walkerSize * 1.16)
        walker.view.center = CGPoint(x: startPos, y: -Int(walker.walkerSize) / 2)
        parent.view.insertSubview(walker.view, at: 2)
        
        var progress = 0.0
        let timerInterval = 0.03
        var directionChanged = false
        let timer = Timer(timeInterval: timerInterval, repeats: true, block: { [self] timer in
            progress += timerInterval
            guard progress > speed else {
                walker.view.frame.origin.y += (walker.maxY) * timerInterval / speed
                guard progress > speed / 2 else {
                    walker.view.frame.origin.x += moveBy * timerInterval / speed
                    guard !walker.checkCarHit(walker: walker, car: car) else {
                        timer.invalidate()
                        timersArr.removeAll(where: { timer in
                            !timer.isValid
                        })
                        return
                    }
                    return
                }
                if !directionChanged { walker.view.image = walker.isRev ? walker.walkerGif : walker.walkerGifRev }
                directionChanged = true
                walker.view.frame.origin.x -= moveBy * timerInterval / speed
                if walker.checkCarHit(walker: walker, car: car) { 
                    timer.invalidate()
                    timersArr.removeAll(where: { timer in
                        !timer.isValid
                    })
                }
                return
            }
            walker.view.removeFromSuperview()
            timer.invalidate()
            timersArr.removeAll(where: { timer in
                !timer.isValid
            })
        })
        timersArr.append(timer)
        RunLoop.main.add(timer, forMode: .common)
    }
}
