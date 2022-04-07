//
//  DrinkWaterViewModel.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/06.
//

import Foundation

final class DrinkWaterViewModel {
    
    var nickname: String {
        didSet {
            UserDefaults.nickname = nickname
        }
    }
    
    var height: Int {
        didSet {
            UserDefaults.height = height
        }
    }

    var weight: Int {
        didSet {
            UserDefaults.weight = weight
        }
    }
    
    var todayIntake: Int {
        didSet {
            print(todayIntake)
            UserDefaults.todayIntake = todayIntake
        }
    }
    
    var todayLastIntake: [Int] {
        didSet {
            print(todayLastIntake)
            UserDefaults.todayLastIntake = todayLastIntake
        }
    }
    
    var recommendedIntake: Double
    
    var achivementRate: Double
    
    init() {

        self.nickname = UserDefaults.nickname
        self.height = UserDefaults.height
        self.weight = UserDefaults.weight
        self.todayIntake = UserDefaults.todayIntake
        self.todayLastIntake = UserDefaults.todayLastIntake
        self.recommendedIntake = 0
        self.achivementRate = 0
    }
    
    func getRecommendedIntake() {
        recommendedIntake = Double(UserDefaults.height + UserDefaults.weight) / 100 * 1000 // ml
    }
    
    func getAchivementRate() {
        achivementRate = recommendedIntake == 0 ? 0 : round((Double(todayIntake) /  recommendedIntake) * 100) // %
    }
    
    
    
   
    
    func addTodayIntake(intake: Int) {
        todayIntake += intake
    }
    
    func subTodayIntake(intake: Int) {
        todayIntake -= intake
    }
    
    func appendTodayLastIntake(intake: Int) {
        todayLastIntake.append(intake)
    }
    
    func removeLastTodayLastIntake() -> Int {
        return todayLastIntake.removeLast()
    }
}
