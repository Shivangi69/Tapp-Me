
import SwiftUI

import SwiftUI

struct Mainview: View {
    
    /// 左边菜单宽度
    @State var leftWidth = UIScreen.main.bounds.width - 90
    /// 偏移量
    @State var offsetX = -UIScreen.main.bounds.width + 80
    
    @State var isDark: Bool = false
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
         
       Dashboard(x: $offsetX, isDark: $isDark)
            
        //    SlideOutMenu(menuWidth: $leftWidth, isDark: $isDark, offsetX: $offsetX)
        }
        
        // 添加手势
//        .gesture(DragGesture().onChanged(onChanged(_:)).onEnded(onEnd(_:)))
        .edgesIgnoringSafeArea(.top)
    }
}
struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    
    var body: some View {
        GeometryReader { geometry in
            Path { path in

                let w = geometry.size.width
                let h = geometry.size.height

                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)

                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(self.color)
        }
    }
}

// MARK: - Actions
extension Mainview {
    
    /// 开始拖动修改
    /// - Parameter value: 拖动的值
    func onChanged(_ value: DragGesture.Value) {
        
        // 拖动时的 X 值
        let currentX = value.translation.width
        
        print("currentX: \(currentX)")
        
        withAnimation {
            if currentX > 0 {
                // 禁用拖动...
                if offsetX < 0 {
                    offsetX = -leftWidth + currentX
                }
            }
            else {
                if offsetX != -leftWidth {
                    offsetX = currentX
                }
            }
        }
    }
    

    func onEnd(_ value: DragGesture.Value) {
        
        withAnimation {
            
            print("x: \(offsetX)")
            
            // 检查是否拖动了菜单值的一半意味着将x设置为0 ...
            if -offsetX < leftWidth / 2 {
                offsetX = 0
            }
            else {
                offsetX = -leftWidth
            }
        }
    }
}



#Preview {
    Mainview()
}

