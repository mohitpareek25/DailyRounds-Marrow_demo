//
//  CustomHeaderTableViewCell.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 17/12/23.
//

import UIKit

class CustomHeaderTableViewCell: UITableViewHeaderFooterView {
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sepratorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = view.bounds.size.width / 2
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(title)
        contentView.addSubview(sepratorView)
        
        NSLayoutConstraint.activate([
            sepratorView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            sepratorView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            sepratorView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            sepratorView.widthAnchor.constraint(equalToConstant: 3),
            title.centerYAnchor.constraint(equalTo: sepratorView.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: sepratorView.leadingAnchor, constant: 15),
            title.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15)
        ])
    }
    
    func setTitle(value: String?) {
        guard let title = value else { return }
        self.title.text = title
    }
}
