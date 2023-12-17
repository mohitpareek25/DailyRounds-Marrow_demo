//
//  MedBookListViewController.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 15/12/23.
//

import UIKit


class MedBookListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var sortingView: UIView! {
        didSet {
            sortingView.isHidden = true
        }
    }
    private var viewModel: MedBookListViewModeling
    
    
    init(_ viewModel: MedBookListViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: Constants.MedBooks.viewController, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHandlers()
        setupUI()
        registerTableView()
    }
    
    private func setupUI() {
        SegmentControlValueChanged(segmentControl)
    }
    
    private func registerTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.MedBooks.TableView.booksListCell, bundle: Bundle.main), forCellReuseIdentifier:Constants.MedBooks.TableView.booksListCell)
        tableView.register(CustomHeaderTableViewCell.self, forHeaderFooterViewReuseIdentifier: Constants.MedBooks.TableView.customHeaderCell)
    }
    
    let spinner: UIActivityIndicatorView = {
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.hidesWhenStopped = true
            return spinner
        }()
    
    func fetchBooks(for query: String = "") {
        viewModel.fetchBooksDataFromAPI(for: query, with: 0) { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setUpHandlers() {
        viewModel.onSuccessStateHandler = { [weak self] success in
            guard let self else { return }
            if success {
                DispatchQueue.main.async {
                    self.updateUI()
                }
            }
        }
    }
    
    private func updateUI() {
        if viewModel.count > 0 {
            // show the view
            sortingView.isHidden = false
        } else {
            // hide the view
            sortingView.isHidden = true
        }
        
        tableView.reloadData()
    }
    
    func titleSorting() {
        viewModel.sortByTitle {
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    
    func averageSorting() {
        viewModel.sortByAverage {
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    
    func hitsSorting() {
        viewModel.sortByHits {
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    
    @IBAction func SegmentControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            titleSorting()
        case 1:
            averageSorting()
        case 2:
            hitsSorting()
        default:
            titleSorting()
        }
    }
}


//MARK: - Table View
extension MedBookListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BooksListTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.MedBooks.TableView.booksListCell, for: indexPath) as! BooksListTableViewCell
        cell.configureUI(with: viewModel.getInfo(for: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let numberOfSections = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: numberOfSections) - 3
        
        if indexPath.row == lastRowIndex {
            spinner.startAnimating()
            spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44.0)
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
            self.viewModel.doPaggination {
                DispatchQueue.main.async {
                    self.updateUI()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.MedBooks.TableView.customHeaderCell) as! CustomHeaderTableViewCell
        return view
    }
    
    
}

//MARK: - Search Bar
extension MedBookListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("%%%%%%%%% SEARCH TEXT: ", searchText)
        if searchText.count < 3 {
            viewModel.dataFlushOut(for: "")
            updateUI()
        } else if searchText.count >= 3 {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
            perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.75)
        }
    }
    @objc func reload(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            print("nothing to search")
            return
        }
        fetchBooks(for: query)
    }
}
