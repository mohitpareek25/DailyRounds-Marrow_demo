//
//  BooksListTableViewCell.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 16/12/23.
//

import UIKit

protocol BooksListTableViewCellModelProtocol {
    var bookTitle: String { get }
    var ratingsCount: String { get }
    var ratingsAverage: String { get }
    var authorName: String { get }
    var coverImage: String { get }
}

struct BooksListTableViewCellModel: BooksListTableViewCellModelProtocol {
    var bookTitle: String
    var ratingsCount: String
    var ratingsAverage: String
    var authorName: String
    var coverImage: String
}

class BooksListTableViewCell: UITableViewCell {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var ratingAverageCount: UILabel!
    @IBOutlet weak var ratingCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    override func prepareForReuse() {
        bookTitle.text = ""
        authorName.text = ""
        ratingAverageCount.text = ""
        ratingCount.text = ""
        bookImage.image = UIImage(named: "book")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func setupUI() {
        outerView.layer.cornerRadius = 10.0
        outerView.layer.masksToBounds = true
        
        bookImage.layer.cornerRadius = 10.0
        bookImage.layer.masksToBounds = true
    }
    
    func configureUI(with model: BooksListTableViewCellModelProtocol?) {
        guard let model else { return }
        
        bookTitle.text = model.bookTitle
        authorName.text = model.authorName
        ratingAverageCount.text = model.ratingsAverage
        ratingCount.text = model.ratingsCount
        
        ImageLayer.loadImage(from: "https://covers.openlibrary.org/b/id/\(model.coverImage)-M.jpg") { image in
            self.bookImage.image = image
        }
    }
}
