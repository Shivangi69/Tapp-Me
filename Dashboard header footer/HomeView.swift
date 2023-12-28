
import SwiftUI

struct HomeView: View {
    
    
    @StateObject var WorkerCheckin = WorkerCheckinVM()
    @StateObject var statuscheck = CompanylistbyemailVMgoogle()
    @State var showview = false

    
    
 //   var WorkerCheckvm = WorkerCheckinVM()

    var body: some View {
        NavigationView {
            ZStack {
                
                if WorkerCheckin.siteidarray.count != 0 && statuscheck.homemodel?.isWorkerCheckedIn == true {
                    
                    VStack{
                        
                        
                    }
                    .onAppear(){
                        withAnimation{
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "calldashboard"), object: self)
                            
                        }
                    }
                    
                }
                else if WorkerCheckin.siteidarray.count != 0 {
                    if UserDefaults.standard.bool(forKey: "isWithinPolygons") == false {
                        VStack {
                            Spacer()
                            
                            Image("Image 2")
                                .resizable()
                                .frame(width: ConstantClass.verybiglogo.logoWidth, height: ConstantClass.verybiglogo.logoHeight)
                                .padding()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(ConstantClass.verybiglogo.logoWidth / 2)
                            
                            Spacer()
                        }
                        .onTapGesture {
                            WorkerCheckin.getsideid()
                            if UserDefaults.standard.bool(forKey: "isWithinPolygons") == true {
                           
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Showworkercheckin"), object: self)
                   
                            }
                            else {
                                Toast(text: "You are out of boundary").show()

                            }
                            
                    
                        }
                        //                        .disabled(true) // Disables the VStack
                    } else {
                        
                        VStack {
                            Spacer()
                            
                            Image("checkinhome")
                                .resizable()
                                .frame(width: ConstantClass.verybiglogo.logoWidth, height: ConstantClass.verybiglogo.logoHeight)
                                .padding()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(ConstantClass.verybiglogo.logoWidth / 2)
                            
                            Spacer()
                        }
                        .onTapGesture {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Showworkercheckin"), object: self)
                        }
                    }
            
            
                }
                else {
                    
                        VStack {
                            Text(WorkerCheckin.errormessage)
                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                .padding()
                        }
                }
                    
//                    if statuscheck.homemodel?.isWorkerCheckedIn == true {
//                        VStack {
//                            Spacer()
//                            
//                            Image("checkinhome")
//                                .resizable()
//                                .frame(width: ConstantClass.verybiglogo.logoWidth, height: ConstantClass.verybiglogo.logoHeight)
//                                .padding()
//                                .aspectRatio(contentMode: .fit)
//                                .cornerRadius(ConstantClass.verybiglogo.logoWidth/2)
//                            Spacer()
//                        }
//                        
//                        .onTapGesture {
//                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Showworkercheckin"), object: self)
//                            
//                        }
//                    }
                    
//                    else{
//                        VStack{
//                            
//                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "calldashboard"), object: self)
//                        }
//                        
//                        
//                    }
                    
                 
             //   }
                
          //      else
//                {
//                    VStack {
//                        Text(WorkerCheckin.errormessage)
//                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                            .padding()
//                    }
//              
//                    
//                }
                 
            }
            .offset(y:Responsiveframes.heightPercentageToDP(5))
            .padding(.bottom,30)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            
            
//            .onAppear(){
//                WorkerCheckin.getsideid()
//                statuscheck.GetallStatus()
//
//            }
        }
        .onAppear(){
            WorkerCheckin.getsideid()
            statuscheck.GetallStatus()

        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


