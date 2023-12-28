//
//  ConstantClass.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 03/01/24.
//

import Foundation
import SwiftUI

// Colors
class ConstantClass{
    
    struct AppColors {
        static let primary = Color(hex: 0x2A89BA)
        static let secondary = Color(hex: 0xEBAD1E)
        static let navy = Color(hex: 0x001e3e)
        static let cherry = Color(hex: 0xdd003e)
        
        // ... (add other color constants)
    }
    
    // Fonts
    struct AppFonts {
        static let light = Font.custom("Poppins-Black-Light",  size: Responsiveframes.responsiveFontSize(2.0))
        

        static let medium = Font.custom("Poppins-Black-Medium", size: Responsiveframes.responsiveFontSize(2.0))
        
        static let bold = Font.custom("Poppins-Black-Bold", size: Responsiveframes.responsiveFontSize(2.0))
        
        static let textlight = Font.custom("Poppins-Black-Light",  size: Responsiveframes.responsiveFontSize(2.6))
        
        static let lighttextsize = Font.custom("Poppins-Black-Light",  size: Responsiveframes.responsiveFontSize(2.0))

        static let textmedium = Font.custom("Poppins-Black-Medium", size: Responsiveframes.responsiveFontSize(2.6))
        static let textbold = Font.custom("Poppins-Black-Bold", size: Responsiveframes.responsiveFontSize(2.6))
        
        
        
        // ... (add other font constants)
    }
    

    struct mediumlogosize {
        static let logoWidth: CGFloat = Responsiveframes.heightPercentageToDP(10)
        static let logoHeight: CGFloat = Responsiveframes.heightPercentageToDP(10)
        
        static let logoWidth2: CGFloat = Responsiveframes.heightPercentageToDP(5)
        static let logoHeight2: CGFloat = Responsiveframes.heightPercentageToDP(5)
        
        
        static let logoWidth1: CGFloat = Responsiveframes.widthPercentageToDP(10)
        static let logoHeight1: CGFloat = Responsiveframes.widthPercentageToDP(10)
   
        
        
        // ... (add other font constants)
    }
    
    
    struct verybiglogo {
        static let logoWidth: CGFloat = Responsiveframes.widthPercentageToDP(50)
        static let logoHeight: CGFloat = Responsiveframes.widthPercentageToDP(50)
        
        // ... (add other font constants)
    }
    
    // for all loginscreen
    struct HstackTextFieldSize {
        static let width: CGFloat = Responsiveframes.widthPercentageToDP(90)
          static let height: CGFloat = Responsiveframes.heightPercentageToDP(6)
        
        static let w1: CGFloat = Responsiveframes.widthPercentageToDP(75)
          static let h1: CGFloat = Responsiveframes.heightPercentageToDP(6)
        
        
        
        static let wwi: CGFloat = Responsiveframes.widthPercentageToDP(60)
          static let hhi: CGFloat = Responsiveframes.heightPercentageToDP(6)
      
        
        static let width1: CGFloat = Responsiveframes.widthPercentageToDP(40)
          static let height1: CGFloat = Responsiveframes.heightPercentageToDP(5)
      
        // ... (add other font constants)
    }
    
    
    struct Emptytextfield {
        static let width: CGFloat = Responsiveframes.widthPercentageToDP(90)
          static let height: CGFloat = Responsiveframes.heightPercentageToDP(5)
        
        static let textdescriptionwidth: CGFloat = Responsiveframes.widthPercentageToDP(90)
          static let textdescriptionheight: CGFloat = Responsiveframes.heightPercentageToDP(15)
        
        static let cornerRadius: CGFloat = 6
           
        static let datewdth: CGFloat = Responsiveframes.widthPercentageToDP(35)
          static let dateheigh: CGFloat = Responsiveframes.heightPercentageToDP(5)
       
        static let datewdth1: CGFloat = Responsiveframes.widthPercentageToDP(40)
          static let dateheigh1: CGFloat = Responsiveframes.heightPercentageToDP(5)
       
        
        static let width1: CGFloat = Responsiveframes.widthPercentageToDP(75)
          static let height1: CGFloat = Responsiveframes.heightPercentageToDP(5)
      
        
        
           // Add other font constants here
           
           static func getOverlay() -> some View {
               RoundedRectangle(cornerRadius: cornerRadius)
                   .inset(by: 0.50)
                   .stroke(Color(red: 0, green: 0, blue: 0).opacity(0.30), lineWidth: 0.50)
           }
        // ... (add other font constants)
    }
    
    struct bigimagesize {
        static let logoWidth: CGFloat = Responsiveframes.widthPercentageToDP(15)
        static let logoHeight: CGFloat = Responsiveframes.widthPercentageToDP(15)
        
        
        static let notifywidth: CGFloat = Responsiveframes.widthPercentageToDP(6)
        static let notifyHeight: CGFloat = Responsiveframes.widthPercentageToDP(6)
        static let notifyw: CGFloat = Responsiveframes.widthPercentageToDP(18)
        static let notifyH: CGFloat = Responsiveframes.widthPercentageToDP(18)
        
        // ... (add other font constants)
    }
    
    struct smalltextimagesize {
        static let logoWidth: CGFloat = Responsiveframes.widthPercentageToDP(4)
        static let logoHeight: CGFloat = Responsiveframes.widthPercentageToDP(20)
        
        
        // ... (add other font constants)
    }
    
    // Images
    struct AppImages {
        static let notFound = Image("ImageNotFound")
        static let addNotFound = Image("Addblock")
        // ... (add other image constants)
    }
    
    // Sizes
    struct AppSizes {
        static let padding = EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
    }
    
    // Styles
    struct AppStyles {
        static let container = Color.white
        static let shadow = Color.black.opacity(0.25)
        // ... (add other styles)
    }
    
    // SwiftUI View
    
}

// Hex Color Extension
extension Color {
    init(hex: Int, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}
