//
//  Responsiveframes.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 03/01/24.
//

import Foundation


///by Chirag

//import UIKit
//
//let screenWidth = UIScreen.main.bounds.width
//let screenHeight = UIScreen.main.bounds.height
//
//let guidelineBaseWidth: CGFloat = 350
//let guidelineBaseHeight: CGFloat = 680
//
//func widthPercentageToDP(_ widthPercent: CGFloat) -> CGFloat {
//    let elemWidth = widthPercent
//    return round(screenWidth * elemWidth / 100)
//}
//
//func widthPercentageOrientation( widthPercent: CGFloat,  sWidth: CGFloat) -> CGFloat {
//    let elemWidth = widthPercent
//    return round(sWidth * elemWidth / 100)
//}
//
//func heightPercentageToDP(_ heightPercent: CGFloat) -> CGFloat {
//    let elemHeight = heightPercent
//    return round(screenHeight * elemHeight / 100)
//}
//
//func heightPercentageOrientation( heightPercent: CGFloat,  sHeight: CGFloat) -> CGFloat {
//    let elemHeight = heightPercent
//    return round(sHeight * elemHeight / 100)
//}
//
//func scale(_ size: CGFloat) -> CGFloat {
//    return screenWidth / guidelineBaseWidth * size
//}
//
//func scaleO( size: CGFloat,  sWidth: CGFloat) -> CGFloat {
//    return sWidth / guidelineBaseWidth * size
//}
//
//func verticalScale(_ size: CGFloat) -> CGFloat {
//    return screenHeight / guidelineBaseHeight * size
//}
//
//func verticalScaleO( size: CGFloat,  sHeight: CGFloat) -> CGFloat {
//    return sHeight / guidelineBaseHeight * size
//}
//
//func moderateScale(_ size: CGFloat, factor: CGFloat = 0.5) -> CGFloat {
//    return size + (scale(size) - size) * factor
//}
//
//func moderateScaleO( size: CGFloat,  sWidth: CGFloat, factor: CGFloat = 0.5) -> CGFloat {
//    return size + (scaleO(size: size, sWidth: sWidth) - size) * factor
//}
//
//func responsiveFontSize(_ f: CGFloat) -> CGFloat {
//    let tempHeight = (16 / 9) * screenWidth
//    if UIDevice.current.userInterfaceIdiom == .phone {
//        return sqrt(pow(tempHeight, 2) + pow(screenWidth, 2)) * (f / 100)
//    } else {
//        return sqrt(pow(tempHeight, 2) + pow(screenWidth, 2)) * (f / 180)
//    }
//}





 ///by CHTGPT

import UIKit

class Responsiveframes {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    static let guidelineBaseWidth: CGFloat = 350
    static let guidelineBaseHeight: CGFloat = 680
    
    // Calculate width percentage based on screen width
    static func widthPercentageToDP(_ widthPercent: CGFloat) -> CGFloat {
        return round(screenWidth * widthPercent / 100)
    }
    
    // Calculate width percentage based on another width value
    static func widthPercentageOrientation( widthPercent: CGFloat,  sWidth: CGFloat) -> CGFloat {
        return round(sWidth * widthPercent / 100)
    }
    
    // Calculate height percentage based on screen height
    static func heightPercentageToDP(_ heightPercent: CGFloat) -> CGFloat {
        return round(screenHeight * heightPercent / 100)
    }
    
    // Calculate height percentage based on another height value
    static func heightPercentageOrientation( heightPercent: CGFloat,  sHeight: CGFloat) -> CGFloat {
        return round(sHeight * heightPercent / 100)
    }
    
    // Scale size based on guideline base width
    static func scale(_ size: CGFloat) -> CGFloat {
        return screenWidth / guidelineBaseWidth * size
    }
    
    // Scale size based on another width value
    static func scaleO( size: CGFloat,  sWidth: CGFloat) -> CGFloat {
        return sWidth / guidelineBaseWidth * size
    }
    
    // Vertical scale size based on guideline base height
    static func verticalScale(_ size: CGFloat) -> CGFloat {
        return screenHeight / guidelineBaseHeight * size
    }
    
    // Vertical scale size based on another height value
    static func verticalScaleO( size: CGFloat,  sHeight: CGFloat) -> CGFloat {
        return sHeight / guidelineBaseHeight * size
    }
    
    // Moderate scale size based on guideline base width
    static func moderateScale(_ size: CGFloat, factor: CGFloat = 0.5) -> CGFloat {
        return size + (scale(size) - size) * factor
    }
    
    // Moderate scale size based on another width value
    static func moderateScaleO( size: CGFloat,  sWidth: CGFloat, factor: CGFloat = 0.5) -> CGFloat {
        return size + (scaleO(size: size, sWidth: sWidth) - size) * factor
    }
    
    // Responsive font size based on screen width
    static func responsiveFontSize(_ f: CGFloat) -> CGFloat {
        let tempHeight = (16 / 9) * screenWidth
        if UIDevice.current.userInterfaceIdiom == .phone {
            return sqrt(pow(tempHeight, 2) + pow(screenWidth, 2)) * (f / 100)
        } else {
            return sqrt(pow(tempHeight, 2) + pow(screenWidth, 2)) * (f / 180)
        }
    }
}
