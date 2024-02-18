//
//  CollectionViewModelTests.swift
//  PhotoFinderTests
//
//  Created by Anton Kirilyuk on 17.02.2024.
//

import XCTest
import Alamofire
@testable import PhotoFinder

final class CollectionViewModelTests: XCTestCase {
    
    /// Тестируемый объект - SUT
    var sut: CollectionViewModel!
    
    /// Тестовый stub объект
    var networkManagerStub: NetworkManagerProtocol!
    
    override func setUp() {
        super.setUp()
        networkManagerStub = NetworkManagerStub()
        sut = CollectionViewModel(networkManager: networkManagerStub)
    }
    
    override func tearDown() {
        networkManagerStub = nil
        sut = nil
        super.tearDown()
    }
    
    
    // searchButtonPressed: true
    func testFetchOfData1() {
        // arrange - подготовка (дано)
        var boolChecked: Bool!
        var errorFetchOfData: AFError!
        
        // act - выполнение тестируемого кода
        sut.fetchOfData(with: "", searchButtonPressed: true) { arrayImagesIsEmpty in
            boolChecked = arrayImagesIsEmpty
        } errorCompletion: { error in
            errorFetchOfData = error
        }
        
        // assert - проверка
        XCTAssertTrue(boolChecked)
        XCTAssertNotNil(errorFetchOfData)
    }
    
    // searchButtonPressed: false
    func testFetchOfData2() {
        // arrange - подготовка (дано)
        var boolChecked: Bool!
        var errorFetchOfData: AFError?
        
        // act - выполнение тестируемого кода
        sut.fetchOfData(with: "", searchButtonPressed: false) { arrayImagesIsEmpty in
            boolChecked = arrayImagesIsEmpty
        } errorCompletion: { error in
            errorFetchOfData = error
        }
        
        // assert - проверка
        XCTAssertTrue(boolChecked)
        XCTAssertNotNil(errorFetchOfData)
    }
    
    
    
}
