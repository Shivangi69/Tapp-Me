//
//  PrivacyPolicy.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 06/02/24.
//

import SwiftUI
import Foundation

struct PrivacyPolicy: View {
    
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
                        
                        Text("Privacy Policy")
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
                    WebView(url: URL(string: "https://tappme.se/privacypolicy")!)
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

struct PrivacyPolicy_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicy()
    }
}
import WebKit
import SwiftUI

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}

struct WebView: UIViewRepresentable {
    
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
