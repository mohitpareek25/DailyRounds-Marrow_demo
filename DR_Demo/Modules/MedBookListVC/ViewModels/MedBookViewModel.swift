//
//  MedBookViewModel.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 16/12/23.
//

import Foundation

class MedBookViewModel: MedBookListViewModeling {
    enum SortingType {
        case title
        case average
        case hits
        case none
    }
    
    var onSuccessStateHandler: ((Bool) -> Void)?
    var onErrorStateHandler: ((String) -> Void)?
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
    
    func fetchBooksDataFromAPI(for bookName: String, with offSet: Int = 0) {
        guard let url = URL(string: "https://openlibrary.org/search.json") else {
            onErrorStateHandler?("Server error")
            return
        }
        
        guard !isLoading else {
            onErrorStateHandler?("Still Loading the data....")
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
                self?.onErrorStateHandler?("Some error occured")
                return
            }
            
            defer { self.isLoading = false }

            switch result {
            case .success(let result):
                configureData(data: result)
                onSuccessStateHandler?(true)
            case .failure(let error):
                print("Error: \(error)")
                onErrorStateHandler?(error.localizedDescription)
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
                                               ratingsCount:  _model.ratings_count ?? 0 > 0 ? String(_model.ratings_count ?? 0) : "N.A",
                                               ratingsAverage: _model.ratings_average?.truncateZeros() ?? "N.A",
                                               authorName: _model.author_name?.first ?? "",
                                               coverImage: String(_model.cover_i ?? 0),
                                               key: _model.key ?? "")
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
        fetchBooksDataFromAPI(for: currentSearchQuery, with: offSet)
        completion()
    }
    
    func canPaginate() -> Bool {
        offSet = offSet + 20
        if offSet <= totalLimit {
            return true
        }
        return false
    }
}
