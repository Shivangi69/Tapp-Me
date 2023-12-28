//
//  MenuHeaderView.swift
//  SlideOutMenu
//
//  Created by Liu Chuan on 2020/12/05.
//

import SwiftUI

struct MenuHeaderView: View {
    
    @Binding var wdith: CGFloat
    
    @Binding var x: CGFloat
    
    let name : String = ""
    
    @State private var firstname = UserDefaults.standard.string(forKey: "firstName") ?? ""
    @State private var lastname = UserDefaults.standard.string(forKey: "lastName") ?? ""
    //  let str = firstname
    
    @State private var email = UserDefaults.standard.string(forKey: "email") ?? ""
    @State private var phoneNum = UserDefaults.standard.string(forKey: "mobile") ?? ""
    //  @State private var password = UserDefaults.standard.string(forKey: "email") ?? ""
    @State private var profileImage = UserDefaults.standard.string(forKey: "profileImage") ?? ""
    
    
    var body: some View {
        
        ZStack {
            
            VStack(alignment: .center, spacing: 5) {
                Spacer(minLength: 20)
                
                HStack{
                    Spacer()
                    Image("close 1")
                        .background(Color.gray)
                        .cornerRadius(5)
                        .frame(width: 30.0, height: 30.0)
                    
                }.onTapGesture {
                    withAnimation {
                        withAnimation {
                            x = -wdith
                        }
                    }
                }
                
                .padding([.top, .trailing], 5.0)
                
                
                VStack{
                    
                    AsyncImage(
                        
                //       url: URL(string: profileImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!,
                        
                        url: NSURL(string: profileImage)! as URL,

                        placeholder: { Image("icons8-user-64 (1)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            
                        },
                        image: { Image(uiImage: $0).resizable()
                            
                        }
                    )
                    .aspectRatio(contentMode: .fill)
                    
                    .frame(width: 100.0, height: 100.0)
                    .cornerRadius(50.0)
                    
                }
                //.border(Color.white, width: 1 )
                .cornerRadius(60.0)
                .frame(width: 100.0, height: 100.0)
                
              let trimmed = self.firstname.trimmingCharacters(in: .whitespacesAndNewlines)
                Text (firstname)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold ))
//                Text ("Employeer Position")
//                    .foregroundColor(.white)
//                    .font(.system(size: 12))
                
                Spacer()
                
                HStack{}
                    .frame(width: wdith - 40 ,height: 2)
                    .background(Color.init("DarkGray"))
                
                
                Spacer()
                
            }
            
        }
        .frame(width: self.wdith, height: 240)
        .background(Color.black)
        //.background(HeaderViewBackground(x: $x))
    }
}


// TODO: - 动画背景，需处理...
struct HeaderViewBackground: View {
    
    @State var isAnimate: Bool  = false
    
    @Binding var x: CGFloat
    
    
    var body: some View {
        
        ZStack {
            Image("sidebar_bg")
                .resizable()
                //                    .aspectRatio(contentMode: .fill)
                // 保证图片比例不变 -> 放大， fit： 拉伸，不放大。
                //                    .frame(width: UIScreen.main.bounds.width - 80, height: isAnimate ? 600 : 200)
                .frame(height: 900)
                .offset(x: x, y: isAnimate ? 300 : 0)
                .animation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true))
            
        }
        
        .onAppear() {
            self.isAnimate.toggle()
        }
    }
}


//Users/mishainfotech/Desktop/AttendenceSystem/AttendenceSystem/Dashboard/SideMenu/SideMenuCellView.swift
