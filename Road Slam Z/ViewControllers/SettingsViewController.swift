//
//  SettingsViewController.swift
//  Road Slam Z
//
//  Created by Admin on 10.10.23.
//

import UIKit
import DropDown

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
    
    private let musicLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Music"
        lbl.textAlignment = .center
        lbl.font = UIFont.init(name: "Zombie-Noize", size: 40)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .systemRed
        return lbl
    }()
    
    private lazy var musicView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 180, y: 168, width: 190, height: 40)
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 6
        let lbl = UILabel()
        lbl.text = Settings.currentPlayed
        lbl.textAlignment = .center
        lbl.font = UIFont.init(name: "Zombie-Noize", size: 23)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .systemRed
        view.addSubview(lbl)
        lbl.snp.makeConstraints(){
            $0.centerX.equalTo(view)
            $0.centerY.equalTo(view)
        }
        return view
    }()
    
    private let bloodLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Blood"
        lbl.textAlignment = .center
        lbl.font = UIFont.init(name: "Zombie-Noize", size: 40)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .systemRed
        return lbl
    }()
    
    private lazy var bloodView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 180, y: 268, width: 190, height: 40)
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 6
        let lbl = UILabel()
        lbl.text = Settings.blood ?? false ? "Yes" : "No"
        lbl.textAlignment = .center
        lbl.font = UIFont.init(name: "Zombie-Noize", size: 23)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .systemRed
        view.addSubview(lbl)
        lbl.snp.makeConstraints(){
            $0.centerX.equalTo(view)
            $0.centerY.equalTo(view)
        }
        return view
    }()
    
    private let difficultyLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Difficulty"
        lbl.textAlignment = .center
        lbl.font = UIFont.init(name: "Zombie-Noize", size: 40)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .systemRed
        return lbl
    }()
    
    private lazy var difficultyView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 180, y: 368, width: 190, height: 40)
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 6
        let lbl = UILabel()
        if Settings.difficulty == 0.0 {
            Settings.difficulty = 0.5
        }
        lbl.text = dropDownDifficultyArray[5 - Int((Settings.difficulty ?? 0.5) * 10)]
        lbl.textAlignment = .center
        lbl.font = UIFont.init(name: "Zombie-Noize", size: 23)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .systemRed
        view.addSubview(lbl)
        lbl.snp.makeConstraints(){
            $0.centerX.equalTo(view)
            $0.centerY.equalTo(view)
        }
        return view
    }()
    
    private let speedLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Game speed"
        lbl.textAlignment = .center
        lbl.font = UIFont.init(name: "Zombie-Noize", size: 40)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .systemRed
        return lbl
    }()
    
    private lazy var speedView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 180, y: 568, width: 190, height: 40)
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 6
        let lbl = UILabel()
        if Settings.gameSpeed == 0.0 {
            Settings.gameSpeed = 3.0
        }
        lbl.text = dropDownSpeedArray[speedToInd(withSpeed: Settings.gameSpeed ?? 3.0)]
        lbl.textAlignment = .center
        lbl.font = UIFont.init(name: "Zombie-Noize", size: 23)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .systemRed
        view.addSubview(lbl)
        lbl.snp.makeConstraints(){
            $0.centerX.equalTo(view)
            $0.centerY.equalTo(view)
        }
        return view
    }()
    
    private let showNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Show name"
        lbl.textAlignment = .center
        lbl.font = UIFont.init(name: "Zombie-Noize", size: 40)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .systemRed
        return lbl
    }()
    
    private lazy var showNameView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 180, y: 668, width: 190, height: 40)
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 6
        let lbl = UILabel()
        lbl.text = Settings.showUserName ?? false ? "Yes" : "No"
        lbl.textAlignment = .center
        lbl.font = UIFont.init(name: "Zombie-Noize", size: 23)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .systemRed
        view.addSubview(lbl)
        lbl.snp.makeConstraints(){
            $0.centerX.equalTo(view)
            $0.centerY.equalTo(view)
        }
        return view
    }()
    
    private let labelName: UILabel = {
        let lbl = UILabel()
        lbl.text = "Name"
        lbl.textAlignment = .center
        lbl.font = UIFont.init(name: "Zombie-Noize", size: 40)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .systemRed
        return lbl
    }()
    
    private lazy var textFieldName: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: Settings.userName ?? "Guest", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        tf.tintColor = .cyan
        tf.textAlignment = .center
        tf.font = UIFont.init(name: "Zombie-Noize", size: 40)
        tf.adjustsFontSizeToFitWidth = true
        tf.textColor = .systemRed
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .clear
        tf.layer.borderColor = UIColor.white.cgColor
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 6
        tf.keyboardType = .alphabet
        tf.keyboardAppearance = .dark
        tf.clearButtonMode = .always
        tf.returnKeyType = .done
        tf.autocorrectionType = .no
        tf.delegate = self
        return tf
    }()
    
    private let dropDownMusic = DropDown()
    private let dropDownMusicArray = ["HXW_THEY_JUDGE", "THE_WALKING_DEAD", "IF_LOOKS_COULD_KILL", "None"]
    
    private let dropDownBlood = DropDown()
    private let dropDownBloodArray = ["Yes", "No"]
    
    private let dropDownDifficulty = DropDown()
    private let dropDownDifficultyArray = ["Easy", "Normal", "Hard", "Ultra"]
    
    private let dropDownSpeed = DropDown()
    private let dropDownSpeedArray = ["Low", "Mid", "High", "Ultra"]
    
    private let dropDownName = DropDown()
    private let dropDownNameArray = ["Yes", "No"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(background)
        
        view.addSubview(titleLabel)
        
        view.addSubview(musicLabel)
        view.addSubview(musicView)
        
        view.addSubview(bloodLabel)
        view.addSubview(bloodView)
        
        view.addSubview(difficultyLabel)
        view.addSubview(difficultyView)
        
        view.addSubview(speedLabel)
        view.addSubview(speedView)
        
        view.addSubview(showNameLabel)
        view.addSubview(showNameView)
        
        view.addSubview(labelName)
        view.addSubview(textFieldName)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(screenTap)))
        
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
        
        musicLabel.snp.makeConstraints() {
            $0.top.equalTo(titleLabel).offset(100)
            $0.left.equalTo(40)
        }
        musicView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(musicDropDown)))
        initDropDown(toInit: dropDownMusic, withData: dropDownMusicArray, withView: musicView)
        dropDownMusic.selectionAction = { [self] (index: Int, item: String) in
            let lbl = musicView.subviews[0] as! UILabel
            lbl.text = item
            guard Settings.currentPlayed == item else {
                Settings.currentPlayed = item
                MusicPlayer.shared.stopBackgroundMusic()
                MusicPlayer.shared.startBackgroundMusic()
                return
            }
            Settings.currentPlayed = item
        }

        bloodLabel.snp.makeConstraints() {
            $0.top.equalTo(musicLabel).offset(100)
            $0.left.equalTo(40)
        }
        bloodView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bloodDropDown)))
        initDropDown(toInit: dropDownBlood, withData: dropDownBloodArray, withView: bloodView)
        dropDownBlood.selectionAction = { [self] (index: Int, item: String) in
            let lbl = bloodView.subviews[0] as! UILabel
            lbl.text = item
            Settings.blood = item == "Yes" ? true : false
        }
        
        difficultyLabel.snp.makeConstraints() {
            $0.top.equalTo(bloodLabel).offset(100)
            $0.left.equalTo(20)
        }
        difficultyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(difficultyDropDown)))
        initDropDown(toInit: dropDownDifficulty, withData: dropDownDifficultyArray, withView: difficultyView)
        dropDownDifficulty.selectionAction = { [self] (index: Int, item: String) in
            let lbl = difficultyView.subviews[0] as! UILabel
            lbl.text = item
            Settings.difficulty = Double((5 - index)) / 10
        }
        
        speedLabel.snp.makeConstraints() {
            $0.top.equalTo(labelName).offset(100)
            $0.left.equalTo(10)
        }
        speedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(speedDropDown)))
        initDropDown(toInit: dropDownSpeed, withData: dropDownSpeedArray, withView: speedView)
        dropDownSpeed.selectionAction = { [self] (index: Int, item: String) in
            let lbl = speedView.subviews[0] as! UILabel
            lbl.text = item
            Settings.gameSpeed = indToSpeed(withInd: index)
        }
        
        showNameLabel.snp.makeConstraints() {
            $0.top.equalTo(speedLabel).offset(100)
            $0.left.equalTo(10)
        }
        showNameView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nameDropDown)))
        initDropDown(toInit: dropDownName, withData: dropDownNameArray, withView: showNameView)
        dropDownName.selectionAction = { [self] (index: Int, item: String) in
            let lbl = showNameView.subviews[0] as! UILabel
            lbl.text = item
            Settings.showUserName = item == "Yes" ? true : false
        }
        
        labelName.snp.makeConstraints(){
            $0.top.equalTo(difficultyLabel).offset(100)
            $0.left.equalTo(30)
        }
        
        textFieldName.snp.makeConstraints(){
            $0.top.equalTo(difficultyLabel).offset(90)
            $0.right.equalTo(-20)
            $0.left.equalTo(140)
        }
    }
    
    @objc private func screenTap() {
        textFieldName.resignFirstResponder()
    }
    
    @objc private func musicDropDown() {
        dropDownMusic.show()
    }
    
    @objc private func bloodDropDown() {
        dropDownBlood.show()
    }
    
    @objc private func difficultyDropDown() {
        dropDownDifficulty.show()
    }
    
    @objc private func speedDropDown() {
        dropDownSpeed.show()
    }
    
    @objc private func nameDropDown() {
        dropDownName.show()
    }
    
    private func speedToInd(withSpeed speed: Double) -> Int {
        switch speed {
        case 3.0:
            return 0
        case 2.7:
            return 1
        case 2.5:
            return 2
        case 2.0:
            return 3
        default:
            break
        }
        return -1
    }
    
    private func indToSpeed(withInd ind: Int) -> Double {
        switch ind {
        case 0:
            return 3.0
        case 1:
            return 2.7
        case 2:
            return 2.5
        case 3:
            return 2.0
        default:
            break
        }
        return -1
    }
    
    private func initDropDown(toInit dd: DropDown, withData data: [String], withView view: UIView) {
        dd.anchorView = view
        dd.dataSource = data
        dd.selectRow(at: data.firstIndex(of: (view.subviews[0] as! UILabel).text ?? "error"))
        dd.bottomOffset = CGPoint(x: 0, y: (dd.anchorView?.plainView.bounds.height) ?? 0.0)
        dd.cornerRadius = 6
        dd.backgroundColor = .clear
    }
    
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        Settings.userName = textField.text ?? "Guest"
        return true
    }
    
}
