//
//  NotificationListViewController.swift
//  GAPOChallenge
//
//  Created by Nguyen Dinh Hoang on 5/19/22.
//

import UIKit

class NotificationListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBarContainer: UIView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    typealias Factory = ViewModelFactory
    private let viewModel: NotificationListViewModel!
    
    init(factory: Factory) {
        self.viewModel = factory.makeNotificationListViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

    private func setupViews() {
        setupSearchController()
    }

}

extension NotificationListViewController {
    private func setupTableView() {
        tableView.delegate
    }
    
    private func setupSearchController() {
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = true
        searchController.searchBar.barStyle = .default
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.frame = searchBarContainer.bounds
        searchController.searchBar.autoresizingMask = [.flexibleWidth]
        searchBarContainer.addSubview(searchController.searchBar)
        definesPresentationContext = true
    }
}

extension NotificationListViewController: UISearchBarDelegate {
    
}

extension NotificationListViewController: UISearchControllerDelegate {
    
}


