//
//  MedBookDetailsViewModel.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 27/12/23.
//

import Foundation

struct MedBookDetailsModel {
    var description: String?
    var date: String?
    var title: String?
}

class MedBookDetailsViewModel: MedBookDetailsViewModeling {
    var onSuccessHandler: ((MedBookDetailsModel?) -> Void)?
    
    var onErrorHandler: ((String) -> Void)?
    let networkLayer: NetworkLayerServiceable
    
    // MARK: - Initializers
    init(networkLayer: NetworkLayerServiceable) {
        self.networkLayer = networkLayer
    }
    
    
    func fetchBookDetails(with key: String) {
        let fullUrl = "https://openlibrary.org/" + key + ".json"
        guard let url = URL(string: fullUrl) else {
            onErrorHandler?("Server error")
            return
        }
        
        let queryParams: [String: Any] = [:]
        let apiRequest = APIRequest(url: url, method: .GET, headers: nil, queryParams: queryParams, body: nil)
        
        networkLayer.dataTask(apiRequest) { [weak self] (_ result: Result<NovelDetails, NetworkError>) in
            guard let self = self else {
                self?.onErrorHandler?("Some error occured")
                return
            }

            switch result {
            case .success(let result):
                onSuccessHandler?(configureData(data: result))
            case .failure(let error):
                print("Error: \(error)")
                onErrorHandler?(error.localizedDescription)
            }
        }
    }
    
    
    private func configureData(data: NovelDetails) -> MedBookDetailsModel? {
        return MedBookDetailsModel(description: data.description?.value, date: data.first_publish_date, title: data.title)
    }
    
    
}
