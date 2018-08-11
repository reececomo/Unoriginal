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
    
    /// Empty tableView -- strong so it doesnt get dereferenced
    @IBOutlet var emptyView: UIView!
    
    // MARK: - Properties
    
    /// Search provider
    private var searchProvider = SearchProvider()
    
    /// Dispose bag (Rx)
    private let disposeBag = DisposeBag()
    
    private var results = [Repo]()
    
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
        tableView.keyboardDismissMode = .onDrag
        tableView.tableFooterView = UIView()
        
        // Setup searchbar
        searchBar.placeholder = "Search for repositories"
        searchBar.enablesReturnKeyAutomatically = true
        bindSearchBar()
    }
    
    /// View did appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Focus on search bar
        searchBar.becomeFirstResponder()
    }
    
    // MARK: - Methods
    
    func bindSearchBar() {
        searchBar.rx.text.orEmpty
            .debounce(0.3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { query in
            if query.count < 3 {
                self.results = []
                self.reloadData()
                Logger().info(query)
                return
            }
            
            Logger().info("Updating text...")
            self.search(query: query)
        }, onError: { error in
            Logger().error(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    func search(query: String) {
        searchProvider.searchRepositories(query: query, language: nil)
            .subscribe(onNext: { repos in
                self.updateTable(repos)
                return
            }, onError: { error in
                Logger().error(error.localizedDescription)
                return
            }).disposed(by: disposeBag)
    }
    
    func updateTable(_ repos: [Repo]) {
        results = repos
        reloadData()
    }
    
    func reloadData() {
        tableView.reloadData()
        
        if results.isEmpty {
            // Show message
            emptyView.isHidden = false
            view.bringSubview(toFront: emptyView)
        } else {
            // Hide message
            emptyView.isHidden = true
            view.sendSubview(toBack: emptyView)
        }
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
        
        let repo = results[indexPath.row]
        
        cell.labelTitle.text = repo.name
        cell.labelFullName.text = repo.fullName
        cell.labelSummary.text = repo.description
        cell.imageIcon.image = UIImage(named: "Hosts/\(repo.host)")
    
        return cell
    }
    
}
