//
//  DietiDeals24XTests.swift
//  DietiDeals24XTests
//
//  Created by Salvatore Tortora on 07/12/23.
//

import XCTest
@testable import DietiDeals24

final class DietiDeals24Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    /*-----------------------------------------------------------------------------------------------------
    MARK:   TEST DEL METODO checkEmailAndPassword()                                        BLACK BOX (SECT)
    -----------------------------------------------------------------------------------------------------*/
    
    /*
        Con BLACK BOX testo senza preoccuparmi di come è implementato il metodo
        il metodo si trova in SignUpViewModel utilizzato nella vista
     1) i requisiti sono due stringhe, che devono rispettare delle condizioni: per l email una regex mentre per la password
        che sia compresa tra 8 e 16 caratteri
     2) i parametri utilizzati sono: email e password, entrambi sono di tipo String
     3) il metodo restituisce un valore booleano: true se email e password sono validi, false altrimenti
     
     4) classi di equivalenza:
        
        CE1) email = regex              valida
        CE2) email = regex              non valida
     
        CE3) password = {8...16}        valida
        CE4) password = {MinInt...8}    non valida
        CE5) password = {16...MaxInt}   non valida
     
        per metodologia SECT (Strong) bisogna scrivere un numero di test pari al prodotto cartesiano dei casi, e cioe 2*3 = 6 test
     
     5) casi di test:
         
        CT1) checkEmailAndPassword(email: "prova@ciao.it", password: "12345678")
        CT2) checkEmailAndPassword(email: "prova@ciao.it", password: "1234567")
        CT3) checkEmailAndPassword(email: "prova@ciao.it", password: "123456789123456789")
        CT4) checkEmailAndPassword(email: "prova@ciao", password: "12345678")
        CT5) checkEmailAndPassword(email: "prova@ciao", password: "1234567")
        CT6) checkEmailAndPassword(email: "prova@ciao", password: "123456789123456789")
        
     */
    
    func testCT1_CheckEmailAndPassword_ValidEmailAndPassword() {
        // Arrange
        let viewModel = SignUpViewModel()
        viewModel.email = "prova@ciao.it"
        viewModel.password = "12345678"
        
        // Act
        let isValid = viewModel.checkEmailAndPassword()
        
        // Assert
        XCTAssertTrue(isValid, "CT1: Email e password valide devono tornare true")
    }

    func testCT2_CheckEmailAndPassword_ValidEmail_InvalidPassword() {
        // Arrange
        let viewModel = SignUpViewModel()
        viewModel.email = "prova@ciao.it"
        viewModel.password = "1234567"
        
        // Act
        let isValid = viewModel.checkEmailAndPassword()
        
        // Assert
        XCTAssertFalse(isValid, "CT2: Email valida e password non valida deve tornare false")
    }

    func testCT3_CheckEmailAndPassword_ValidEmail_InvalidLongPassword() {
        // Arrange
        let viewModel = SignUpViewModel()
        viewModel.email = "prova@ciao.it"
        viewModel.password = "123456789123456789"
        
        // Act
        let isValid = viewModel.checkEmailAndPassword()
        
        // Assert
        XCTAssertFalse(isValid, "CT3: Email valida e password troppo lunga deve tornare false")
    }

    func testCT4_CheckEmailAndPassword_InvalidEmail_ValidPassword() {
        // Arrange
        let viewModel = SignUpViewModel()
        viewModel.email = "prova@ciao"
        viewModel.password = "12345678"
        
        // Act
        let isValid = viewModel.checkEmailAndPassword()
        
        // Assert
        XCTAssertFalse(isValid, "CT4: Email non valida e password valida deve tornare false")
    }

    func testCT5_CheckEmailAndPassword_InvalidEmail_InvalidPassword() {
        // Arrange
        let viewModel = SignUpViewModel()
        viewModel.email = "prova@ciao"
        viewModel.password = "1234567"
        
        // Act
        let isValid = viewModel.checkEmailAndPassword()
        
        // Assert
        XCTAssertFalse(isValid, "CT5: Email e password non valide deve tornare false")
    }

    func testCT6_CheckEmailAndPassword_InvalidEmail_InvalidLongPassword() {
        // Arrange
        let viewModel = SignUpViewModel()
        viewModel.email = "prova@ciao"
        viewModel.password = "123456789123456789"
        
        // Act
        let isValid = viewModel.checkEmailAndPassword()
        
        // Assert
        XCTAssertFalse(isValid, "CT6: Email non valida e password troppo lunga deve tornare false")
    }

    
    
    
    
    
}
