//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

public class TestMe {
    public func Please() -> String {
        return "I have been tested"
    }
}

///////////////////////////////////
//Created the protocol
protocol CustomStringConvertible{
    func description() -> String
}




////////////////////////////////////
// Money
//
public struct Money : CustomStringConvertible, Mathematics{
    public var amount : Int
    public var currency : String
    
    public func description() -> String{
        return "\(currency)\(amount)"
    }
    
    public func convert(to: String) -> Money {
        let ratio = [
            "USD": 1,
            "GBP": 0.5,
            "EUR": 1.5,
            "CAN": 1.25,
            ]
        let rate = ratio[to]! / ratio[currency]!
        let another = Int(Double(self.amount) * rate)
        return Money(amount: another, currency: to)
    }
    
    public func add(to: Money) -> Money {
        if to.currency == currency {
            return Money(amount: amount+to.amount, currency: currency)
        }else{
            let newmoney = convert(to.currency)
            return Money(amount: newmoney.amount+to.amount, currency: to.currency)
        }
    }
    public func subtract(from: Money) -> Money {
        if from.currency == currency{
            return Money(amount: amount-from.amount, currency: currency)
        }else{
            let newmoney = self.convert(from.currency)
            return Money(amount: newmoney.amount-from.amount, currency: currency)
        }
    }
}

////////////////////////////////////
//Protocol
protocol Mathematics {
    func + (left : Money, right : Money) -> Money
    func - (left : Money, right : Money) -> Money
}

////////////////////////////////////
//Money plus operation
public func + (left: Money, right: Money) -> Money{
    return Money(amount: left.amount + right.amount, currency: left.currency)
}

////////////////////////////////////

public func - (left: Money, right: Money) -> Money{
    return Money(amount: left.amount - right.amount, currency: left.currency)
}

////////////////////////////////////
//Money minus operation
// extension
extension Double {
    var USD: Money { return Money(amount: Int(self), currency: "USD") }
    var EUR: Money { return Money(amount: Int(self), currency: "EUR") }
    var GBP: Money { return Money(amount: Int(self), currency: "GBP") }
    var YEN: Money { return Money(amount: Int(self), currency: "YEN") }
}

////////////////////////////////////
// Job
//
public class Job : CustomStringConvertible{
    
    public var title: String
    public var type: JobType
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    public func description() -> String{
        return "\(title) \(type)"
    }
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    public func calculateIncome(hours: Int) -> Int {
        switch type {
        case .Hourly(let value):
            return Int(Double(hours) * value)
        case .Salary(let value):
            return value
        }
    }
    
    public func raise(amt : Double) {
        switch type {
        case .Hourly(let value):
            self.type = .Hourly(Double(value + amt))
        case .Salary(let value):
            self.type = .Salary(value + Int(amt))
        }
    }
}

////////////////////////////////////
// Person
//
public class Person : CustomStringConvertible{
    public var firstName : String = ""
    public var lastName : String = ""
    public var age : Int = 0
    public var job2 : Job? = nil
    public var spouse2 : Person? = nil;
    
    public var job : Job? {
        get {
            return job2
        }
        set(value) {
            if age >= 16 {
                job2 = value
            }
        }
    }
    
    public func description() -> String{
        return "\(firstName) \(lastName) \(age)"
    }
    
    public var spouse : Person? {
        get {
            return spouse2
        }
        set(value) {
            if age >= 18 {
                spouse2 = value
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    public func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]"
    }
}

////////////////////////////////////
// Family
//
public class Family : CustomStringConvertible{
    private var members : [Person] = []
    
    public init(spouse1: Person, spouse2: Person) {
        if spouse1.spouse == nil && spouse2.spouse == nil{
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            members = [spouse1, spouse2]
        }
    }
    
    public func description() -> String{
        var names = ""
        for person in members {
            names += "\(person.firstName) \(person.lastName) "
        }
        return names
    }
    
    public func haveChild(child: Person) -> Bool {
        var check = false
        for person in members {
            if person.age > 21{
                check = true
            }
        }
        if check {
            members += [child]
            return true
        } else {
            return false
        }
    }
    
    public func householdIncome() -> Int {
        var total = 0
        
        for person in members {
            if ((person.job?.type) != nil){
                total += person.job!.calculateIncome(2000)
            }
        }
        return total
    }
}
