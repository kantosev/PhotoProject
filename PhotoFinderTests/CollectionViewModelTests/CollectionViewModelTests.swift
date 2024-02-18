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
    var sut1: CollectionViewModel!
    var sut2: CollectionViewModel!
    
    /// Тестовый stub объект
    var networkManagerStub: NetworkManagerProtocol!
    var networkManagerStub2: NetworkManagerProtocol!

    
    override func setUp() {
        super.setUp()
        networkManagerStub = NetworkManagerStub()
        networkManagerStub2 = NetworkManagerStub2()
        sut1 = CollectionViewModel(networkManager: networkManagerStub)
        sut2 = CollectionViewModel(networkManager: networkManagerStub2)
    }
    
    override func tearDown() {
        networkManagerStub = nil
        networkManagerStub2 = nil
        sut1 = nil
        sut2 = nil
        super.tearDown()
    }
    
    
    // searchButtonPressed: true
    func testFetchOfData1() {
        // arrange - подготовка (дано)
        var boolChecked: Bool!
        
        // act - выполнение тестируемого кода
        sut1.fetchOfData(with: "", searchButtonPressed: true) { result in
            
            switch result {
            case .success(let arrayImagesIsEmpty):
                boolChecked = arrayImagesIsEmpty
            case .failure(_):
                XCTFail()
            }
            
    
            // assert - проверка
            XCTAssertTrue(boolChecked)
        }
    }
    
    // searchButtonPressed: false
    func testFetchOfData2() {
        // arrange - подготовка (дано)
        var errorFetchOfData: Error?
        
        // act - выполнение тестируемого кода
        sut2.fetchOfData(with: "", searchButtonPressed: false) { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                errorFetchOfData = error
            }
            
            // assert - проверка
            XCTAssertNotNil(errorFetchOfData)
        }
        
        
    }
}

