//
//  ErrorMessages.swift
//  GithubNG
//
//  Created by Mac on 4.12.2022.
//

import Foundation


enum NGError: String, Error {
    case invalidUsername = "Invalid username. Please try again."
    case unableToComplete = "Request hasn't been completed."
    case invalidResponse = "HTTP Response error."
    case invalidData = "Data received from server but data is invalid."
    case unableToFavorite = "There was an error favoriting this user. Please try again."
    case alreadInFavorites = "You have already favorited this user."
}
