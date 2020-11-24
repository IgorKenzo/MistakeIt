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
     
     // MARK: - Private
    
    private func saveValue(forKey key: Key, value: Any) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    private func readValue<T>(forKey key: Key) -> T? {
        return userDefaults.value(forKey: key.rawValue) as? T
    }
}
