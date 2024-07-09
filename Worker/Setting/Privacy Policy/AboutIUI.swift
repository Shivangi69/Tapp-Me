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
                   
                   ZStack{
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
                               
                               Text("App Info")
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
                               Spacer()
                               
                               Text("Tapp Me")
                                   .foregroundColor(.black)
                                   .font(.system(size: 24, weight: .bold))
                               
                               
                               
                               HStack {
                                   Text("Version")
                                       .foregroundColor(.gray)
                                       .font(.system(size: 20))
                                   Text(AppInfo.version)
                                       .foregroundColor(.gray)
                                       .font(.system(size: 20))
                                   
                               }
                               
                               
                               //                           Spacer(minLength: 20)
                               
                               Image("logo")
                                   .resizable()
                                   .frame(width: 50, height: 50)
                                   .cornerRadius(25)
                                   .aspectRatio(contentMode: .fit)
                               
                               HStack {
                                   Text("Build")
                                       .foregroundColor(.black)
                                       .font(.system(size: 20))
                                   Text(AppInfo.build)
                                       .foregroundColor(.black)
                                       .font(.system(size: 20))
                                   
                               }
                               
                               
                               Spacer()
                           }
                           
                           
                       }
                       
                   }
                   .background(Color("about"))
                   .navigationBarHidden(true)
                   
               }  .edgesIgnoringSafeArea(.all)
           }
    
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
