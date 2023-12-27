//
//  BookmarksViewController.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 27/12/23.
//

import UIKit

class BookmarksViewController: UIViewController {
    
    @IBOutlet weak var bookMarksTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    private func setupTableView() {
//        bookMarksTableView.dataSource = self
//        bookMarksTableView.delegate = self
    }

}

//extension BookmarksViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//}
