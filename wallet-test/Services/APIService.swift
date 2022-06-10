//
//  APIService.swift
//  wallet-test
//
//  Created by John Paulo on 6/10/22.
//

import Foundation
import Moya

enum APIService {
    case getWallets
    case getHistories
}

extension APIService: TargetType {
    var baseURL: URL { URL(string: K.API.baseURL)! }
    
    var path: String {
        switch self {
        case .getWallets: return "/wallets"
        case .getHistories: return "/histories"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default: return .get
        }
    }
    
    var task: Task {
        switch self {
        default: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        ["Content-type": "application/json; charset=UTF-8"]
    }
}

