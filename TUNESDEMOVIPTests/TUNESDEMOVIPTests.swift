//
//  TUNESDEMOVIPTests.swift
//  TUNESDEMOVIPTests
//
//  Created by Nidhi Joshi on 04/05/2021.
//

import XCTest
@testable import TUNESDEMOVIP

class TUNESDEMOVIPTests: XCTestCase {

    let urlString = "https://itunes.apple.com/search?term=tree&entity=podcast"
    lazy var searchScreenList = SearchScreenViewController.create(of: .main)
    lazy var listController = ListingScreenViewcontroller.create(of: .main)
    lazy var detailController = DetailScreenViewController.create(of: .main)
    lazy var mediaController = MediaListViewController.create(of: .main)
    var data: [Section]?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testCallToiTunesCompletes() {
        let session: URLSession = URLSession(configuration: .default)
        
        let url = URL(string: urlString)
        
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = session.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            // 2
            promise.fulfill()
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    func testFetchData() {
        let apiExpectation = expectation(description: "")
        
        ServiceWorker().fetchMedia(url: urlString) { (response: Result<ResultData, Error>) in
            switch response {
            case .failure(let error):
                print(error)
            case .success(let list):
                XCTAssertGreaterThan(list.convertMediaToSections()?.count ?? 0, 0)
                apiExpectation.fulfill()
            }
        }
        wait(for: [apiExpectation], timeout: 30)
    }
    
    func testControllerHasCollectionView() {
        
        let controller = ListingScreenViewcontroller.create(of: .main)
        if controller == listController {
            XCTFail("Could not instantiate ListingScreenViewController from main storyboard")
        }
        
        controller.loadViewIfNeeded()
        
        XCTAssertNotNil(controller.listingCollectionView,
                        "Controller should have a collectionview")
        
        XCTAssertTrue(controller.listingCollectionView?.dataSource is ListingScreenViewcontroller,
                      "collectionview's data source should be a ListingScreenViewController")
        
        XCTAssertTrue(controller.listingCollectionView?.delegate is ListingScreenViewcontroller,
                      "collectionview's data source should be a ListingScreenViewController")
        
        XCTAssertTrue(controller.responds(to: #selector(controller.collectionView(_:didSelectItemAt:))))
        XCTAssertTrue(controller.conforms(to: UICollectionViewDataSource.self))
        XCTAssertTrue(controller.responds(to: #selector(controller.collectionView(_:numberOfItemsInSection:))))
        XCTAssertTrue(controller.responds(to: #selector(controller.collectionView(_:cellForItemAt:))))
        
    }
    func testcheckCamalized() {
        var string = "Music Video"
        string = string.replacingOccurrences(of: " ", with: "")
        XCTAssertEqual(string.camelized, "musicVideo")
        
    }
    
    func testValidHost() {
        let expected = expectation(description: "Check valid host")
        if Reachability.isConnectedToNetwork() {
            expected.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testImageWithStaticURL() throws {
        let expectation = self.expectation(description: "static url initializer")
        let imageUrl = URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Video/v4/ae/be/c8/aebec8f3-2baa-7708-1cb9-af064c5423a4/source/100x100bb.jpg")
        let imageView = UIImageView()
        imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholderImage")) { (image, error, _, _) in
            guard image != nil  else {
                XCTFail(error.debugDescription)
                return
            }
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testHeaderView() {
        if listController.presnter?.getSectionCount() ?? 0 > 0 {
            _ = listController.presnter?.getSection(0)
            
            listController.listingCollectionView?.reloadData()
            let section = listController.listingCollectionView?.dataSource?.numberOfSections?(in: listController.listingCollectionView ?? UICollectionView())
            
            XCTAssertEqual(section, listController.presnter?.getSectionCount())
            
        }
    }
    
    func testControllerHasTableView() {
        let controller = MediaListViewController.create(of: .main)
        if controller == mediaController {
            XCTFail("Could not instantiate MediaListViewController from main storyboard")
        }
        
        controller.loadViewIfNeeded()
        
        XCTAssertNotNil(controller.listMediaType,
                        "Controller should have a tableview")
        
        XCTAssertTrue(controller.listMediaType?.dataSource is MediaListViewController,
                      "TableView's data source should be a MediaListViewController")
        
        XCTAssertTrue(controller.listMediaType?.delegate is MediaListViewController,
                      "TableView's data source should be a MediaListViewController")
        
        XCTAssertTrue(controller.responds(to: #selector(controller.tableView(_:didSelectRowAt:))))
        XCTAssertTrue(controller.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(controller.responds(to: #selector(controller.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(controller.responds(to: #selector(controller.tableView(_:cellForRowAt:))))
        
    }
    
    func testListshowsMedia() {
        if mediaController.presnter?.getItemsCount() ?? 0 > 0 {
            let mediaCount = mediaController.presnter?.getItemsCount() ?? 0
            return XCTAssertGreaterThan(mediaCount, 0)
        }
        
    }
    
    func testTableViewCellCreateCellsWithReuseIdentifier() {
        let indexPath = IndexPath(row: 0, section: 0)
        guard  let list = mediaController.listMediaType else {
            return
        }
        let cell = list.dataSource?.tableView(list, cellForRowAt: indexPath)
        let expectedReuseIdentifier = String(format: "CELL", indexPath.section, indexPath.row)
        XCTAssertTrue((cell?.reuseIdentifier == expectedReuseIdentifier), "Table does not create reusable cells")
    }
    
    func testlistCollectionViewForGRIDCellCreateCellsWithReuseIdentifier() {
        let indexPath = IndexPath(row: 0, section: 0)
        listController.presnter?.displayMode = .grid
        
        let list = listController.listingCollectionView ?? UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        let kindString = UICollectionView.elementKindSectionHeader
        let header = list.dataSource?.collectionView?(list, viewForSupplementaryElementOfKind: kindString, at: indexPath) as? HeaderView
        header?.layoutSubviews()
        let section = listController.presnter?.getSection(0)
        XCTAssertEqual(header?.titleLabel.text, section?.sectionName)
        
    }
    
    func testReusIdentifier() {
        
        let indexPath = IndexPath(row: 0, section: 0)
        listController.presnter?.displayMode = .grid
        if  let list = listController.listingCollectionView {
            let cell = list.dataSource?.collectionView(list, cellForItemAt: indexPath)
            let expectedReuseIdentifier = String(format: Constant.mediaCellIdentifier, indexPath.section, indexPath.row)
            XCTAssertTrue((cell?.reuseIdentifier == expectedReuseIdentifier), "Table does not create reusable cells")
        }
    }
    
    class ListInteractor: ListingScreenInteractor {
      // MARK: Method call expectations
      
      var fetchMediaCalled = false
      
      // MARK: Spied methods
        override func updateStaus() {
            fetchMediaCalled = true
            submitRequest()
        }
    }
    
    // MARK: - Tests
    
    func testFetchMedia() {

        let interactor = ListInteractor()
        listController.interactor = interactor
      
      // When
        interactor.updateStaus()
        
        XCTAssert(interactor.fetchMediaCalled, "fetchMedia() should be updated")
        
    }
    func test_cell() {
        // given
        let list = mediaController.listMediaType ?? UITableView()
        
        // when
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = list.dataSource?.tableView(list, cellForRowAt: indexPath)
        
        // then
        XCTAssertEqual(cell?.textLabel?.text, mediaController.presnter?.getItemAtList(0))
        
        let headerTitle = "Songs"
        let header = HeaderView(frame: CGRect.zero)
        header.loadData(headerTitle)
        XCTAssertEqual(header.titleLabel.text, headerTitle)
        
        let media = listController.presnter?.getItemAtIndexInSection(0, 0)
        
        let mediaCell = MediaCell(frame: CGRect.zero)
        mediaCell.loadData(media: media)
        
        XCTAssertEqual(mediaCell.mediaTitle?.text, media?.trackCensoredName)
        detailController.presnter?.mediaItem = media
        detailController.setupVideo()
        let mediaSingleCell = MediaSingleCell(frame: CGRect.zero)
        mediaSingleCell.loadData(media: media)
        
        XCTAssertEqual(mediaSingleCell.mediaTitle?.text, media?.trackCensoredName)
        
        let tagCell = TagCell()
        let tagItem = "Artist"
        tagCell.loadData(searchItem: tagItem)
        
    }
    
    func testMediaInteractor() {
        let expectation = self.expectation(description: "fetchData")
        listController.interactor?.searchText = "Tree"
        listController.interactor?.urlList = ["song"]

        listController.interactor?.submitRequest()
        
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testHelper() {
        let string = "bOOK"
        let string2 = ""
        XCTAssertEqual(string.uppercasingFirst, "BOOK")
        XCTAssertEqual(string2.camelized, "")
    }
    
    func testMediaNavigation() {
        let router = MediaListRouter(navigator: UINavigationController())
        router.furtherRoot()
    }
    
    func testDetailScreenNavigation() {
        let router = DetailScreenRouter(navigator: UINavigationController())
        router.furtherRoot()
    }
    
    func testListNavigation() {
        let media = listController.presnter?.getItemAtIndexInSection(0, 0)
        let router = ListingScreenRouter(navigator: UINavigationController())
        router.navigateToDetailScreen(media)
    }
    
    func testSearchScreenNavigation() {
        let router = MediaListRouter(navigator: UINavigationController())
        router.furtherRoot()
    }
    
    func testlistCollectionViewForLISTCellCreateCellsWithReuseIdentifier() {
        let indexPath = IndexPath(row: 0, section: 0)
        listController.presnter?.displayMode = .list
        if  let list = listController.listingCollectionView {
            let cell = list.dataSource?.collectionView(list, cellForItemAt: indexPath)
            let expectedReuseIdentifier = String(format: Constant.mediaSingleCellIdentifier, indexPath.section, indexPath.row)
            XCTAssertTrue((cell?.reuseIdentifier == expectedReuseIdentifier), "Table does not create reusable cells")
        }
        
    }
    
    func testSearchScreenCoordinator() {
        searchScreenList.rounter = SearchScreenRouter(navigator: UINavigationController())
        listController.rounter = ListingScreenRouter(navigator: UINavigationController())
        
        let media = listController.presnter?.getItemAtIndexInSection(0, 0)

        XCTAssertNotNil(listController.rounter?.navigateToDetailScreen(media))
        XCTAssertNotNil(searchScreenList.btnMediaListClicked(UIButton()))
        XCTAssertNotNil(searchScreenList.btnSubmitClicked(UIButton()))
        XCTAssertNotNil(searchScreenList.btnSubmitClicked(UIButton()))
    }
    
    func testSegmentValue() {
        listController.displayModehasChanged(UISegmentedControl())
    }
    
    func testDetailViewControllerSetup() {
        detailController.presnter = DetailScreenPresenter()
        detailController.viewDidLoad()
        detailController.setupData()
        detailController.setupVideo()
        XCTAssertNotNil(detailController.playVideoClicked(UIButton()))
        XCTAssertTrue(detailController.responds(to: #selector(detailController.playVideoClicked(_:))))
    }

    func testListingScreenPresenter() {
        listController.setupCollectionView()

        let media = Media("Artist name", kind: "book")
        let section = Section(sectionName: "book", media: [media])
        let mediaItem = MediaItems(sectionList: [section])
        listController.presnter = ListingScreenPresenter()
        let presenter = listController.presnter
        presenter?.showMediaDetail(mediaItem)
        presenter?.mediaItems = mediaItem
        
        XCTAssertNotNil(presenter?.getSectionCount())
        XCTAssertNotNil(presenter?.getItemInSection(0))
        XCTAssertNotNil(presenter?.getItemAtIndexInSection(0, 0))
        XCTAssertNotNil(presenter?.getSection(0))
        XCTAssertNotNil(presenter?.getItemCountInSection(0))
        XCTAssertNotNil(presenter?.updateData([section]))
        
        let cell: MediaCell = listController.listingCollectionView?.cellForItem(at: IndexPath(row: 0, section: 0)) as? MediaCell ?? MediaCell()
        cell.loadData(media: media)
        
        XCTAssertEqual( cell.mediaItem?.trackCensoredName, media.trackCensoredName)
        
    }
    
    func testSearchScreenPresenter() {
        searchScreenList.presnter = SearchScreenPresenter()
        let presenter = searchScreenList.presnter
        
        XCTAssertNotNil(presenter?.showMediaList(mediaTypeList: []))
    }
    
    func testMediaListPresenter() {
    
        let dataLayer = MediaListData()
        
        mediaController.presnter = MediaListPresenter(dataLayer.getMediaTypeList())
        let presenter = mediaController.presnter
        
        XCTAssertNotNil(presenter?.getItemsList())
        XCTAssertNotNil(presenter?.getItemsCount())
        XCTAssertNotNil(presenter?.getSelectedList())
        XCTAssertNotNil(presenter?.getItemAtList(0))
        XCTAssertNotNil(presenter?.addItemToList("book"))
        XCTAssertNotNil(presenter?.showMediaList([""]))

        let interactor = MediaListInteractor()
        interactor.getMediaList()
    }
    
    class ClassUnderTest: MediaListViewController {
           var deinitCalled: (() -> Void)?
           deinit { deinitCalled?() }
       }
    
    func test_deinit() {
            let exp = expectation(description: "Viewcontroller has deinited")
        
            var medialist: ClassUnderTest?
            medialist = ClassUnderTest()
            medialist?.deinitCalled = {
                exp.fulfill()
            }
        
            DispatchQueue.global(qos: .background).async {
                medialist = nil
            }
           
            waitForExpectations(timeout: 10)
        }
}
