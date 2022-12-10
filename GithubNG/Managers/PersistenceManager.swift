//
//  PersistenceManager.swift
//  GithubNG
//
//  Created by Mac on 10.12.2022.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWidth(favorite: Follower, actionType: PersistenceActionType, completed: @escaping(NGError?) -> Void) {
        retreiveFavorites { result in
            switch result {
            case .success(let favorites):
                var retreviedFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retreviedFavorites.contains(favorite) else {
                        completed(.alreadInFavorites)
                        return
                    }
                    
                    retreviedFavorites.append(favorite)
                case .remove:
                    retreviedFavorites.removeAll {
                        $0.login == favorite.login
                    }
                }
                
                completed(save(favorites: retreviedFavorites))
            case .failure(let error):
               completed(error)
            }
        }
    }
    
    static func retreiveFavorites(completed: @escaping(Result<[Follower], NGError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }

    }
    
    static func save(favorites: [Follower]) -> NGError? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
