//
//  MainViewController.swift
//  TranslucentNavigationBar
//
//  Created by sujian on 2017/1/18.
//  Copyright © 2017年 sujian. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    fileprivate lazy var headerView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "headerview"))
        return imageView
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil) , forCellReuseIdentifier: "MainTableViewCell")
        tableView.tableHeaderView = self.headerView
    
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    fileprivate var feeds: [String] = {
        return (1...100).map({
            "cell \($0)"
        })
    }()
    
    var alpha: CGFloat = 1.0
    var showNavOffsetY: CGFloat = 400
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MainViewController"
        
        self.automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.backgroundDefualtColor
        
        navigationController?.navigationBar.barTintColor = UIColor.navigationBarColor
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.shadowImage = UIImage()
        
        
        
        view.addSubview(tableView)
        
        tableView.addObserver(self, forKeyPath: "contentOffset", options: [.prior], context: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        alpha = tableView.contentOffset.y / showNavOffsetY
        alpha = alpha > 1 ? 1 : alpha
        alpha = alpha < 0 ? 0 : alpha
        setNavSubViewsAlpha()
    }
    
    func setNavSubViewsAlpha() {
        navigationController?.navigationItem.titleView?.alpha = self.alpha
        
        if let view = navigationController?.navigationBar.subviews.first {
            view.alpha = alpha
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell
        cell?.textLabel?.text = feeds[indexPath.row]
        return cell!
    }
}
