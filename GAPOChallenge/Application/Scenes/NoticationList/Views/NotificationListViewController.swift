//
//  NotificationListViewController.swift
//  GAPOChallenge
//
//  Created by Nguyen Dinh Hoang on 5/19/22.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

class NotificationListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBarContainer: UIView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let bag = DisposeBag()
    
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
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }

    private func setupViews() {
        setupSearchController()
        setupTableView()
    }

}



extension NotificationListViewController {
    private func setupTableView() {
        tableView.register(nibWithCellClass: NotificationItemCell.self)
        let dataSource = RxTableViewSectionedReloadDataSource<NotificationSectionData> { dataSource, tableView, indexPath, itemViewModel in
            let cell = tableView.dequeueReusableCell(withClass: NotificationItemCell.self)
            cell.bind(itemViewModel)
            return cell
        }

        viewModel.notifications
            .map { return [NotificationSectionData(items: $0)] }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
           
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


