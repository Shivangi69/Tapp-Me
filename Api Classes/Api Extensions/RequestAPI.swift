//
//  RequestAPI.swift
//  SwiftUI Skeleton App
//
//  Created by PW486 on 2019/09/15.
//  Copyright © 2019 PW486. All rights reserved.


import Alamofire
import Foundation
import SwiftyJSON
import SSSwiftUILoader

struct RequestAPI {
    
  static func call(_ path: String, method: HTTPMethod, parameters: Parameters?, completion: @escaping (Result<JSON>) -> Void) {
    //    public static final String URL_BASE = "https://mapzapp.swadhasoftwares.com";

    SSLoader.shared.startloader("Loading...", config: .defaultSettings)//http://eventsapp.biz/
      
    //  let baseURL = URL(string: "http://62.171.153.83:8080/tappme-api-development/" + path)


let baseURL = URL(string: "http://62.171.153.83:8080/tappme-api-staging/" + path)

   //http://grocery.swadhasoftwares.com/api/login.php
   let url = baseURL!//.appendingPathComponent(path)
      let accessToken = UserDefaults.standard.string(forKey: "access_token") ?? ""
      var headers: HTTPHeaders? = nil
      if (accessToken != "") {
          headers = ["Authorization": "token \(accessToken)"]

      }
   print("urlllll------",url)

    Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { res in
      switch res.result {
      case .success:

        SSLoader.shared.stopLoader()
   
        if let value = res.result.value{
          let json = JSON(value)
  
            SSLoader.shared.stopLoader()
            
            completion(.success(json))
       }
      case let .failure(error):
        print(error.localizedDescription)
  
          SSLoader.shared.stopLoader()
          if let nsError = error as NSError?, nsError.code == -1009 {
               AlertCoordinator.shared.presentAlert(title: "No Internet", message: "The Internet connection appears to be offline.")
               return
           }
          
        completion(.failure(error))
      }
    }
  }
    
    
    
    
    
    static func callwithoutLoader(_ path: String, method: HTTPMethod, parameters: Parameters?, completion: @escaping (Result<JSON>) -> Void) {

        
 // let baseURL = URL(string: "http://62.171.153.83:8080/tappme-api-development/" + path)


 let baseURL = URL(string: "http://62.171.153.83:8080/tappme-api-staging/" + path)

     //http://grocery.swadhasoftwares.com/api/login.php
     let url = baseURL!//.appendingPathComponent(path)
        let accessToken = UserDefaults.standard.string(forKey: "access_token") ?? ""
        var headers: HTTPHeaders? = nil
        if (accessToken != "") {
            headers = ["Authorization": "token \(accessToken)"]

        }
        
        
     print("urlllll------",url)

      Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { res in
        switch res.result {
        case .success:

          if let value = res.result.value{
            let json = JSON(value)

              completion(.success(json))
         }
        case let .failure(error):
          print(error.localizedDescription)

            if let nsError = error as NSError?, nsError.code == -1009 {
                print("nointernet")
                 AlertCoordinator.shared.presentAlert(title: "No Internet", message: "The Internet connection appears to be offline.")
                 return
             }
            
          completion(.failure(error))
        }
      }
    }
    
      static func call2(_ path: String, method: HTTPMethod, parameters: Parameters?, completion: @escaping (Result<JSON>) -> Void) {
        //    public static final String URL_BASE = "https://mapzapp.swadhasoftwares.com";

        SSLoader.shared.startloader("Loading...", config: .defaultSettings)//http://eventsapp.biz/
          
                //let baseURL = URL(string: "http://62.171.153.83:8080/tappme-api-development/" + path)

  let baseURL = URL(string: "http://62.171.153.83:8080/tappme-api-staging/" + path)

       //http://grocery.swadhasoftwares.com/api/login.php
       let url = baseURL!//.appendingPathComponent(path)
          let accessToken = UserDefaults.standard.string(forKey: "jwttoken") ?? ""
          var headers: HTTPHeaders? = nil
          if (accessToken != "") {
              headers = ["Authorization": "Bearer \(accessToken)"]

          }
          
          
       print("urlllll------",url)
          
       
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { res in
          switch res.result {
              
              
              
          case .success:

            SSLoader.shared.stopLoader()
         
            if let value = res.result.value{
              let json = JSON(value)
 
                SSLoader.shared.stopLoader()

                completion(.success(json))
           }
          case let .failure(error):
            print(error.localizedDescription)
             //
              
              SSLoader.shared.stopLoader()

              
              if let nsError = error as NSError?, nsError.code == -1009 {
                  print("nointernet")

                   AlertCoordinator.shared.presentAlert(title: "No Internet", message: "The Internet connection appears to be offline.")
                   return
               }
              

            completion(.failure(error))
          }
        }
      }
    
}
