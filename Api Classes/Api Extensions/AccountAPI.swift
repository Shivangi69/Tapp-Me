//
//  AccountAPI.swift
//  SwiftUI Skeleton App
//
//  Created by PW486 on 2019/09/15.
//  Copyright © 2019 PW486. All rights reserved.


import Alamofire
import Foundation
import SwiftyJSON

struct AccountAPI {
    
    static func signin(servciename :String, _ parameters: Parameters?, completion: @escaping (Result<JSON>) -> Void) {
        RequestAPI.call(servciename, method: .post, parameters: parameters) { res in
            switch res {
            case .success:
                if let json = res.value {
                    
                    completion(.success(json))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func deleteRequest(servciename :String, _ parameters: Parameters?, completion: @escaping (Result<JSON>) -> Void) {
        RequestAPI.call(servciename, method: .delete, parameters: parameters) { res in
            switch res {
            case .success:
                if let json = res.value {
                    completion(.success(json))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    
    
    static func signinwithHeader(servciename :String, _ parameters: Parameters?, completion: @escaping (Result<JSON>) -> Void) {
        RequestAPI.call2(servciename, method: .post, parameters: parameters) { res in
            switch res {
            case .success:
                if let json = res.value {
                    
                    completion(.success(json))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    static func getsignin(servciename :String, _ parameters: Parameters?, completion: @escaping (Result<JSON>) -> Void) {
        RequestAPI.call(servciename, method: .get, parameters: nil) { res in
            switch res {
            case .success:
                if let json = res.value {
                    // UserDefaults.standard.set(json["access_token"].string, forKey: "access_token")
                    completion(.success(json))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    static func getsigninwithoutLoader(servciename :String, _ parameters: Parameters?, completion: @escaping (Result<JSON>) -> Void) {
        RequestAPI.callwithoutLoader(servciename, method: .get, parameters: nil) { res in
            switch res {
            case .success:
                if let json = res.value {
                    // UserDefaults.standard.set(json["access_token"].string, forKey: "access_token")
                    completion(.success(json))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func updateSignin(servciename: String, _ parameters: Parameters?, completion: @escaping (Result<JSON>) -> Void) {
        RequestAPI.call(servciename, method: .put, parameters: parameters) { res in
            switch res {
            case .success:
                if let json = res.value {
                    // UserDefaults.standard.set(json["access_token"].string, forKey: "access_token")
                    completion(.success(json))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func updateEdittask(servciename: String, _ parameters: Parameters?, completion: @escaping (Result<JSON>) -> Void) {
        RequestAPI.call2(servciename, method: .put, parameters: parameters) { res in
            switch res {
            case .success:
                if let json = res.value {
                    // UserDefaults.standard.set(json["access_token"].string, forKey: "access_token")
                    completion(.success(json))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func getsigninwithpara(servciename :String, _ parameters: Parameters?, completion: @escaping (Result<JSON>) -> Void) {
        RequestAPI.call(servciename, method: .get, parameters: parameters) { res in
            switch res {
            case .success:
                if let json = res.value {
                    //    UserDefaults.standard.set(json["access_token"].string, forKey: "access_token")
                    completion(.success(json))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func getsigninw(servciename :String, _ parameters: Parameters?, completion: @escaping (Result<JSON>) -> Void) {
        RequestAPI.call2(servciename, method: .get, parameters: parameters) { res in
            switch res {
            case .success:
                if let json = res.value {
                    //    UserDefaults.standard.set(json["access_token"].string, forKey: "access_token")
                    completion(.success(json))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    
    
    static func signup(_ parameters: Parameters?, completion: @escaping (Result<JSON>) -> Void) {
        RequestAPI.call("v1/signup", method: .post, parameters: parameters) { res in
            switch res {
            case .success:
                if let json = res.value {
                    // UserDefaults.standard.set(json["access_token"].string, forKey: "access_token")
                    completion(.success(json))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
