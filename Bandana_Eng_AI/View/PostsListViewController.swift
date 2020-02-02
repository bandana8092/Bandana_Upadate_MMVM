//
//  ViewController.swift
//  Bandana_Eng_AI
//
//  Created by satish pullagura on 02/02/20.
//  Copyright © 2020 Bandana. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)
class PostsListViewController: UIViewController {
    @IBOutlet weak var postsTableView: UITableView!
    var viewModel: PostsViewModel!
    var spinner: UIActivityIndicatorView!
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "PostsTableViewCell", bundle: nil)
        postsTableView.register(nib, forCellReuseIdentifier: "PostsTableViewCell")
        postsTableView.estimatedRowHeight = 60
        viewModel = PostsViewModel()
        self.postsTableView.tableFooterView = UIView()
        spinner = self.setupSpinnerWith(style: .large)
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing Data")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        postsTableView.addSubview(refreshControl)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            guard Reachability.isConnectedToNetwork() else {
                showAlertWith(message: "Please connecr to internet and try again")
                return
            }
            self.showSpinnerAt(destination: .center, spinner: self.spinner!)
            self.fetchPostss()
        }
        @objc func refresh(sender: AnyObject) {
            guard Reachability.isConnectedToNetwork() else {
                showAlertWith(message: "Please connecr to internet and try again")
                return
            }
            viewModel.pageNo = 1
            self.fetchPostss()
            viewModel.selectedPostsCount = 0
            self.title = "\(viewModel.selectedPostsCount)"
        }
        func fetchPostss() {
            viewModel.fetch { [weak self] in
                DispatchQueue.main.async {
                    self?.hideSpinner(spinner: self!.spinner!)
                    if self?.refreshControl.isRefreshing ?? true {
                        self?.refreshControl.endRefreshing()
                    }
                    self?.postsTableView.reloadData()
                }
            }
        }
    }

    @available(iOS 13.0, *)
    extension PostsListViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.posts.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "PostsTableViewCell", for: indexPath) as? PostsTableViewCell)!
            cell.selectionStyle = .none
            cell.updateCellOutlets(model: viewModel.posts[indexPath.row])
            return cell
        }
    }
    @available(iOS 13.0, *)
    extension PostsListViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if indexPath.row == viewModel.posts.count - 1 {
                if viewModel.pageNo < viewModel.totalPageNo {
                    viewModel.pageNo += 1
                    self.showSpinnerAt(destination: .bottom, spinner: self.spinner!)
                    self.fetchPostss()
                }
            }
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            viewModel.posts[indexPath.row].isOn = !viewModel.posts[indexPath.row].isOn
            let indexpath = IndexPath.init(row: indexPath.row, section: 0)
            self.postsTableView.reloadRows(at: [indexpath], with: .none)
            viewModel.selectedPostsCount = viewModel.posts.filter { ($0 as Posts).isOn == true}.count
            self.title = "\(viewModel.selectedPostsCount)"
        }
    }



