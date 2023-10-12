//
//  MenuViewController.swift
//  Road Slam Z
//
//  Created by Admin on 5.10.23.
//

import UIKit

class MenuViewController: UIViewController {
    
    private let background = UIImageView(image: UIImage(named: "menu"))
    
    private let walker = UIImageView(image: UIImage(named: "walker"))
    
    private let walkerAppearDuration = 2.0
    
    private let buttonView: UIView = {
        let btn = UIView()
        btn.frame = CGRect(x: 129, y: 292, width: 134, height: 50)
        return btn
    }()
    
    private let buttonPlay: UIButton = {
        let btn = UIButton()
        btn.setTitle("PLAY ▸", for: .normal)
        btn.titleLabel?.textColor = .black
        btn.titleLabel?.font = UIFont.init(name: "Zombie-Noize", size: 30)
        btn.titleLabel?.textColor = .black
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 20
        btn.backgroundColor = .systemGray
        return btn
    }()
    
    private let buttonGarage: UIButton = {
        let btn = UIButton()
        btn.setTitle("Garage 🔧", for: .normal)
        btn.titleLabel?.textColor = .black
        btn.titleLabel?.font = UIFont.init(name: "Zombie-Noize", size: 30)
        btn.titleLabel?.textColor = .black
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 20
        btn.backgroundColor = .systemGray
        return btn
    }()
    
    private let buttonSettings: UIButton = {
        let btn = UIButton()
        btn.setTitle("⚙️", for: .normal)
        btn.titleLabel?.textColor = .black
        btn.titleLabel?.font = UIFont.init(name: "Zombie-Noize", size: 25)
        btn.titleLabel?.textColor = .black
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 20
        btn.backgroundColor = .systemGray
        return btn
    }()
    
    private let buttonLeaderboard: UIButton = {
        let btn = UIButton()
        btn.setTitle("📋", for: .normal)
        btn.titleLabel?.textColor = .black
        btn.titleLabel?.font = UIFont.init(name: "Zombie-Noize", size: 25)
        btn.titleLabel?.textColor = .black
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 20
        btn.backgroundColor = .systemGray
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.insertSubview(background, at: 1)
        view.insertSubview(walker, at: 2)
        createGradientLabel()
        view.insertSubview(buttonPlay, at: 2)
        view.insertSubview(buttonGarage, at: 2)
        view.insertSubview(buttonSettings, at: 2)
        view.insertSubview(buttonLeaderboard, at: 2)
        view.addSubview(buttonView)
        RunLoop.main.add(Timer(timeInterval: walkerAppearDuration + 1.0, repeats: false, block: { [self] _ in
            buttonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playClick)))
            buttonGarage.addTarget(self, action: #selector(garageClick), for: .touchUpInside)
            buttonSettings.addTarget(self, action: #selector(settingsClick), for: .touchUpInside)
            buttonLeaderboard.addTarget(self, action: #selector(leaderboardClick), for: .touchUpInside)
        }), forMode: .default)
        
        background.snp.makeConstraints() {
            $0.top.equalTo(0)
            $0.right.equalTo(0)
            $0.bottom.equalTo(0)
            $0.left.equalTo(0)
        }

        walker.frame = CGRect(x: 20, y: 300, width: 350, height: 350 * 1.77)
        UIView.animate(withDuration: walkerAppearDuration, delay: 1.0, options: [.curveEaseIn], animations: { [self] in
            walker.frame = CGRect(x: -90, y: 200, width: 450, height: 450 * 1.77)
        }, completion: { _ in
            MusicPlayer.shared.startMenuRoarSound()
        })
        
        buttonPlay.snp.makeConstraints() {
            $0.top.equalTo(300)
            $0.right.equalTo(-130)
            $0.left.equalTo(130)
        }
        
        buttonGarage.snp.makeConstraints() {
            $0.top.equalTo(buttonPlay).offset(140)
            $0.right.equalTo(-20)
            $0.left.equalTo(240)
        }
        
        buttonSettings.snp.makeConstraints() {
            $0.top.equalTo(buttonGarage).offset(140)
            $0.right.equalTo(-20)
            $0.left.equalTo(310)
        }
        
        buttonLeaderboard.snp.makeConstraints() {
            $0.top.equalTo(buttonSettings).offset(100)
            $0.right.equalTo(-20)
            $0.left.equalTo(310)
        }
        
        MusicPlayer.shared.startBackgroundMusic()
    }
    
    private func createGradientLabel() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))

        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
        
        let label = UILabel(frame: view.bounds)
        label.text = "Road Slam Z"
        label.textAlignment = .center
        label.font = UIFont.init(name: "Zombie-Noize", size: 75)
        label.adjustsFontSizeToFitWidth = true
        label.layer.shadowOpacity = 0.9
        view.addSubview(label)

        view.mask = label
        self.view.addSubview(view)
    }
    
    @objc private func playClick() {
        let vc = GameViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc private func garageClick() {
        showAlert(alertTitle: "⚠️", alertMessage: "Coming soon...")
    }
    
    @objc private func settingsClick() {
        let vc = SettingsViewController()
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(navbarBack))
        backButton.tintColor = .systemGray6
        vc.navigationItem.leftBarButtonItem = backButton
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        navController.modalTransitionStyle = .crossDissolve
        present(navController, animated: true, completion: nil)
    }
    
    @objc private func leaderboardClick() {
        showAlert(alertTitle: "⚠️", alertMessage: "Coming soon...")
    }
    
    @objc private func navbarBack() {
        dismiss(animated: true)
    }
    
    private func showAlert(alertTitle title: String, alertMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}

