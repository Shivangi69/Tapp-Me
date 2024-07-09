//
//  WorkerSetting.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 08/01/24.
//

import SwiftUI
import LanguageManagerSwiftUI


struct WorkerSetting: View {
    
    @State private var mainview = false
    @State private var changepasswordto = false
    @EnvironmentObject var languageSettings: LanguageSettings

    @State private var PrivacyPolicy = false
    @State private var about = false
    @State private var TermandConditions = false

    
    @StateObject var AuthServiceVM = UserAuthModel()
    @StateObject var Facebookauth = facebookauthmodel()
    @StateObject var connectsociallogin = Connectsociallogin()
    @StateObject var disconnectmodel = discinnectmodel()

    @StateObject var statuscheck = CompanylistbyemailVMgoogle()
    @State private var isConnectedToGoogle = UserDefaults.standard.bool(forKey: "isGoogleLinked")

    @StateObject var profilemodel = ProfileVM()

    @Environment(\.presentationMode) var presentationMode
    
  //  @StateObject var ConnectgoogleVM = Connectsociallogin()

    var body: some View {
        NavigationView{
            ZStack {
                GeometryReader { geometry in
                    
                    VStack{
                        
                        ScrollView(.vertical , showsIndicators: false){
                            VStack{
                                
                                HStack(){
                                    
                                    Button(action: {
                                        self.presentationMode.wrappedValue.dismiss()

                                    })
                                    {
                                        Image("Arrow Left-8")
                                            .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                                    }
                                    
                                    
                                    Text("Settings")
                                        .fontWeight(.semibold)
                                        .lineLimit(1)
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                                        .padding()
                                    
                                    Spacer()
                                    
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(75))
                                
                                VStack(alignment: .leading){
                                    HStack {
                                        Text("Notification")
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                            .padding()
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            //                                            withAnimation {
                                            //                                               // showTasks.toggle()
                                            //                                            }
                                        }) {
                                            HStack {
                                                Text("Enable")
                                                    .foregroundColor(.black)
                                                    .lineLimit(1)
                                                
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                Spacer()
                                                
                                                Image(systemName: "chevron.down")
                                                    .foregroundColor(Color.gray)
                                                    .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                                            }
                                        }
                                        
                                        .padding()
                                        .frame(width: Responsiveframes.widthPercentageToDP(35), height: Responsiveframes.heightPercentageToDP(5))
                                        
                                        .cornerRadius(6)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 6)
                                                .inset(by: 0.5)
                                                .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                        )
                                    }
                                    
                                    .frame(width: Responsiveframes.widthPercentageToDP(75), height: Responsiveframes.heightPercentageToDP(9))
  
                                    
                                    VStack{
                                        LanguageDropdown(languageSettings: languageSettings)

                                    }

                                    HStack {
                                        
                                        Text("Facebook Account")
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                            .padding()
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            
                                         //   ConnectgoogleVM.FacebookConnect()
                                        //       Facebookauth.FacebookLogin()
                                        }) {
                                            HStack {
                                                
                                                Image("logos_facebook")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.widthPercentageToDP(8))
                                                
                                                Spacer()
                                                Text("Connect")
                                                    .foregroundColor(.black)
                                                    .lineLimit(1)
                                                
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                //
                                            }
                                            .onTapGesture {
                                            //    Facebookauth.FacebookLogin()

                                                
                                          }
                                        }
                                        
                                        .padding()
                                        .frame(width: Responsiveframes.widthPercentageToDP(35), height: Responsiveframes.heightPercentageToDP(5))
                                        
                                        .cornerRadius(6)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 6)
                                                .inset(by: 0.5)
                                                .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                        )
                                    }
                                    
                                    .frame(width: Responsiveframes.widthPercentageToDP(75), height: Responsiveframes.heightPercentageToDP(9))
                                    
                                    
                                    HStack {
                                        
                                        Text("Google Account")
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                            .padding()
                                        
                                        Spacer()
                            
                                        Button(action: {
                                        if isConnectedToGoogle {
                                            disconnectmodel.statuschannel = "google"
                                            disconnectmodel.DisconnectGoogle()
                                        } else {
                                            AuthServiceVM.googleSignconnect()
                                            // Code to connect Google
                                        }
                                    }) {
                                        HStack {
                                            Image("flat-color-icons_google")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.widthPercentageToDP(8))
                                            Spacer()
                                            Text(isConnectedToGoogle ? "Connected" : "Connect")
                                                .foregroundColor(.black)
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                                .lineLimit(1)
                                        }
                                    }
                                    .padding()
                                    .frame(width: Responsiveframes.widthPercentageToDP(35), height: Responsiveframes.heightPercentageToDP(5))
                                    .cornerRadius(6)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .inset(by: 0.5)
                                            .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                    )
                                    .onChange(of: UserDefaults.standard.bool(forKey: "isGoogleLinked")) { newValue in
                                        isConnectedToGoogle = newValue
                                    }
                                        
                                        
//                                        
//                                    .onAppear(){
//                                        
//                                        let istrur = statuscheck.homemodel?.isGoogleLinked
//                                        AuthServiceVM.textchange = istrur ?? false
//                                    }
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(75), height: Responsiveframes.heightPercentageToDP(9))
                                    
                                    
                                    HStack {
                                        Button(action: {
                                 
                                     changepasswordto.toggle()

                                        }) {
                                            HStack {
                                                
                                                Text("Change Password")
                                                    .foregroundColor(.black)
                                                    .lineLimit(1)
                                                
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                //
                                                Spacer()
                                            }
                                            
                                        }
                                        
                                        .onTapGesture {
                                            
                                      changepasswordto.toggle()
//
                                        }
//                                        .fullScreenCover(isPresented: $changepasswordto, content: {
//                                            ChangePassword()
//                                        })
//                                        
                                        
                                        
                                    }
                                    .padding()
                                    .frame(width: Responsiveframes.widthPercentageToDP(75), height: Responsiveframes.heightPercentageToDP(9))
                                    
                                    HStack {
                                        Button(action: {
                                            withAnimation {
                                                PrivacyPolicy.toggle()
                                                
                                            }
                                        }) {
                                            HStack {
                                                
//                                                if #available(iOS 16.0, *) {
//                                                    Text("Privacy Policy")
//                                                    
//                                                        .lineLimit(1)
//                                                        .foregroundColor(.blue)
//                                                        .underline()
//                                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                }
                                                VStack(alignment: .leading, spacing: 0) {
                                                        
                                                        Text("Privacy Policy")
                                                        
                                                            .lineLimit(1)
                                                            .foregroundColor(.blue)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                        
                                                        Divider()
                                                            .background(Color.blue)
                                                            .frame( height: 1)
                                                            
                                                        
                                                    }
                                        
                                                Spacer()
                                            }
                                        }
                                        .onTapGesture {
                                            PrivacyPolicy.toggle()
                                            
                                        }
                                        
                                        .fullScreenCover(isPresented: $PrivacyPolicy, content: {
                                            Tapp_Me.PrivacyPolicy()
                                        })
                                        
                                    }
                                    .padding()
                                    .frame(width: Responsiveframes.widthPercentageToDP(37), height: Responsiveframes.heightPercentageToDP(9))
                                    
                                    
                                    
                                    VStack {
                                        Button(action: {
                                            TermandConditions.toggle()
                                           
                                        }) {
                                          
                                            
                                            
                                            
                                            VStack(alignment: .leading, spacing: 0) {
                                                    
                                                Text("Terms and Conditions")
                                                    .foregroundColor(.blue)
                                                    .lineLimit(1)
                                                 
                                                
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                           
                                                    
                                                    
                                                    Divider()
                                                        .background(Color.blue)
                                                        .frame( height: 1)
                                                        
                                                    
                                                }
                                            Spacer()
                                        }
                                        
                                        .onTapGesture {
                                            TermandConditions.toggle()
                                        }
                                        
                                        .fullScreenCover(isPresented: $TermandConditions, content: {
                                            Tapp_Me.TermandConditions()
                                        })
                                        
                                    }
                                    .padding()
                                    .frame(width: Responsiveframes.widthPercentageToDP(50), height: Responsiveframes.heightPercentageToDP(9))
                                    
                                    VStack {
                                        Button(action: {
                                            about.toggle()
                                            //                                               // showTasks.toggle()
                                            //                                            }
                                        }) {
                                            VStack(alignment: .leading, spacing: 0) {
                                                    
                                                Text("App Info")
                                                    .foregroundColor(.blue)
                                                    .lineLimit(1)
                                                 
                                                
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                           
                                                    
                                                    
                                                    Divider()
                                                        .background(Color.blue)
                                                        .frame(height: 1)
                                                        
                                                    
                                                }
                                          
                                            Spacer()
                                        }
                                        
                                        .onTapGesture {
                                            about.toggle()
                                        }
                                        
                                        .fullScreenCover(isPresented: $about, content: {
                                       AboutIUI()
                                        })
                                        
                                        
                                    }
                                    .padding()
                                    .frame(width: Responsiveframes.widthPercentageToDP(27), height: Responsiveframes.heightPercentageToDP(9))
                                    
                                }
                            }
                            
                            .frame(width: Responsiveframes.widthPercentageToDP(80))
                            .padding()
                            ///  .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                            
                        }
                    }
                    
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .inset(by: 0.5)
                            .stroke(Color.black.opacity(0.15), lineWidth: 0.5)
                    )
                    
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                    )
                    

                    
              //  .frame(width: min(geometry.size.width, geometry.size.height), height: max(geometry.size.width, geometry.size.height))
                    
                    
                    .frame(width: geometry.size.width) // Adjusted frame width based on geometry
                    NavigationLink(destination: ChangePassword(), isActive: $changepasswordto) { EmptyView() }

                }
                
                
            }
            .onAppear(){
                statuscheck.GetallStatus()
                profilemodel.profilefetch()

            }
            
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            
        } .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        
        
        // .offset(y:Responsiveframes.heightPercentageToDP(5))
        //  .padding(.bottom,30)
    }
}


struct LanguageDropdown: View {
    @State  var selectedLanguage = "English" // Default language selection
    @ObservedObject var languageSettings: LanguageSettings
    var body: some View {
        HStack {
            Text("Language Preference")
                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                .padding()
            
            Spacer()
            
            Menu {
                Button(action: {
                    self.selectedLanguage = "English"
                    
                    withAnimation {
                      languageSettings.selectedLanguage = .en
                    }
              
                }) {
                    Text("English")
                }
                
//                Button(action: {
//                    self.selectedLanguage = "Hindi"
//                }) {
//                    Text("Hindi")
//                }
//                
//                
                Button(action: {
                    self.selectedLanguage = "Arabic"
                    languageSettings.selectedLanguage = .ar
                    
                }) {
                    Text("Arabic")
                }
                
                          Button(action: {
                              self.selectedLanguage = "German"
                              languageSettings.selectedLanguage = .de
                              
                          }) {
                              Text("German")
                          }
                
//                          Button(action: {
//                              self.selectedLanguage = "Serbian"
//                              languageSettings.selectedLanguage = .de
//                              
//                          }) {
//                              Text("Serbian")
//                          }
//                
                
                Button(action: {
                    self.selectedLanguage = "Swedish"
                    
                    withAnimation {
                      languageSettings.selectedLanguage = .sv
                    }
                }) {
                    Text("Swedish")
                }
            } label: {
                HStack {
                    Text(selectedLanguage)
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color.gray)
                        .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                }
                .padding()
                .frame(width: Responsiveframes.widthPercentageToDP(35), height: Responsiveframes.heightPercentageToDP(5))
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .inset(by: 0.5)
                        .stroke(Color.black.opacity(0.15), lineWidth: 1)
                )
            }
        }
        .frame(width: Responsiveframes.widthPercentageToDP(75), height: Responsiveframes.heightPercentageToDP(9))
        .onAppear {
             // Set the default language selection to the value of selectedLanguage
            switch languageSettings.selectedLanguage {
                case .en:
                    selectedLanguage = "English"
                case .hi:
                    selectedLanguage = "Hindi"
                case .ar:
                    selectedLanguage = "Arabic"
                case .sv:
                    selectedLanguage = "Swedish"
                case .nl:
                    selectedLanguage = "Dutch"
                case .ja:
                    selectedLanguage = "Japanese"
                case .ko:
                    selectedLanguage = "Korean"
                case .vi:
                    selectedLanguage = "Vietnamese"
                case .ru:
                    selectedLanguage = "Russian"
                case .fr:
                    selectedLanguage = "French"
                case .es:
                    selectedLanguage = "Spanish"
                case .pt:
                    selectedLanguage = "Portuguese"
                case .it:
                    selectedLanguage = "Italian"
                case .de:
                    selectedLanguage = "German"
                case .da:
                    selectedLanguage = "Danish"
                case .fi:
                    selectedLanguage = "Finnish"
                case .nb:
                    selectedLanguage = "Norwegian Bokmål"
                case .tr:
                    selectedLanguage = "Turkish"
                case .el:
                    selectedLanguage = "Greek"
                case .id:
                    selectedLanguage = "Indonesian"
                case .ms:
                    selectedLanguage = "Malay"
                case .th:
                    selectedLanguage = "Thai"
                case .hu:
                    selectedLanguage = "Hungarian"
                case .pl:
                    selectedLanguage = "Polish"
                case .cs:
                    selectedLanguage = "Czech"
                case .sk:
                    selectedLanguage = "Slovak"
                case .uk:
                    selectedLanguage = "Ukrainian"
                case .hr:
                    selectedLanguage = "Croatian"
                case .ca:
                    selectedLanguage = "Catalan"
                case .ro:
                    selectedLanguage = "Romanian"
                case .he:
                    selectedLanguage = "Hebrew"
                case .ur:
                    selectedLanguage = "Urdu"
                case .fa:
                    selectedLanguage = "Persian"
                case .ku:
                    selectedLanguage = "Kurdish"
                case .arc:
                    selectedLanguage = "Aramaic"
                case .sl:
                    selectedLanguage = "Slovenian"
                case .ml:
                    selectedLanguage = "Malayalam"
                case .am:
                    selectedLanguage = "Amharic"
                case .enGB:
                    selectedLanguage = "English (UK)"
                case .enAU:
                    selectedLanguage = "English (Australia)"
                case .enCA:
                    selectedLanguage = "English (Canada)"
                case .enIN:
                    selectedLanguage = "English (India)"
                case .frCA:
                    selectedLanguage = "French (Canada)"
                case .esMX:
                    selectedLanguage = "Spanish (Mexico)"
                case .ptBR:
                    selectedLanguage = "Portuguese (Brazil)"
                case .zhHans:
                    selectedLanguage = "Chinese (Simplified)"
                case .zhHant:
                    selectedLanguage = "Chinese (Traditional)"
                case .zhHK:
                    selectedLanguage = "Chinese (Hong Kong)"
                case .es419:
                    selectedLanguage = "Spanish (Latin America)"
                case .ptPT:
                    selectedLanguage = "Portuguese (Portugal)"
                case .deviceLanguage:
                    selectedLanguage = "Device Language"
            }

         }
    }
}

#Preview {
    WorkerSetting()
}
