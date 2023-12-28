//
//  CustomTabView.swift
//  SwiftUI+Tab+MVVMDemo
//
//  Created by Kishan on 01/01/22.
//

import SwiftUI

struct CustomTabView: View {
   
    let tabBarImagesNmaes = ["home-fill","atendance","notification","user"]
    let tabBartitleNmaes = ["Home","Attendance","Notification","Profile"]
    let tabBarImagesNmaes1 = ["home-fill","atendance","notification","user"]

    @State var selectedIndex: Int
    var onClickedAtIndex: ((Int) -> Void)?

    var body: some View {
        VStack {
           
            HStack(alignment: .top, spacing: 0.0) {
                ForEach(0..<tabBarImagesNmaes.count) { i in
                    Button {
                        selectedIndex = i
                        onClickedAtIndex?(selectedIndex)
                    } label: {
                       
                        let fontsize:CGFloat = i == selectedIndex ? 32 : 24
                        let color =  selectedIndex == i ? Color.black : Color.gray.opacity(0.4)

                        VStack(alignment: .center, spacing: 3){
                            //(systemName: tabBarImagesNmaes[i])
                           //
                            Image(tabBarImagesNmaes[i])
                                .resizable()
                                .frame(width: selectedIndex == i ? 28 : 24, height: selectedIndex == i ? 28 : 24  )
                            //
                           //// Image(selectedIndex == i ? tabBarImagesNmaes1[i] :tabBarImagesNmaes[i])
                                //.font(.system(size: fontsize, weight: .bold)).foregroundColor(.white)
                            Text(tabBartitleNmaes[i])
                                .font(.custom("Montserrat-Medium", size: 16))
                                    .foregroundColor( selectedIndex == i ? Color.gray : Color.gray)
                                   .lineLimit(1)
                        }.padding(.top,  10)
//                        Spacer()
                    } .frame(width:Constants.Screen_Width/4 ,height: 90.0)
                }
            }
            .frame(height: 90.0)
                .background(Color("purplecolor"))
        }
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView(selectedIndex: 0)
    }
}
