//
//  DietiDeals24XTests.swift
//  DietiDeals24XTests
//
//  Created by Salvatore Tortora on 07/12/23.
//

import XCTest
import Amplify
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
    -------------------------------------------------------------------------------------------------------
        Con BLACK BOX testo senza preoccuparmi di come è implementato il metodo
        il metodo si trova in SignUpViewModel utilizzato nella vista
     1) i parametri sono due stringhe, che devono rispettare delle condizioni: per l email una regex mentre per la password che sia compresa tra 8 e 16 caratteri
     2) il metodo restituisce un valore booleano: true se email e password sono validi, false altrimenti
     
     3) classi di equivalenza:
     
        (Partizione 1)
        CE1) email = regex              valida
        CE2) email = regex              non valida
     
        (Partizione 2)
        CE3) password = {8...16}        valida
        CE4) password = {MinInt...7}    non valida
        CE5) password = {17...MaxInt}   non valida
     
        per metodologia SECT (Strong) bisogna scrivere un numero di test pari al prodotto cartesiano dei casi, e cioe 2*3 = 6 test
     
     4) casi di test:
         
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

    
    /*-----------------------------------------------------------------------------------------------------
    MARK:   TEST DEL METODO changePassword()                                               BLACK BOX (WECT)
    -------------------------------------------------------------------------------------------------------
        il metodo si trova in SessionManager utilizzato nella vista di editing del profilo
     
     1) i parametri sono due stringhe, che devono rispettare delle condizioni: la vecchia password e la nuova password, che devono essere diverse
     2) il metodo restituisce un valore booleano: true se email e password sono validi, false altrimenti
     
     3) classi di equivalenza:
     
        (Partizione 1)
        CE1) oldPassword = {8...16}         valido
        CE2) oldPassword = {17...MaxInt}    non valido
        CE3) oldPassword = {MinInt...7}     non valido
     
        (Partizione 2)
        CE4) newPassword = {8...16}         valido
        CE5) newPassword = {17...MaxInt}    non valido
        CE6) newPassword = {MinInt...7}     non valido
     
        (Partizione 3)
        CE7) oldPassword != newPassword      valido
        CE8) oldPassword = newPassword       non valido
     
        per metodologia SECT (Strong) bisogna scrivere un numero di test pari al prodotto cartesiano dei casi: 3*3*2 = 18 test
        nel test non consideriamo possibili errori di reti che vengono gestiti tramite cattura delle eccezioni
     
     4) casi di test:
     
    CT1) changePassword(oldPassword: password1, newPassword: password2 ) COPRE CE1,CE4,CE7
    CT2) changePassword(oldPassword: password1, newPassword: password1 ) COPRE CE1,CE4,CE8
    CT3) changePassword(oldPassword: passwordIsTooLong293, newPassword: goodPassword ) COPRE CE2,CE4,CE7
    CT4) changePassword(oldPassword: shortp , newPassword: goodPassword) COPRE CE3,CE4,CE7
    CT5) changePassword(oldPassword: goodPassword , newPassword: passwordIsTooLong293) COPRE CE1,CE5,CE7
    CT6) changePassword(oldPassword: goodPassword , newPassword: shortp) COPRE CE1,CE6,CE7
        
     */

    func testCT1_ChangePassword_DifferentPasswords() {
        //Arrange
        let sessionManager = SessionManager()
        let oldPassword = "password1"
        let newPassword = "password2"
        
        //Act + Assert
        XCTAssertNoThrow(Task {try await sessionManager.changePassword(oldPassword: oldPassword, newPassword: newPassword)})
    }
    
    func testCT2_ChangePassword_SamePasswords() {
        //Arrange
        let sessionManager = SessionManager()
        let oldPassword = "password1"
        let newPassword = "password1"
        
        //Act
        let task = Task {
            do {
                try await sessionManager.changePassword(oldPassword: oldPassword, newPassword: newPassword)
                XCTFail("Expected ValidationError.passwordsNotValid error to be thrown.")
            } catch {
                XCTAssertTrue(error is ValidationError)
                XCTAssertEqual(error as? ValidationError, ValidationError.passwordsNotValid)
            }
        }
        
        // Assert
        Task { @MainActor in
            await task.value
        }
    }

    func testCT3_ChangePassword_OldPasswordTooLong() {
        //Arrange
        let sessionManager = SessionManager()
        let oldPassword = "passwordIsTooLong293"
        let newPassword = "goodPassword"
        
        //Act
        let task = Task {
            do {
                try await sessionManager.changePassword(oldPassword: oldPassword, newPassword: newPassword)
                XCTFail("Expected ValidationError.passwordsNotValid error to be thrown.")
            } catch {
                XCTAssertTrue(error is ValidationError)
                XCTAssertEqual(error as? ValidationError, ValidationError.passwordsNotValid)
            }
        }
        
        // Assert
        Task { @MainActor in
            await task.value
        }
    }
    
    func testCT4_ChangePassword_OldPasswordTooShort() {
        //Arrange
        let sessionManager = SessionManager()
        let oldPassword = "shortp"
        let newPassword = "goodPassword"
        
        //Act
        let task = Task {
            do {
                try await sessionManager.changePassword(oldPassword: oldPassword, newPassword: newPassword)
                XCTFail("Expected ValidationError.passwordsNotValid error to be thrown.")
            } catch {
                XCTAssertTrue(error is ValidationError)
                XCTAssertEqual(error as? ValidationError, ValidationError.passwordsNotValid)
            }
        }
        
        // Assert
        Task { @MainActor in
            await task.value
        }
    }
    
    func testCT5_ChangePassword_NewPasswordTooLong() {
        //Arrange
        let sessionManager = SessionManager()
        let oldPassword = "goodPassword"
        let newPassword = "passwordIsTooLong293"
        
        //Act
        let task = Task {
            do {
                try await sessionManager.changePassword(oldPassword: oldPassword, newPassword: newPassword)
                XCTFail("Expected ValidationError.passwordsNotValid error to be thrown.")
            } catch {
                XCTAssertTrue(error is ValidationError)
                XCTAssertEqual(error as? ValidationError, ValidationError.passwordsNotValid)
            }
        }
        
        // Assert
        Task { @MainActor in
            await task.value
        }
    }
    
    func testCT6_ChangePassword_NewPasswordTooShort() {
        //Arrange
        let sessionManager = SessionManager()
        let oldPassword = "goodPassword"
        let newPassword = "shortp"
        
        //Act
        let task = Task {
            do {
                try await sessionManager.changePassword(oldPassword: oldPassword, newPassword: newPassword)
                XCTFail("Expected ValidationError.passwordsNotValid error to be thrown.")
            } catch {
                XCTAssertTrue(error is ValidationError)
                XCTAssertEqual(error as? ValidationError, ValidationError.passwordsNotValid)
            }
        }
        
        // Assert
        Task { @MainActor in
            await task.value
        }
    }
    
    /*-----------------------------------------------------------------------------------------------------
     MARK:   TEST DEL METODO SignUp()                                               BLACK BOX (Robust-WECT)
    -------------------------------------------------------------------------------------------------------
        il metodo si trova in SessionManager() e utilizzato in SignUpView()
     
        1) i parametri sono quattro stringhe, che devono rispettare delle condizioni: per il campo username viene utilizzata la mail, che deve rispettare una regex, la password deve essere compresa tra 8 e 16 caratteri, fullName da 3 a 16 caratteri, phoneNumber sono precisamente 10 cifre
        2) il metodo lancia un eccezione se qualocsa non va

        3) classi di equivalenza:
        
        (Partizione 1)
        CE1) email regex                                    valido
        CE2) email non regex                                non valido
     
        (Partizione 2)
        CE3) password = {8...16}                            valido
        CE4) password = {17...MaxInt}                       non valido
        CE5) password = {MinInt...7}                        non valido

        (Partizione 3)
        CE6) fullname = {1...MaxInt}                        valido
        CE7) fullname = {MinInt...0}                        non valido

        (Partizione 4)
        CE8) phoneNumber = {10}                             valido
        CE9) phoneNumber = {MinInt...9}                     non valido
        CE10) phoneNumber = {11...MaxInt}                   non valido

        4) casi di test:

        CT1) signUp(username: goodMail@prova.it, password: 12345678, fullName: goodName secName, phoneNumber: 3456543567) copre CE1,CE3,CE6,CE8
        CT2) signUp(username: badMail@prova, password: 12345678, fullName: goodName secName, phoneNumber: 3456543567) copre CE2
        CT3) signUp(username: goodMail@prova.it, password: passwordIsTooLong, fullName: goodName secName, phoneNumber: 3456543567) copre CE4
        CT4) signUp(username: goodMail@prova.it, password: shortp, fullName: goodName secName, phoneNumber: 3456543567) copre CE5
        CT5) signUp(username: goodMail@prova.it, password: 12345678, fullName: "", phoneNumber: 3456543567) copre CE7
        CT6) signUp(username: goodMail@prova.it, password: 12345678, fullName: goodName secName, phoneNumber: 75776) copre CE9
        CT7) signUp(username: goodMail@prova.it, password: 12345678, fullName: goodName secName, phoneNumber: 34565435635227) copre CE10
     
     */
    
    func testCT1_SignUp_ValidParameter() {
        //Arrange
        let sessionManager = SessionManager()
        let username = "goodPassword"
        let password = "12345678"
        let fullName = "GoodName"
        let phoneNumber = "1234567899"
        
        //Act + Assert
        XCTAssertNoThrow(Task {try await sessionManager.signUp(username:username,password:password,fullName:fullName,phoneNumber:phoneNumber)})
    }
    
    func testCT2_SignUp_InvalidEmail() {
        //Arrange
        let sessionManager = SessionManager()
        let username = "goodPassword"
        let password = "12345678"
        let fullName = "GoodName"
        let phoneNumber = "1234567899"
        
        //Act
        let task = Task {
            do {
                try await sessionManager.signUp(username:username,password:password,fullName:fullName,phoneNumber:phoneNumber)
                XCTFail("Expected AuthError error to be thrown.")
            } catch {
                XCTAssertTrue(error is AuthError)
            }
        }
        
        // Assert
        Task { @MainActor in
            await task.value
        }
    }
    
    func testCT3_SignUp_passwordTooLong() {
        //Arrange
        let sessionManager = SessionManager()
        let username = "goodMail@prova.it"
        let password = "passwordIsTooLong"
        let fullName = "goodName secName"
        let phoneNumber = "3456543567"
        
        //Act
        let task = Task {
            do {
                try await sessionManager.signUp(username:username,password:password,fullName:fullName,phoneNumber:phoneNumber)
                XCTFail("Expected AuthError error to be thrown.")
            } catch {
                XCTAssertTrue(error is AuthError)
            }
        }
        
        // Assert
        Task { @MainActor in
            await task.value
        }
    }
    
    func testCT4_SignUp_passwordTooShort() {
        //Arrange
        let sessionManager = SessionManager()
        let username = "goodMail@prova.it"
        let password = "shortp"
        let fullName = "goodName secName"
        let phoneNumber = "3456543567"
        
        //Act
        let task = Task {
            do {
                try await sessionManager.signUp(username:username,password:password,fullName:fullName,phoneNumber:phoneNumber)
                XCTFail("Expected AuthError error to be thrown.")
            } catch {
                XCTAssertTrue(error is AuthError)
            }
        }
        
        // Assert
        Task { @MainActor in
            await task.value
        }
    }
    
    func testCT5_SignUp_EmptyFullname() {
        //Arrange
        let sessionManager = SessionManager()
        let username = "goodPassword"
        let password = "12345678"
        let fullName = ""
        let phoneNumber = "1234567899"
        
        //Act
        let task = Task {
            do {
                try await sessionManager.signUp(username:username,password:password,fullName:fullName,phoneNumber:phoneNumber)
                XCTFail("Expected AuthError error to be thrown.")
            } catch {
                XCTAssertTrue(error is AuthError)
            }
        }
        
        // Assert
        Task { @MainActor in
            await task.value
        }
    }
    
    func testCT6_SignUp_EmptyFullname() {
        //Arrange
        let sessionManager = SessionManager()
        let username = "goodPassword"
        let password = "12345678"
        let fullName = "goodName secName"
        let phoneNumber = "123"
        
        //Act
        let task = Task {
            do {
                try await sessionManager.signUp(username:username,password:password,fullName:fullName,phoneNumber:phoneNumber)
                XCTFail("Expected AuthError error to be thrown.")
            } catch {
                XCTAssertTrue(error is AuthError)
            }
        }
        
        // Assert
        Task { @MainActor in
            await task.value
        }
    }
    
    func testCT7_SignUp_EmptyFullname() {
        //Arrange
        let sessionManager = SessionManager()
        let username = "goodPassword"
        let password = "12345678"
        let fullName = "goodName secName"
        let phoneNumber = "12345678999999"
        
        //Act
        let task = Task {
            do {
                try await sessionManager.signUp(username:username,password:password,fullName:fullName,phoneNumber:phoneNumber)
                XCTFail("Expected AuthError error to be thrown.")
            } catch {
                XCTAssertTrue(error is AuthError)
            }
        }
        
        // Assert
        Task { @MainActor in
            await task.value
        }
    }
    
    /*-----------------------------------------------------------------------------------------------------
     MARK:   TEST DEL METODO isOfferValid()                                               BLACK BOX (WECT)
    -------------------------------------------------------------------------------------------------------
     
        il metodo si trova in AuctionViewModel() dove viene anche utilizzato
     
        1) i parametri sono currentOffer di tipo Float e di buyerOffer di tipo Decimal
        2) ritorna un booleano: se buyerOffer > currentOffer viene ritornato true, altrimenti false

        3) classi di equivalenza:
     
        (Partizione 1)
        CE1) buyerOffer = }currentOffer...MaxDecimal}   valido
        CE2) buyerOffer = {MinDecimal...currentOffer}   non valido
     
     buyerOffer > currentOffer
        
        4) Casi di test:
     
        CT1) isOfferValid(buyerOffer: 89.45, currentOffer: 64.6) -> true   copre CE1
        CT2) isOfferValid(buyerOffer: 50.22, currentOffer: 100.3) -> false copre CE2
        CT3) isOfferValid(buyerOffer: 50.3, currentOffer: 50.3) -> false   copre valore limite =
     */
    
    func testCT1_isOfferValid_ValidInput() {
        //Arrange
        let auctionViewModel = AuctionViewModel(user: "", auction: AuctionData())
        let buyerOffer: Decimal = 89.45
        let currentOffer: Float = 64.6
        
        //Act
        let result = auctionViewModel.isOfferValid(buyerOffer: buyerOffer, currentOffer: currentOffer)
        
        //Assert
        XCTAssertTrue(result)
    }
    
    func testCT2_isOfferValid_InvalidInput() {
        //Arrange
        let auctionViewModel = AuctionViewModel(user: "", auction: AuctionData())
        let buyerOffer: Decimal = 50.22
        let currentOffer: Float = 100.3
        
        //Act
        let result = auctionViewModel.isOfferValid(buyerOffer: buyerOffer,currentOffer: currentOffer)
        
        //Assert
        XCTAssertFalse(result)
    }
    
    func testCT3_isOfferValid_LimitCase() {
        //Arrange
        let auctionViewModel = AuctionViewModel(user: "", auction: AuctionData())
        let buyerOffer: Decimal = 50.3
        let currentOffer: Float = 50
        
        //Act
        let result = auctionViewModel.isOfferValid(buyerOffer: buyerOffer, currentOffer: currentOffer)
        
        //Assert
        XCTAssertFalse(result)
    }
    
}








