//
//  UnsplashApiTestCase.swift
//  LeBaluchonTests
//
//  Created by Manon Russo on 23/04/2021.
//

import XCTest
@testable import LeBaluchon

class UnsplashApiTestCase: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    func testGetPhotoShouldPostFailedCompletionIfError() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
     //Given:
        let photoService = UnsplashAPI (
            urlSession: URLSessionFake(data: nil, response: nil, error: FakeReponseData.error))
        //When:
        photoService.fetchPhotoDataFor(photoService.lyonAlbumId) { (result) in
            //Then:
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
        }
    }

    func testGetPhotoShouldPostFailedCompletionIfNoData() throws {
        // Given:
        let photoService = UnsplashAPI (
            urlSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When:
        photoService.fetchPhotoDataFor(photoService.lyonAlbumId) { (result) in
            // Then:
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetPhotoShouldPostFailedCompletionIfIncorrectResponse() throws {
        // Given:
        let photoService = UnsplashAPI (
            urlSession: URLSessionFake(data: FakeReponseData.unsplashCorrectData, response: FakeReponseData.responseK0, error: nil))
        
        // When:
        photoService.fetchPhotoDataFor(photoService.lyonAlbumId) { (result) in
            // Then:
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetPhotoShouldPostFailedCompletionIfIncorrectData() throws {
        // Given:
        let photoService = UnsplashAPI (
            urlSession: URLSessionFake(data: FakeReponseData.incorrectData, response: FakeReponseData.responseOK, error: nil))
        
        // When:
        photoService.fetchPhotoDataFor(photoService.lyonAlbumId) { (result) in
            // Then:
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetCurrencyShouldPostSuccessCompletionIfNoErrorAndCorrectData() throws {
        // Given:
        let photoService = UnsplashAPI (
            urlSession: URLSessionFake(data: FakeReponseData.unsplashCorrectData, response: FakeReponseData.responseOK, error: nil))
        
        // When:
        photoService.fetchPhotoDataFor(photoService.lyonAlbumId) { (result) in
            // Then:
            guard case .success(let success) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            let regular = "https://images.unsplash.com/photo-1530282279139-9cfdae52582f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMjM0NzN8MHwxfGNvbGxlY3Rpb258MXw0MjY4MDR8fHx8fDJ8fDE2MTkxOTIxMjY&ixlib=rb-1.2.1&q=80&w=1080"
            XCTAssertNotNil(success)
            XCTAssertEqual(regular, success[0].urls.regular)

        }
    }
    
}
