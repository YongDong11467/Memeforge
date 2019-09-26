//
//  ViewController.swift
//  MemeForge
//
//  Created by APPLE on 9/24/19.
//  Copyright © 2019 Bong. All rights reserved.
//

import UIKit
import AlamofireImage

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var memeTableView: UITableView!
    var memes = [Meme]() {
        didSet {
            DispatchQueue.main.async {
                self.memeTableView.reloadData()
            }
        }
    }
    //var memesCount = 20;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeTableView.delegate = self
        memeTableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: .valueChanged)
        memeTableView.refreshControl = refreshControl
        
        fetchMemes()
        
    }
    
    func fetchMemes() {
        NetworkManager().getMemes { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let memes):
                self?.memes = memes
                
                DispatchQueue.main.async {
                    self?.memeTableView.reloadData()
                }
            }
        }
    }
    
    @objc private func refreshControlAction(_ refreshControl: UIRefreshControl) {
        fetchMemes()
        refreshControl.endRefreshing()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell", for: indexPath) as! MemeCell
        
        let meme = memes[indexPath.row]
        cell.memeTitle.text = meme.name
        guard let url = URL(string: meme.url) else { return cell }
        cell.memeImage.af_setImage(withURL: url)
        return cell
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var frame = cell.contentView.frame
        
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
            frame.origin.x = -100
            cell.contentView.frame = frame
        }) { (success) in
            frame.origin.x = 0
            cell.contentView.frame = frame
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = memeTableView.indexPath(for: cell)!
        let meme = memes[indexPath.row]
        let memeViewController = segue.destination as! MemeViewController
        memeViewController.meme = meme
        memeTableView.deselectRow(at: indexPath, animated: true)
    }
}

