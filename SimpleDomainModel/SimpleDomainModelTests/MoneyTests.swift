//
//  MoneyTests.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

import SimpleDomainModel

//////////////////
// MoneyTests
//
class MoneyTests: XCTestCase {
  
  let tenUSD = Money(amount: 10, currency: "USD")
  let twelveUSD = Money(amount: 12, currency: "USD")
  let fiveGBP = Money(amount: 5, currency: "GBP")
  let fifteenEUR = Money(amount: 15, currency: "EUR")
  let fifteenCAN = Money(amount: 15, currency: "CAN")
  
    ////////////////////////////////////////////////
    //Unit test made to check if descrition() works
    //
  func testDescrition(){
    XCTAssert(tenUSD.description() == "USD10")
    XCTAssert(twelveUSD.description() == "USD12")
    XCTAssert(fiveGBP.description() == "GBP5")
    XCTAssert(fifteenEUR.description() == "EUR15")
  }
    
    ////////////////////////////////////////////////
    //Unit test made to check if money+,- operation works
    //
    func testPlusMinusOperation(){
        let twoentyUSD = tenUSD+twelveUSD
        XCTAssert(twoentyUSD.description() == "USD22")
        let twoUSD = twelveUSD-tenUSD
        XCTAssert(twoUSD.description() == "USD2")
        let threeCAN = Money(amount: 3, currency: "CAN")
        let eightteenCAN = fifteenCAN+threeCAN
        XCTAssert(eightteenCAN.description() == "CAN18")
        let twelveCAN = fifteenCAN-threeCAN
        XCTAssert(twelveCAN.description() == "CAN12")
    }
    
    ////////////////////////////////////////////////
    //Unit test made to check if money+,- operation works
    //
    func testExtension(){
        let tenYEN = 10.0.YEN
        XCTAssert(tenYEN.description() == "YEN10")
        let fiveEUR = 5.0.EUR
        XCTAssert(fiveEUR.description() == "EUR5")
        let fivtythreeUSD = 53.0.USD
        XCTAssert(fivtythreeUSD.description() == "USD53")
        let twentyfourGBP = 24.0.GBP
        XCTAssert(twentyfourGBP.description() == "GBP24")
        let thirtyfiveEUR = 35.0.EUR
        XCTAssert(thirtyfiveEUR.description() == "EUR35")
    }
    
  func testCanICreateMoney() {
    let oneUSD = Money(amount: 1, currency: "USD")
    XCTAssert(oneUSD.amount == 1)
    XCTAssert(oneUSD.currency == "USD")
    
    let tenGBP = Money(amount: 10, currency: "GBP")
    XCTAssert(tenGBP.amount == 10)
    XCTAssert(tenGBP.currency == "GBP")
  }
  
  func testUSDtoGBP() {
    let gbp = tenUSD.convert("GBP")
    XCTAssert(gbp.currency == "GBP")
    XCTAssert(gbp.amount == 5)
  }
  func testUSDtoEUR() {
    let eur = tenUSD.convert("EUR")
    XCTAssert(eur.currency == "EUR")
    XCTAssert(eur.amount == 15)
  }
  func testUSDtoCAN() {
    let can = twelveUSD.convert("CAN")
    XCTAssert(can.currency == "CAN")
    XCTAssert(can.amount == 15)
  }
  func testGBPtoUSD() {
    let usd = fiveGBP.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 10)
  }
  func testEURtoUSD() {
    let usd = fifteenEUR.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 10)
  }
  func testCANtoUSD() {
    let usd = fifteenCAN.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 12)
  }
  
  func testUSDtoEURtoUSD() {
    let eur = tenUSD.convert("EUR")
    let usd = eur.convert("USD")
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
  }
  func testUSDtoGBPtoUSD() {
    let gbp = tenUSD.convert("GBP")
    let usd = gbp.convert("USD")
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
  }
  func testUSDtoCANtoUSD() {
    let can = twelveUSD.convert("CAN")
    let usd = can.convert("USD")
    XCTAssert(twelveUSD.amount == usd.amount)
    XCTAssert(twelveUSD.currency == usd.currency)
  }
  
  func testAddUSDtoUSD() {
    let total = tenUSD.add(tenUSD)
    XCTAssert(total.amount == 20)
    XCTAssert(total.currency == "USD")
  }
  
  func testAddUSDtoGBP() {
    let total = tenUSD.add(fiveGBP)
    XCTAssert(total.amount == 10)
    XCTAssert(total.currency == "GBP")
  }
}

