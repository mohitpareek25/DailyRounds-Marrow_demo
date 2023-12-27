//
//  MedBookDetailsViewController.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 27/12/23.
//

import UIKit

protocol MedBookDetailsViewModeling {
    var onSuccessHandler: ((MedBookDetailsModel?) -> Void)? { get set }
    var onErrorHandler: ((String) -> Void)? { get set }
    func fetchBookDetails(with key: String)
    
}

struct MedBookDetailsViewDataModel {
    let key: String
    let image: String
    let author: String
}

class MedBookDetailsViewController: UIViewController {

    private var viewModel: MedBookDetailsViewModeling
    private let dataModel: MedBookDetailsViewDataModel
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    private var apimodel: MedBookDetailsModel?
    // MARK: - IBOutlets
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishedDate: UILabel!
    @IBOutlet weak var detailsTxtView: UITextView!
    
    @IBOutlet weak var loadingView: UIView!
    
    // MARK: - Intializers
    init(_ viewModel: MedBookDetailsViewModeling, datamodel: MedBookDetailsViewDataModel) {
        self.viewModel = viewModel
        self.dataModel = datamodel
        super.init(nibName: Constants.MedBookDetails.viewController, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHandlers()
        configureUI()
        showActivityIndicator()
        viewModel.fetchBookDetails(with: dataModel.key)
    }
    
    
    @IBAction func closeBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func bookMarkBtnPressed(_ sender: UIButton) {
        guard let model = apimodel, let title = model.title else { return }
        DataManager.shared.saveBookDetails(name: title, authorName: dataModel.author, image: dataModel.image, key: dataModel.key)
    }
    
    
    private func setupHandlers() {
        viewModel.onSuccessHandler = { [weak self] model in
            guard let self = self else { return }
            
            if let model {
                // remove loader and show data
                apimodel = model
                DispatchQueue.main.async {
                    self.titleLabel.text = model.title ?? "__"
                    self.detailsTxtView.text = model.description ?? "Not available at this moment"
                    self.publishedDate.text = model.date ?? "N.A"
                    self.hideActivityIndicator()
                }
                // remove loader and show data
                
            }
            
        }
        
        viewModel.onErrorHandler = { [weak self] error in
            guard let self = self else { return }
            debugPrint(error)
        }
    }
    
    
    private func configureUI() {
        ImageLayer.loadImage(from: "https://covers.openlibrary.org/b/id/\(dataModel.image)-M.jpg", completion: { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.bookImageView.image = image
            }
        })
        authorLabel.text = dataModel.author
    }

}

extension MedBookDetailsViewController {
    func showActivityIndicator() {
            activityIndicator.center = loadingView.center
            activityIndicator.startAnimating()
            view.addSubview(activityIndicator)
        }

        func hideActivityIndicator() {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            loadingView.isHidden = true
            
        }
}
