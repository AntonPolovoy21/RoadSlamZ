//
//  Settings.swift
//  Road Slam Z
//
//  Created by Admin on 10.10.23.
//

import Foundation

final class Settings {
    
    private enum settingsKeys: String {
        case currentPlayed
        case blood
        case showUserName
        case difficulty
        case gameSpeed
        case userName
    }
    
    static var currentPlayed: String? {
        get {
            return UserDefaults.standard.string(forKey: settingsKeys.currentPlayed.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = settingsKeys.currentPlayed.rawValue
            if let song = newValue {
                defaults.set(song, forKey: key)
            }
            else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var blood: Bool? {
        get {
            return UserDefaults.standard.bool(forKey: settingsKeys.blood.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = settingsKeys.blood.rawValue
            if let blood = newValue {
                defaults.set(blood, forKey: key)
            }
            else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var difficulty: Double? {
        get {
            return UserDefaults.standard.double(forKey: settingsKeys.difficulty.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = settingsKeys.difficulty.rawValue
            if let difficulty = newValue {
                defaults.set(difficulty, forKey: key)
            }
            else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var gameSpeed: Double? {
        get {
            return UserDefaults.standard.double(forKey: settingsKeys.gameSpeed.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = settingsKeys.gameSpeed.rawValue
            if let gameSpeed = newValue {
                defaults.set(gameSpeed, forKey: key)
            }
            else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var showUserName: Bool? {
        get {
            return UserDefaults.standard.bool(forKey: settingsKeys.showUserName.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = settingsKeys.showUserName.rawValue
            if let showUserName = newValue {
                defaults.set(showUserName, forKey: key)
            }
            else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var userName: String? {
        get {
            return UserDefaults.standard.string(forKey: settingsKeys.userName.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = settingsKeys.userName.rawValue
            if let userName = newValue {
                print("User name set to \(userName) with key \(key)")
                defaults.set(userName, forKey: key)
            }
            else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}
