
import SwiftUI

struct CustumTabView: View {
   
        let tabBarImagesNmaesworker = ["Home333","Hourglass", "File Text","Chat Line"]
        let tabBartitleNmaesworker = ["Home","Time","Reports","Messages"]
        let tabBarImagesNmaesworker2 = ["Home 1","Hourglass 1" ,"File Text 1","Chat Line 1"]
    
    let tabBarImagesNmaessuper = ["Home333", "User Rounded 1" , "File Text","Chat Line"]
    let tabBartitleNmaessuper = ["Home", "Worker" ,"Reports","Messages"]
    let tabBarImagesNmaessuper2 = ["Home 1", "User Rounded" ,"File Text 1","Chat Line 1"]
        


    @State var selectedIndex: Int
    var onClickedAtIndex: ((Int) -> Void)?

    var body: some View {
        
        if UserDefaults.standard.bool(forKey: "isWorkerCheckedIn") == true &&   UserDefaults.standard.integer(forKey: "workforceId") != 0 {
        ZStack{
            
            if (UserDefaults.standard.string(forKey: "Role") == "SUPERVISOR") {
                
                
                VStack {
                    HStack(alignment: .top, spacing: 0.0) {
                        ForEach(0..<tabBarImagesNmaessuper.count) { i in
                            Button {
                                selectedIndex = i
                                onClickedAtIndex?(selectedIndex)
                            }
                        label: {
                            
                            let fontsize:CGFloat = i == selectedIndex ? 32 : 24
                            let color =  selectedIndex == i ? Color.black : Color.gray.opacity(0.4)
                            
                            VStack(alignment: .center, spacing: 3){
                                //(systemName: tabBarImagesNmaes[i])
                                //
                                //    Image(tabBarImagesNmaes[i])
                                //                                .resizable()
                                //                                .frame(width: selectedIndex == i ? 28 : 24, height: selectedIndex == i ? 28 : 24  )
                                //
                                Image(selectedIndex == i ? tabBarImagesNmaessuper2[i] :tabBarImagesNmaessuper[i])
                                    .resizable()
                                    .frame(width: selectedIndex == i ? 28 : 24,
                                           
                                           height: selectedIndex == i ? 28 : 24  )
                                Text(
                                    
                                    tabBartitleNmaessuper[i])
                                .font(ConstantClass.AppFonts.light)
                                
                                .foregroundColor( selectedIndex == i ? Color.accentColor : Color.gray)
                                .lineLimit(1)
                            }.padding(.bottom,  10)
                            //                        Spacer()
                        }
                            
                        .frame(width:Constants.Screen_Width/4 ,height: 70.0)
                            
                            
                        }
                    }
                    .frame(height: 70.0)
                    //                .overlay(
                    //                    RoundedRectangle(cornerRadius: 1)
                    //                        .inset(by: 0.5)
                    //                        .stroke(Color.black.opacity(0.15), lineWidth: 0.5)
                    //                )
                    //
                    //                        .background(
                    //                                           RoundedRectangle(cornerRadius: 1)
                    //                                               .fill(Color.white)
                    //                                               .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                    //                                       )
                    
                }
                
            }
            
            else{
                
                
                VStack {
                    HStack(alignment: .top, spacing: 0.0) {
                        ForEach(0..<tabBarImagesNmaesworker.count) { i in
                            Button {
                                selectedIndex = i
                                onClickedAtIndex?(selectedIndex)
                            }
                        label: {
                            
                            let fontsize:CGFloat = i == selectedIndex ? 32 : 24
                            let color =  selectedIndex == i ? Color.black : Color.gray.opacity(0.4)
                            
                            VStack(alignment: .center, spacing: 3){
                                //(systemName: tabBarImagesNmaes[i])
                                //
                                //    Image(tabBarImagesNmaes[i])
                                //                                .resizable()
                                //                                .frame(width: selectedIndex == i ? 28 : 24, height: selectedIndex == i ? 28 : 24  )
                                //
                                Image(selectedIndex == i ? tabBarImagesNmaesworker2[i] :tabBarImagesNmaesworker[i])
                                    .resizable()
                                    .frame(width: selectedIndex == i ? 28 : 24,
                                           
                                           height: selectedIndex == i ? 28 : 24  )
                                Text(
                                    
                                    tabBartitleNmaesworker[i])
                                .font(ConstantClass.AppFonts.light)
                                
                                .foregroundColor( selectedIndex == i ? Color.accentColor : Color.gray)
                                .lineLimit(1)
                            }.padding(.bottom,  10)
                        }
                            
                        .frame(width:Constants.Screen_Width/4 ,height: 70.0)
                            
                            
                        }
                    }
                    .frame(height: 70.0)
                    
                    
                }
                
            }
            
            
            
            
            
            
            
        }
        .onAppear(){
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "calldashboard"), object: nil, queue: OperationQueue.main) {_ in
                selectedIndex = 0
                onClickedAtIndex?(selectedIndex)
                //                disableAllview()
                //                //                workercheckin = false
                //                showdashboard = true
                
            }
        }
        .frame(height: 70.0)
        
        
        .background(
            RoundedRectangle(cornerRadius: 1)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
        )
        
        
    }
                   
        
    }
}

struct CustumTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustumTabView(selectedIndex: 0)
    }
}
