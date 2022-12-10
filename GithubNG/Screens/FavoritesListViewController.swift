//
//  FavoritesListViewController.swift
//  GithubNG
//
//  Created by Mac on 3.12.2022.
//

import UIKit

class FavoritesListViewController: UIViewController {
    
   let tableView = UITableView()
    var favorites : [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        navigationController?.isNavigationBarHidden = false
        title = "Favorites"
        
        getFavorites()
        configureTableView()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    func getFavorites() {
        PersistenceManager.retreiveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                
                if favorites.isEmpty {
                    self.showNoUserFoundView(with: "No favorites found?\nAdd one on the follower screen.", in: self.view)
                } else {
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                
            case .failure(let error):
                break
            }
        }
    }

    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.reuseIdentifier)
    }
   

}

extension FavoritesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.reuseIdentifier) as! FavoritesTableViewCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowersListViewController()
        destVC.username = favorite.login
        destVC.title = favorite.login
        
        navigationController?.pushViewController(destVC, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        
        PersistenceManager.updateWidth(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                return
            }
            self.presentNGAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "I got it.")
        }
    }
    
}
