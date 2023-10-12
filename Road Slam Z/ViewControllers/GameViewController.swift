//
//  ViewController.swift
//  Road Slam Z
//
//  Created by Admin on 2.10.23.
//

import UIKit
import SnapKit

class GameViewController: UIViewController {
    
    private var timer: Timer?
    private let roadAnimationDuration = Settings.gameSpeed == 0.0 ? {Settings.gameSpeed = 3.0; return 3.0}() : Settings.gameSpeed ?? 3.0
    private lazy var road = Road(speed: roadAnimationDuration, parent: self, car: Car(maxX: self.view.frame.maxX, maxY: self.view.frame.maxY))
    public let difficulty = Settings.difficulty == 0.0 ? {Settings.difficulty = 0.5; return 0.5}() : Settings.difficulty ?? 0.5
    private var flag = true
    private let menuViewController = MenuViewController()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        start()
    }
    
    public func start() {
        road.startRoad()
        RunLoop.main.add(Timer(timeInterval: road.startDelay, repeats: false, block: { [self] _ in
            road.startSpawning()
        }), forMode: .default)
    }
    
    @objc public func swipe(_ gesture: UISwipeGestureRecognizer) {
        road.car.carSwipe(gesture)
    }
    
    public func showAlert(alertTitle title: String, alertMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { [self] _ in
            road.restart()
        }))
        alert.addAction(UIAlertAction(title: "Menu", style: .default, handler: { [self] _ in
            MusicPlayer.shared.startBackgroundMusic()
            dismiss(animated: true)
        }))
        self.present(alert, animated: true)
    }
}
