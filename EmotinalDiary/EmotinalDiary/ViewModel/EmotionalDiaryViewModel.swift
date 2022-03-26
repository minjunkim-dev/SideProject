//
//  EmotionalDiaryViewModel.swift
//  EmotinalDiary
//
//  Created by beneDev on 2022/03/26.
//

import Foundation

class EmotionalDiaryViewModel: EmotionDelegate {
    
    var fun: Observable<Int>
    var happy: Observable<Int>
    var lovely: Observable<Int>
    var angry: Observable<Int>
    var helpless: Observable<Int>
    var tired: Observable<Int>
    var embarrassing: Observable<Int>
    var depressed: Observable<Int>
    var upset: Observable<Int>
    

    init() {
    
        fun = Observable(UserDefaults.fun)
        happy = Observable(UserDefaults.happy)
        lovely = Observable(UserDefaults.lovely)
        angry = Observable(UserDefaults.angry)
        helpless = Observable(UserDefaults.helpless)
        tired = Observable(UserDefaults.tired)
        embarrassing = Observable(UserDefaults.embarrassing)
        depressed = Observable(UserDefaults.depressed)
        upset = Observable(UserDefaults.upset)
    
    }
    
    @objc func resetEmotionNumber() {
        fun.value = UserDefaults.$fun
        happy.value = UserDefaults.$happy
        lovely.value = UserDefaults.$lovely
        angry.value = UserDefaults.$angry
        helpless.value = UserDefaults.$helpless
        tired.value = UserDefaults.$tired
        embarrassing.value = UserDefaults.$embarrassing
        depressed.value = UserDefaults.$depressed
        upset.value = UserDefaults.$upset
    }
    
    func storeEmotionNumber() {
        UserDefaults.fun = fun.value
        UserDefaults.happy = happy.value
        UserDefaults.lovely = lovely.value
        UserDefaults.angry = angry.value
        UserDefaults.helpless = helpless.value
        UserDefaults.tired = tired.value
        UserDefaults.embarrassing = embarrassing.value
        UserDefaults.depressed = depressed.value
        UserDefaults.upset = upset.value
    }
    
    func addEmotionNumber(tag: Int) {
        
        if let emotion = Emotion(rawValue: tag) {
            switch emotion {
            case .fun:
                fun.value += 1
            case .happy:
                happy.value += 1
            case .lovely:
                lovely.value += 1
            case .angry:
                angry.value += 1
            case .helpless:
                helpless.value += 1
            case .tired:
                tired.value += 1
            case .embarrassing:
                embarrassing.value += 1
            case .depressed:
                depressed.value += 1
            case .upset:
                upset.value += 1
            }
        }
    }
}
