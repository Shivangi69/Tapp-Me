//
//  AboutIUI.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 25/06/24.
//

import SwiftUI

//struct AboutIUI: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

//#Preview {
//    AboutIUI()
//}

struct AboutIUI: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var privaycPolicy = String()
//    @State private var showWebView = false
    
        var body: some View {
               NavigationView {
                   VStack(spacing: 0) {
                       // Header
                       HStack {
                           Button(action: {
                               self.presentationMode.wrappedValue.dismiss()
                           }) {
                               Image("Arrow Left-8")
                                   .resizable()
                                   .frame(width: 48.0, height: 48.0)
                                   .cornerRadius(24)
                           }
                           Spacer()
                           
                           Text("About Us")
                               .foregroundColor(.black)
                               .font(.system(size: 24, weight: .bold))
                           
                           Spacer()
                           
                           Image("") // Placeholder for potential right side button or icon
                               .resizable()
                               .frame(width: 48.0, height: 48.0)
                               .cornerRadius(24)
                       }
                       .padding()
                       .background(Color.white)
                       
                       Divider()
                       
                       // Main content
                       VStack {
//                           Spacer(minLength: 20)
                           
                           HStack {
                               Text("Version")
                                   .foregroundColor(.black)
                                   .font(.system(size: 24, weight: .bold))
                               Text(AppInfo.version)
                                   .foregroundColor(.black)
                                   .font(.system(size: 24, weight: .bold))
                               Spacer()
                           }
                           .padding([.leading, .trailing])
                           
//                           Spacer(minLength: 20)
                           
                           HStack {
                               Text("Build")
                                   .foregroundColor(.black)
                                   .font(.system(size: 24, weight: .bold))
                               Text(AppInfo.build)
                                   .foregroundColor(.black)
                                   .font(.system(size: 24, weight: .bold))
                               Spacer()
                           }
                           .padding([.leading, .trailing])
                           
                           Spacer()
                       }
                       .background(Color("BackGroundColor"))
                       .edgesIgnoringSafeArea(.all)
                   }
                   .navigationBarHidden(true)
               }
           }
    
//    func fetch() {
//        
//        AccountAPI.getsignin(servciename: "GetPolicy", nil) { res in
//            switch res {
//            case .success:
//                print("resulllll",res)
//                
//                if let json = res.value{
//                    
//                    print("Josn",json)
//                    
//                    
//                    let events = json["data"]
//                    privaycPolicy = events["privacy"].stringValue
//                }
//                
//                
//            case let .failure(error):
//                print(error)
//            }
//        }
//    }
}

import Foundation

struct AppInfo {
    static var version: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A"
    }

    static var build: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "N/A"
    }
}
