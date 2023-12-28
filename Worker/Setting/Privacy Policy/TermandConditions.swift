//
//  TermandConditions.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 06/02/24.
//

import Foundation
import SwiftUI

struct TermandConditions: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var privaycPolicy = String()
    @State private var showWebView = false
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack(spacing: 23.0){
                    
                    Spacer(minLength: 10)
                    HStack{
                        
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                            
                        })
                        {
                            Image("Arrow Left-8")
                                .resizable()
                                .frame(width: 48.0, height: 48.0)
                                .cornerRadius(24)
                        }
                        Spacer()
                        
                        Text("Terms And Conditions")
                            .foregroundColor(.black)
                            .font(.system(size: 24, weight: .bold ))
                        Spacer()
                        
                        Image("")
                            .resizable()
                            .frame(width: 48.0, height: 48.0)
                            .cornerRadius(24)
                        
                        // Spacer()
                        
                    }
                    .padding(.horizontal, 10)
                    //                    ScrollView(showsIndicators: false){
                    //                        VStack(alignment: .leading){
                    //
                    //                            Text(privaycPolicy)
                    //                                .font(.custom("Montserrat-Regular", size: 19))
                    //
                    //                                .multilineTextAlignment(.leading)
                    //                                .frame(width: Constants.Screen_Width-40, alignment: .leading)
                    //
                    //
                    //                            Spacer()
                    //
                    ////                            VStack{
                    ////                                Button {
                    ////                                    showWebView.toggle()
                    ////                                } label: {
                    ////                                    Text("Privacy Policy")
                    ////                                }
                    ////                                .sheet(isPresented: $showWebView) {
                    ////                                    WebView(url: URL(string: "http://167.86.105.98:8082/Privacy-Policy.html")!)
                    ////                                }
                    ////                            }
                    //                        }
                    //                        .padding(.horizontal)
                    //                        //.padding(.leading)
                    //
                    //                    }
                    WebView(url: URL(string: "https://tappme.se/termscondition")!)
                }
                .onAppear(){
                    
                    //  self.fetch()
                }
            }.edgesIgnoringSafeArea(.all).background(Color("BackGroundColor"))
                .navigationBarHidden(true)
            
        }.navigationBarHidden(true)
    }
    func fetch() {
        
        AccountAPI.getsignin(servciename: "GetPolicy", nil) { res in
            switch res {
            case .success:
                print("resulllll",res)
                
                if let json = res.value{
                    
                    print("Josn",json)
                    
                    
                    let events = json["data"]
                    privaycPolicy = events["privacy"].stringValue
                }
                
                
            case let .failure(error):
                print(error)
            }
        }
    }
}


