//
//  APIError.swift
//  InfraLayerTask
//
//  Created by Mohamed Maged on 01/03/2023.
//

import Foundation

enum APIError: Error {
    case dataNotFound
    case reachabilityError
    case noInternetConnection
}
