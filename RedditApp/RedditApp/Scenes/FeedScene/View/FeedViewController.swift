//
//  ViewController.swift
//  RedditApp
//
//  Created by iceice on 2/13/21.
//

import UIKit

class FeedViewController: UIViewController, Storyboarded {
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Post>
    typealias DataSource = UITableViewDiffableDataSource<Section, Post>
    
    enum Section {
        case main
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private var refreshControl: UIRefreshControl?
    private lazy var presenter = FeedViewPresenter(view: self)
    
    var coordinator: Coordinator?
    
    var totalPosts = 0
    
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureTableDataSource()
        presenter.loadView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func configureTableView() {
        let postCellNib = UINib(nibName: String(describing: PostCell.self), bundle: nil)
        
        tableView.register(postCellNib, forCellReuseIdentifier: PostCell.identifier)
        tableView.delegate = self
        tableView.prefetchDataSource = self
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
    }
    
    private func configureTableDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, post) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as! PostCell
            cell.configure(with: post)
            
            return cell
        })
    }
    
    private func showPosts(posts: [Post]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(posts)
        dataSource.apply(snapshot, animatingDifferences: true)
        
        totalPosts = posts.count
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension FeedViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if (totalPosts != 0 && indexPaths.last!.row == totalPosts - 1) {
            self.presenter.nextPageNeeded()
        }
    }
}

extension FeedViewController: FeedView {
    func showPosts(_ posts: [Post], animated: Bool) {
        showPosts(posts: posts)
    }
    
    func showLoadingIndicator() {
        
    }
    
    func hideLoadingIndicator() {
        
    }
    
    func hideRefreshIndicator() {
        
    }
    
    func showError(message: String) {
        
    }
    
}

