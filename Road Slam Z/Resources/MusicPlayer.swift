//
//  MusicPlayer.swift
//  Road Slam Z
//
//  Created by Admin on 8.10.23.
//

import AVFAudio
import Foundation

class MusicPlayer {
    
    static let shared = MusicPlayer()
    private var audioPlayerBackground: AVAudioPlayer?
    private var audioPlayerMenuRoar: AVAudioPlayer?
    private var audioPlayerEngine: AVAudioPlayer?
    private var audioPlayerDead: AVAudioPlayer?
    private var audioPlayerLose: AVAudioPlayer?

    public enum currentPlayingType {
        case HXW_THEY_JUDGE
        case THE_WALKING_DEAD
        case IF_LOOKS_COULD_KILL
    }
    
    func startBackgroundMusic() {
        if let bundle = Bundle.main.path(forResource: "HXW_THEY_JUDGE", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayerBackground = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayerBackground else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    func startMenuRoarSound() {
        if let bundle = Bundle.main.path(forResource: "menu_zombie_roar", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayerMenuRoar = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayerMenuRoar else { return }
                audioPlayer.numberOfLoops = 0
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    func startEngineSound() {
        if let bundle = Bundle.main.path(forResource: "engine", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayerEngine = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayerEngine else { return }
                audioPlayer.numberOfLoops = 0
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    func startDeadSound() {
        if let bundle = Bundle.main.path(forResource: "dead", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayerDead = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayerDead else { return }
                audioPlayer.numberOfLoops = 0
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    func startLoseSound() {
        if let bundle = Bundle.main.path(forResource: "lose", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayerLose = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayerLose else { return }
                audioPlayer.numberOfLoops = 0
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    func stopBackgroundMusic() {
        guard let audioPlayer = audioPlayerBackground else { return }
        audioPlayer.stop()
    }
}
