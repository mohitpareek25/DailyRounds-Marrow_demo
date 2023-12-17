//
//  MedBookViewModel.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 16/12/23.
//

import Foundation

protocol MedBookListViewModeling: AnyObject {
    var count: Int { get }
    var onSuccessStateHandler: ((Bool) -> Void)? { get set }
    
    func fetchBooksDataFromAPI(for bookName: String, with offset: Int, completion: @escaping () -> Void)
    func sortByTitle(completion: @escaping () -> Void)
    func sortByAverage(completion: @escaping () -> Void)
    func sortByHits(completion: @escaping () -> Void)
    func doPaggination(completion: @escaping () -> Void)
    func getInfo(for index: Int) -> BooksListTableViewCellModelProtocol?
    func dataFlushOut(for bookName: String)
}


class MedBookViewModel: MedBookListViewModeling {
    enum SortingType {
        case title
        case average
        case hits
        case none
    }
    
    var onSuccessStateHandler: ((Bool) -> Void)?
    var limit: Int = 20
    var totalLimit: Int = 0
    var offSet: Int = 0
    var docs: [Docs] = [Docs]()
    var finalData: [Docs]  = [Docs]()
    var isLoading: Bool = false
    var pageSize: Int = 10
    var currentSearchQuery = "" // Track the current search query
    let networkLayer: NetworkLayerServiceable
    
    var sortingType: SortingType = .none

    var count: Int {
        return finalData.count
    }
    
    
    init(networkLayer: NetworkLayerServiceable) {
        self.networkLayer = networkLayer
    }
    
    func fetchBooksDataFromAPI(for bookName: String, with offSet: Int = 0, completion: @escaping () -> Void) {
        guard let url = URL(string: "https://openlibrary.org/search.json") else {
            completion()
            return
        }
        
        guard !isLoading else {
            completion()
            return
        }
        
        isLoading = true
        self.offSet = offSet

        // Clear previous results if the search query changed
        if bookName != currentSearchQuery {
            dataFlushOut(for: bookName)
        }
        
        let queryParams: [String: Any] = ["title": bookName, "limit": String(limit), "offset": offSet]
        let apiRequest = APIRequest(url: url, method: .GET, headers: nil, queryParams: queryParams, body: nil)
        
        networkLayer.dataTask(apiRequest) { [weak self] (_ result: Result<Books, NetworkError>) in
            guard let self = self else {
                completion()
                return
            }
            
            defer { self.isLoading = false }

            switch result {
            case .success(let result):
                configureData(data: result)
                onSuccessStateHandler?(true)
                completion()
            case .failure(let error):
                print("Error: \(error)")
                completion()
            }
        }
    }
    
    private func configureData(data: Books) {
        guard let _docs = data.docs else { return }
        
        self.totalLimit = data.numFound ?? 0
        self.docs.append(contentsOf: _docs)
        
        switch sortingType {
        case .title:
            finalData = docs.sorted{ $0.title ?? "" < $1.title ?? ""}
        case .average:
            finalData = docs.sorted{ $0.ratings_average ?? 0.0 < $1.ratings_average ?? 0.0 }
        case .hits:
            finalData = docs.sorted{ $0.ratings_count ?? 0 < $1.ratings_count ?? 0 }
        case .none:
            finalData = docs
        }
    }
    
    func dataFlushOut(for bookName: String) {
        docs.removeAll()
        finalData.removeAll()
        currentSearchQuery = bookName
    }
            
    func getInfo(for index: Int) -> BooksListTableViewCellModelProtocol? {
        if finalData.count > 0 {
            let _model = finalData[index]
            return BooksListTableViewCellModel(bookTitle: _model.title ?? "",
                                               ratingsCount: String(_model.ratings_count ?? 0),
                                               ratingsAverage: _model.ratings_average?.truncateZeros() ?? "0",
                                               authorName: _model.author_name?.first ?? "",
                                               coverImage: String(_model.cover_i ?? 0))
        }
        
        return nil
    }
    
    func sortByTitle(completion: @escaping () -> Void) {
        sortingType = .title
        finalData = docs.sorted{ $0.title ?? "" < $1.title ?? ""}
        completion()
    }
    
    func sortByAverage(completion: @escaping () -> Void) {
        sortingType = .average
        finalData = docs.sorted{ $0.ratings_average ?? 0.0 < $1.ratings_average ?? 0.0 }
        completion()
    }
    
    func sortByHits(completion: @escaping () -> Void) {
        sortingType = .hits
        finalData = docs.sorted{ $0.ratings_count ?? 0 < $1.ratings_count ?? 0 }
        completion()
    }
    
    func doPaggination(completion: @escaping () -> Void) {
        offSet = offSet + 20
        fetchBooksDataFromAPI(for: currentSearchQuery, with: offSet, completion: completion)
    }
}