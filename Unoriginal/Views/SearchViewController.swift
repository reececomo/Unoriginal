//
//  SearchViewController.swift
//  Unoriginal
//
//  Created by Reece Como on 11/8/18.
//  Copyright © 2018 Hubrio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

///
/// Search page view controller
///

final class SearchViewController: UIViewController, StoryboardViewController {
    
    // MARK: - IBOutlets
    
    /// Search bar
    @IBOutlet weak var searchBar: UISearchBar!
    
    /// Table view
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    /// Search provider
    private var searchProvider = SearchProvider()
    
    /// Dispose bag (Rx)
    private let disposeBag = DisposeBag()
    
    private var results = [GitHubRepo]()
    
    // MARK: - UIViewController
    
    /// Preferred status bar style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    /// View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Black status bar
        navigationController?.setNavigationBarHidden(true, animated: false)
    
        // Setup tableview
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Setup searchbar
        searchBar.placeholder = "Search for repositories"
        searchBar.enablesReturnKeyAutomatically = true
        bindSearchBar()
    }
    
    // MARK: - Methods
    
    func bindSearchBar() {
        searchBar.rx.text.orEmpty
            .debounce(0.3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { query in
            if query.count < 3 {
                self.results = []
                self.tableView.reloadData()
                Logger().info(query)
                return
            }
            
            Logger().info("Updating text...")
            self.search()
        }, onError: { error in
            Logger().error(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    func search() {
        searchProvider.searchRepositories(query: self.searchBar.text ?? "", language: nil)
            .subscribe(onSuccess: { repos in
                self.updateTable(repos)
            }, onError: { error in
                Logger().error(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    func updateTable(_ repos: [GitHubRepo]) {
        results = repos
        tableView.reloadData()
    }
    
}

extension SearchViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    /// Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    /// Configure cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as? SearchResultCell else {
            fatalError("Unable to configure search result cell")
        }
        let row = indexPath.row
        
        cell.labelTitle.text = results[row].name
        cell.labelFullName.text = results[row].fullName
        cell.labelSummary.text = results[row].description
    
        return cell
    }
    
}
