//
//  RequestLoader.swift
//  wallet-test
//
//  Created by John Paulo on 6/10/22.
//

import Foundation
import SwiftyJSON
import Combine
import Moya

// MARK: - Request Loader States

enum RequestLoaderState {
    case idle
    case loaded
    case loading
    case error(RequestLoaderError)
}

// MARK: - Request Loader Error

enum RequestLoaderError: Error {
    case unknownError
    case invalidData
    case notFound
    case requestFailed
    case custom(json: JSON?)
    
    // MARK: - Error Descriptions
    
    var description: String {
        switch self {
        case .unknownError:
            return "An unknonw error occured. Please try again later."
        case .invalidData:
            return "There has been an issue with your data."
        case .notFound:
            return "Resource not found."
        case .requestFailed:
            return "Unable to make request."
        case .custom(let json):
            // Custom JSON error may have different structures or formats. We can add as many
            // handlers here to retrieve the message any one of them
            if let message = json?["errors"]["non_field_errors"]["message"].string {
                return message
            }
            
            // NOTE: We can add any custom handlers for other error response formats like below
            //if let message = json?["error"]["message"].string {
            //    return message
            //}
            
            return "An unknonw error occured."
        }
    }
    
    // MARK: - Error Builder
    
    init(nerworkResponse: Response) {
        switch nerworkResponse.statusCode {
        case 404:
            self = .notFound
        case 429:
            let data = try? JSON(data: nerworkResponse.data)
            self = .custom(json: data)
        default:
            self = .unknownError
        }
    }
}

// MARK: - RequestLoader

class RequestLoader {
    
    var loadingState = CurrentValueSubject<RequestLoaderState, Never>(.idle)
    
    private var provider = MoyaProvider<APIService>(plugins: [
        NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))
    ])
    
    private func request<T: Codable>(service: APIService, completion: @escaping (Result<T, Error>)->Void) {
        loadingState.send(.loading)
        provider.request(service) { [weak self] (result) in
            switch result {
            case .failure:
                completeWithError(.requestFailed)
            case .success(let response):
                switch response.statusCode {
                case 200..<300:
                    do {
                        let data = try JSONDecoder().decode(T.self, from: response.data)
                        completion(.success(data))
                        self?.loadingState.send(.loaded)
                    } catch {
                        completeWithError(.invalidData)
                    }
                default:
                    completeWithError(RequestLoaderError(nerworkResponse: response))
                }
            }
        }
        
        func completeWithError(_ error: RequestLoaderError) {
            completion(.failure(error))
            self.loadingState.send(.error(error))
        }
    }
    
}

// MARK: - Access Methods
// NOTE: Can be placed in a separate file for better organization
extension RequestLoader {
    func getWallets(completion: @escaping (Result<WalletList, Error>) -> Void) {
        request(service: .getWallets, completion: completion)
    }
    
    func getHistories(completion: @escaping (Result<HistoryList, Error>) -> Void) {
        request(service: .getHistories, completion: completion)
    }
}
