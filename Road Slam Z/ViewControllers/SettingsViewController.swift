//
//  SettingsViewController.swift
//  Road Slam Z
//
//  Created by Admin on 10.10.23.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let background = UIImageView(image: UIImage(named: "settings"))
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Settings"
        lbl.textAlignment = .center
        lbl.font = UIFont.init(name: "Zombie-Noize", size: 60)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .systemGray5
        return lbl
    }()
    
    private lazy var currentPlayedTextField: UITextField = {
        let tf = UITextField()
        tf.text = enumToStr(forMember: Settings.structure.init().currentPlayed)
        
        return tf
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        view.addSubview(titleLabel)
        
        background.snp.makeConstraints() {
            $0.top.equalTo(0)
            $0.right.equalTo(0)
            $0.bottom.equalTo(0)
            $0.left.equalTo(0)
        }
        
        titleLabel.snp.makeConstraints() {
            $0.top.equalTo(70)
            $0.right.equalTo(-20)
            $0.left.equalTo(20)
        }
        
    }
    
    private func enumToStr(forMember member:MusicPlayer.currentPlayingType) -> String{
        switch member {
        case .HXW_THEY_JUDGE:
            return "HXW THEY JUDGE"
        case .THE_WALKING_DEAD:
            return "THE WALKING DEAD"
        case .IF_LOOKS_COULD_KILL:
            return "IF LOOKS COULD KILL"
        }
    }
}
