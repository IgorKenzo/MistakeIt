//
//  LastLevel.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 23/11/20.
//

import Foundation

class UserDefaultManager {
    
    enum Key :String {
        case lastLevelPlayed = "lastlevelplayed"
        case unlockedLevel = "unlockedLevels"
    }
    
    static let shared = UserDefaultManager()
    private var userDefaults : UserDefaults
    private init() {self.userDefaults = UserDefaults.standard}
    
    func storeLastLevelPlayed(level : LevelState) {
        saveValue(forKey: .lastLevelPlayed, value: level.rawValue)
    }
    
    func getLastLevelPlayed() -> Int? {
        return readValue(forKey: .lastLevelPlayed)
    }
    
    func storeUnlockedLevels(forKey key : Key, levels : [Bool]){
        saveValue(forKey: key, value: levels)
    }
     
    func getUnlockedLevels() -> [Bool]? {
        return readObject(forKey: .unlockedLevel)
    }
    
    func unlockLevel(currentLevel level : LevelState){
        var lvl = getUnlockedLevels()
        if level.rawValue < MAXLEVEL - 1{
            lvl![level.rawValue+1] = true
        }
        storeUnlockedLevels(forKey: .unlockedLevel, levels: lvl!)
    }
    
     // MARK: - Private
    
    private func saveValue(forKey key: Key, value: Any) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    private func readValue<T>(forKey key: Key) -> T? {
        return userDefaults.value(forKey: key.rawValue) as? T
    }
    private func readObject(forKey key: Key) -> [Bool]? {
        return userDefaults.object(forKey: key.rawValue) as? [Bool]
    }
}
