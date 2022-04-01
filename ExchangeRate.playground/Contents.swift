import Foundation

struct ExchangeRate {
    
    var currencyRate: Double { // 프로퍼티 옵저버
        willSet {
            print("currencyRate willSet - 환율 변동 예정: \(currencyRate)원 -> \(newValue)원")
        }
        
        didSet {
            print("currencyRate didSet - 환율 변동 완료: \(oldValue)원 -> \(currencyRate)원")
        }
    }
    
    var USD: Double { // 프로퍼티 옵저버
        willSet {
            print("USD willSet - 환전 금액: USD: \(newValue)달러로 환전될 예정")
        }
        
        didSet {
            print("USD didSet - KRW: \(USD * currencyRate)원 -> \(USD)달러로 환전되었음")
        }
    }
    
    var KRW: Double { // 연산 프로퍼티
        @discardableResult get {
            return 0
        }
        
        set {
            USD = newValue / currencyRate
        }
    }
}

/*
 - 연산 프로퍼티는 var로만 선언이 가능하며, 값을 저장하고 있지 않음
 - 읽기 전용 연산 프로퍼티는 get만 구현 필요
 - 읽기, 쓰기 연산 프로퍼티는 get, set 모두 구현 필요
 - 쓰기 전용 연산 프로퍼티는 구현할 수 없음(set만 구현하는 경우는 불가능하다는 의미)
 */

/* case 1 */
var rate = ExchangeRate(currencyRate: 1100, USD: 0) // memberwise init
rate.KRW = 500000

/* case 2 */
rate.currencyRate = 1350
rate.KRW = 500000
