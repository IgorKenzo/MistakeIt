//
//  HapticsFeedback.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 24/11/20.
//

import UIKit

class HapticsFeedback {
    private init() {}
    
    static let shared = HapticsFeedback()
    
    private let generator = UIImpactFeedbackGenerator(style: .medium)
    
    func vibrate() {
        generator.impactOccurred(intensity: 0.5)
    }
}
