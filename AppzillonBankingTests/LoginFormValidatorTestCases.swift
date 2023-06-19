//
//  LoginFormValidatorTestCases.swift
//  AppzillonBankingTests
//
//  Created by Rakesh BVS. Kumar on 2023/6/19.
//

import XCTest

@testable import AppzillonBanking

final class LoginFormValidatorTestCases: XCTestCase {
    
    var sut : LoginFormValidator!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        sut = LoginFormValidator()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        sut = nil
    }

    func testLoginFormValidator_whenValidUserNameProvided_ShouldReturnTrue() {
        
        //Arrange
        
        //Act
        let isUserNameValid = sut.isUserNameValid(userName: "bvrakesh")
        
        //Assert
        XCTAssertTrue(isUserNameValid,"The isuserNameValid() should have returned TRUE for a valid first name but returned FALSE")
    }
    
    func testLoginFormValidator_WhenTooShortUserNameProvided_ShouldReturnFalse() {
        
        //Arrange
        
        
        //Act
        let isUserNameValid = sut.isUserNameValid(userName: "R")
        
        //Assert
        XCTAssertFalse(isUserNameValid,"The isUserNameValid() should have returned FALSE for a first name that is shorter than \(LoginFormConstants.userNameMinlength) charecters")
        
    }
    
    func testLoginFormValidator_WhenTooLongUserNameProvided_ShouldReturnFalse() {
        
        //Arrange
        
        
        //Act
        let isUserNameValid = sut.isUserNameValid(userName: "Rakesh Rakesh Rakesh")
        
        //Assert
        XCTAssertFalse(isUserNameValid,"The isUserNameValid() should have returned FALSE for a first name that is shorter than \(LoginFormConstants.userNameMaxlength) charecters")
        
    }
    
    
    func testLoginFormValidator_WhenValidPasswordProvoded_ShouldReturnTrue(){
        
        // Assert
        
        //Act
        let isPasswordValid = sut.isPasswordvalid(password: "Pas$word1")
        
        //Assert
        XCTAssertTrue(isPasswordValid,"The isPasswordValid() should have returned TRUE for a valid password but returned FALSE")
    }
    
    func testLoginFormValidator_WhenTooShortPasswordProvided_ShouldReturnFalse(){
        
        // Assert
        
        //Act
        let isPasswordValid = sut.isPasswordvalid(password: "P")
        
        //Assert
        XCTAssertFalse(isPasswordValid,"The isPasswordValid() should have returned TRUE for a valid password but returned FALSE")
        
    }

}
