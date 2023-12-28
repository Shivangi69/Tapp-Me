//
//  SuperWorkerRequestCell.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 10/01/24.
//

import SwiftUI

struct SuperWorkerRequestCell: View {
    var superreqModel : SuperWorkerReqModel
    @State var Checkintime = ""
    let dateTimeString = "2024-02-27 08:30:00" // Example date and time string

    var body: some View {
        
        VStack( spacing: 10){
            // Your VStack content goes here
            
            VStack(alignment: .leading , spacing: 6) {

                
                HStack(spacing: 5){
                    
                    Image("Ellipse 20") // You can replace systemName with the image you prefer.
                        .foregroundColor(Color.black)
                        .frame(width: Responsiveframes.widthPercentageToDP(1),height: Responsiveframes.heightPercentageToDP(1))
                        .padding(.trailing, 10) // Adjust spacing between bullet and text as needed
                    
                    
                    Text(superreqModel.name)
                        .foregroundColor(Color.black)
                        .fontWeight(.semibold)
                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                      
                    + Text(" has requested to ")
                        .foregroundColor(Color.black)
                        .fontWeight(.semibold)
                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                    + Text(superreqModel.flag)
                        .foregroundColor(Color.red)
                        .fontWeight(.semibold)
                         .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                    + Text(" at \(Checkintime)")
                        .foregroundColor(Color.black)
                        .fontWeight(.semibold)
                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                    
                    Spacer()
                }
                
            }
            
            HStack{
                
                Button(" APPROVE "){
                    //   isShowingPopup = false
                     
                }
                .frame(width: (Responsiveframes.widthPercentageToDP(40))/2,height: Responsiveframes.heightPercentageToDP(6))
                .foregroundColor(.white)
                .background(Color.greenapp)
                
                .cornerRadius(2) // Adjust the corner radius as needed

                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                
                .onTapGesture {
                    
                }
                
                Spacer()
                
                Button(" REJECT "){
                    //   isShowingPopup = false
                }
                .frame(width: (Responsiveframes.widthPercentageToDP(40))/2,height: Responsiveframes.heightPercentageToDP(6))
                .foregroundColor(.white)
                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                .cornerRadius(2) // Adjust the corner radius as needed

                .background(Color.red)
                
                
                .onTapGesture {
                    
                }
                
                
            }
         .frame(width: (Responsiveframes.widthPercentageToDP(40))/2)

       
            
        }

    
        .padding()
         .frame(width: Responsiveframes.widthPercentageToDP(90))
              .background(Color.white) // Set the background color if needed
              .cornerRadius(8) // Adjust the corner radius as needed
              .overlay(
                  RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 0.5) // Border color and width
              )
              //  .shadow(color: Color.gray.opacity(0.5), radius: 5, x: -2, y: 2) // Left and bottom shadow
             //.shadow(color: Color.gray.opacity(0.5), radius: 5, x: 2, y: 2) // Right and bottom shadow
             .onAppear {
                 if let time = getTime(from: superreqModel.requestTime) {
                               print("Time only: \(time)")
                          Checkintime = time
                           } else {
                               print("Invalid date format")
                           }
                       }
             
        
    }
    func getTime(from dateTimeString: String) -> String? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
           
           if let date = dateFormatter.date(from: dateTimeString) {
               let timeFormatter = DateFormatter()
               timeFormatter.dateFormat = "hh:mm a"
               return timeFormatter.string(from: date)
           } else {
               return nil
           }
       }
    
    
}
//
//#Preview {
//    SuperWorkerRequestCell()
//}

