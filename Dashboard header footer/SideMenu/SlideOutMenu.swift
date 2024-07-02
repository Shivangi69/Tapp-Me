//
//  SlideOutMenu.swift
//  SlideOutMenu
//
//  Created by Liu Chuan on 2020/12/05.
//

import SwiftUI

struct SlideOutMenu: View {
    
    /// 左边菜单栏的宽度
    @Binding var menuWidth: CGFloat
    
    @Binding var isDark: Bool
    
    @Binding var offsetX: CGFloat
    
    private let edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            
            VStack(spacing: 0) {
                
               //
                MenuHeaderView(wdith: $menuWidth ,x: $offsetX)
                
                SideMenuCellView(wdith: $menuWidth,x: $offsetX)
                  //  .offset( y: -20)
//                Divider()   //分割线
//                
//               //
//                MenuBottomView(wdith: $menuWidth, isDark: $isDark)
            }.background(Color.black)
        }
        .padding(.trailing, UIScreen.main.bounds.width - menuWidth + 10)
        .edgesIgnoringSafeArea(.bottom)
        /* 阴影的处理 */
        .shadow(color: Color.black.opacity(offsetX != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
        .offset(x: offsetX)
        .background(
            Color.black.opacity(offsetX == 0 ? 0.5 : 0)     // 右边阴影
                .ignoresSafeArea(.all, edges: .vertical)
                .onTapGesture {
                    withAnimation {
                        offsetX = -menuWidth  //点击阴影，修改offset，从而隐藏menu
            }
        })
    }
}
