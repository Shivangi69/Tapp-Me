//
//  ContentView.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 28/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var createVM = ViewController1()
    @State private var showAlert = false
    @State  var showlogin = false
    @State  var showreset = false

    var body: some View {
        
//        if UserDefaults.standard.bool(forKey: "active") == false{
            
//            VStack {
//                // Your main view content here
//            }
//            .onAppear {
//                showAlert = true
//            }
//            .alert(isPresented: $showAlert) {
//                Alert(
//                    title: Text("Activation Required"),
//                    message: Text("Your ID is not activated. Please connect with the administrator."),
//                    dismissButton: .default(Text("OK"))
//                )
//            }
//            
//        }
        
//        else{
            
            if UserDefaults.standard.bool(forKey: "isFirstLogin") == true
            {
                VStack{
                    
                    Mainview()
                }.onAppear(){
                    createVM.registerSocket()
                }
                
            }
            
            else if UserDefaults.standard.string(forKey: "login") == "yes"   {
                VStack{
                    Mainview()
                }.onAppear(){
                    createVM.registerSocket()
                    
                }
            }
        else if (showlogin == true)
        {
            Mainview()
        }
        else if (showreset == true)
        {
            LoginsetPassowrd()
        }
            else {
                VStack{
                    Login()
                    
                }.onAppear(){
                    createVM.registerSocket()
                    
                    NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "LOGIN"), object: nil, queue: OperationQueue.main) {_ in
                        withAnimation {
                            showlogin = true
                          
                        }
                    }
                    NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "RESET"), object: nil, queue: OperationQueue.main) {_ in
                        withAnimation {
                            showreset = true
                          
                        }
                    }
                    
                }
                
            }
//        }
    }
}


class AlertCoordinator: ObservableObject {
    static let shared = AlertCoordinator() // Singleton instance
    
    @Published var showAlert: Bool = false
    var alertTitle: String = ""
    var alertMessage: String = ""
    var onDismiss: (() -> Void)?
    
    func presentAlert(title: String, message: String, onDismiss: (() -> Void)? = nil) {
        self.alertTitle = title
        self.alertMessage = message
        self.onDismiss = onDismiss
        self.showAlert = true
    }
}


struct AlertPresenter: View {
    @ObservedObject var alertCoordinator = AlertCoordinator.shared
   @State private var appLogout = false // Move appLogout state here

    var body: some View {
        Group {
              if alertCoordinator.showAlert {
                  AlertViewController(
                      title: alertCoordinator.alertTitle,
                      message: alertCoordinator.alertMessage,
                      appLogout: $appLogout, // Pass appLogout as a binding
                      onDismiss: {
                          alertCoordinator.showAlert = false
                          alertCoordinator.onDismiss?()
                      }
                  )
              } else {
                  EmptyView()
              }
          }
//          .fullScreenCover(isPresented: $appLogout) {
//              LoginScreen()
//          }
    }
}



struct AlertViewController: UIViewControllerRepresentable {
    var title: String
    var message: String
    @Binding var appLogout: Bool // Receive appLogout as a binding

    var onDismiss: (() -> Void)?


    func makeUIViewController(context: Context) -> UIViewController {
        return UIViewController()
    }
    
    func clearUserData() {
     let deviceToken = UserDefaults.standard.string(forKey: "devicetoken")
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
        }
        UserDefaults.standard.setValue(deviceToken, forKey: "devicetoken")
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        guard uiViewController.presentedViewController == nil else { return }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
         //   onDismiss?()
              //  clearUserData()
                  // self.appLogout = true // Toggle appLogout using the binding
//                   let shared = PersistenceController()
//                   shared.deleteAllData()
//                   print("Error deleting all data")
//                   if let window = UIApplication.shared.windows.first {
//                       window.rootViewController = UIHostingController(rootView: ContentView())
//                       window.makeKeyAndVisible()
//                   }
                        
        })
        
        DispatchQueue.main.async {
            uiViewController.present(alert, animated: true, completion: nil)
        }
     
    
    }
}
#Preview {
    ContentView()
}
