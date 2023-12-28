//
//  SuperWorkerRequest.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 10/01/24.
//

import SwiftUI

struct SuperWorkerRequest: View {
    @Environment(\.presentationMode) var presentationMode
    @State var showgeofenceRequest: Bool = false

    @StateObject var obs = SuperworkerReqVM()

    @State var Checkintime = ""
    let dateTimeString = "2024-02-27 08:30:00" // Example date and time string

    @State var showcompanypicker: Bool = false
    @State var CompanyName : String? = nil
    var body: some View {
        NavigationView{

        ZStack {
            GeometryReader { geometry in
                
            //    ScrollView(.vertical , showsIndicators: false){

                VStack{
                    HStack{
                        
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                            
                        })
                        {
                            Image("Arrow Left-8")
                                .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                            
                        }
                        
//                        Spacer()
                        Text("Workers Requests")
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                            .foregroundColor(Color.black)
                        
                        
                        Spacer()
                        
                    }
                    .frame(width: Responsiveframes.widthPercentageToDP(90))
                    Spacer()
                    if obs.rcnt.count !=  0  {
                      
                        
                         ScrollView(.vertical , showsIndicators: false){

                            LazyVStack{
                                
                                ForEach(obs.rcnt, id: \.self) { superreqModel in
                                    VStack( spacing: 10){
                                        
                                        VStack(alignment: .leading , spacing: 6) {
                                            
                                            HStack{
                                                
                                                
                                                let starttime = DateConverter.convertDatetotime(dateString:  superreqModel.requestTime)
                                                
                                                Image("Ellipse 20") // You can replace systemName with the image you prefer.
                                                    .foregroundColor(Color.black)
                                                    .frame(width: Responsiveframes.widthPercentageToDP(1),height: Responsiveframes.heightPercentageToDP(1))
                                                    .padding(.trailing, 10) // Adjust spacing between bullet and text as needed
                                                
                                                Text(superreqModel.name)
                                                    .foregroundColor(Color.lightblue)
                                                    .fontWeight(.semibold)
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                  
                                                + Text(" has requested to ")
                                                    .foregroundColor(Color.black)
                                                    .fontWeight(.semibold)
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                +
                                                Text(superreqModel.flag)
                                                    .fontWeight(.semibold)
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                    .foregroundColor(superreqModel.flag == "CHECK-IN" ? Color.green : Color.red)
                                                
                                                +
                                                
                                                
                                                
//                                                let starttime = DateConverter.convertDatetotime(dateString:  superreqModel.requestTime)
                                                
                                                 Text(" at \(starttime)")
                                                    .foregroundColor(Color.black)
                                                    .fontWeight(.semibold)
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                
                                                Spacer()
                                            }
                                            
                                        }
                                        
                                        HStack{
                                            
                                            Button(" APPROVE "){
                                                //   isShowingPopup = false
                                                if superreqModel.flag == "CHECK-IN-OVER-TIME"{
                                                    obs.flattype = "CHECK-IN"
                                                    obs.requestid = superreqModel.requestId
                                                    obs.status = "APPROVED"
                                                    
                                                    obs.OvertimeupdateapiAR()
                                                    obs.Superreqapi()
                                                   
                                                    
                                                    
                                                }
                                                
                                                
                                        if superreqModel.flag == "CHECK-OUT-OVER-TIME"{
                                                    obs.flattype = "CHECK-OUT"
                                                    obs.requestid = superreqModel.requestId
                                                    obs.status = "APPROVED"
                                                    
                                                    obs.OvertimeupdateapiAR()
                                                    obs.Superreqapi()
                                                   
                                                    
                                                    
                                                }
                                                
                                                
                                                
                                                
                                                
                                                else {
                                                    obs.flattype = superreqModel.flag
                                                    obs.requestid = superreqModel.requestId
                                                    obs.status = "APPROVED"
                                                    
                                                    obs.updateapiAR()
                                                    
                                                    
                                                    obs.Superreqapi()
                                                    
                                                }
                                                
                                                
                                            }
                                            .frame(width: (Responsiveframes.widthPercentageToDP(40))/2,height: Responsiveframes.heightPercentageToDP(6))
                                            .foregroundColor(.white)
                                            .background(Color.greenapp)
                                            
                                            .cornerRadius(2) // Adjust the corner radius as needed

                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                            
                                            .onTapGesture {
                                                
                                                if superreqModel.flag == "CHECK-IN-OVER-TIME"{
                                                    obs.flattype = "CHECK-IN"
                                                    obs.requestid = superreqModel.requestId
                                                    obs.status = "APPROVED"
                                                    
                                                    obs.OvertimeupdateapiAR()
                                                    obs.Superreqapi()
                                                   
                                                    
                                                    
                                                }
                                                
                                                
                                                if superreqModel.flag == "CHECK-OUT-OVER-TIME"{
                                                    obs.flattype = "CHECK-OUT"
                                                    obs.requestid = superreqModel.requestId
                                                    obs.status = "APPROVED"
                                                    
                                                    obs.OvertimeupdateapiAR()
                                                    obs.Superreqapi()
                                                   
                                                    
                                                    
                                                }
                                                
                                                
                                                
                                                else{
                                                    obs.flattype = superreqModel.flag
                                                    obs.requestid = superreqModel.requestId
                                                    obs.status = "APPROVED"
                                                    obs.updateapiAR()
                                                    obs.Superreqapi()
                                                    
                                                }
                                              //  obs.Superreqapi()

                                            }
                                            
                                            Spacer()
                                            
                                            Button(" REJECT "){
                                                //   isShowingPopup = false
                                                
                                                
                                                if superreqModel.flag == "CHECK-IN-OVER-TIME"{
                                                    obs.flattype = "CHECK-IN"
                                                    obs.requestid = superreqModel.requestId
                                                    obs.status = "DENIED"
                                                    
                                                    obs.OvertimeupdateapiAR()
                                                    obs.Superreqapi()
                                                   
                                                    
                                                    
                                                }
                                                
                                                
                                                if superreqModel.flag == "CHECK-OUT-OVER-TIME"{
                                                    obs.flattype = "CHECK-OUT"
                                                    obs.requestid = superreqModel.requestId
                                                    obs.status = "DENIED"
                                                    
                                                    obs.OvertimeupdateapiAR()
                                                    obs.Superreqapi()
                                                   
                                                    
                                                    
                                                }
                                                
                                                
                                                
                                                
                                                else{
                                                    
                                                    obs.flattype = superreqModel.flag
                                                    obs.requestid = superreqModel.requestId
                                                    obs.status = "DENIED"
                                                    obs.updateapiAR()
                                                    obs.Superreqapi()
                                                    
                                                }
                                               // obs.Superreqapi()

                                            }
                                            .frame(width: (Responsiveframes.widthPercentageToDP(40))/2,height: Responsiveframes.heightPercentageToDP(6))
                                            .foregroundColor(.white)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                            .cornerRadius(2) // Adjust the corner radius as needed

                                            .background(Color.red)
                                            
                                            .onTapGesture {
                                                
                                                
                                                
                                                
                                                if obs.flattype == "CHECK-IN-OVER-TIME"{
                                                    obs.flattype = "CHECK-IN"
                                                    obs.requestid = superreqModel.requestId
                                                    obs.status = "DENIED"
                                                    
                                                    obs.OvertimeupdateapiAR()
                                                    obs.Superreqapi()
                                                   
                                                    
                                                }

                                                
                                                if obs.flattype == "CHECK-OUT-OVER-TIME"{
                                                    obs.flattype = "CHECK-OUT"
                                                    obs.requestid = superreqModel.requestId
                                                    obs.status = "DENIED"
                                                    
                                                    obs.OvertimeupdateapiAR()
                                                    obs.Superreqapi()
                                                   
                                                    
                                                }
                                                
                                                obs.flattype = superreqModel.flag
                                                obs.requestid = superreqModel.requestId
                                                obs.status = "DENIED"
                                                obs.updateapiAR()
                                                obs.Superreqapi()

                                             //   obs.Superreqapi()
                                                
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
//                                           .onAppear {
//                                             if let time = getTime(from: superreqModel.requestTime) {
//                                                           print("Time only: \(time)")
//                                                      Checkintime = time
//                                                       } else {
//                                                           print("Invalid date format")
//                                                       }
//                                                   }
                                         
                                }
                                

                                 
                                
                            }   .frame(width: Responsiveframes.widthPercentageToDP(90))
                        }
                    }
                    
                    else {
                        
                        EmptyListView(screenName: "SuperWorkerRequest")
                        Spacer()
                    }
                      
                    }      .frame(width: Responsiveframes.widthPercentageToDP(90))

             //   }
                
                
               .frame(width: min(geometry.size.width, geometry.size.height), height: max(geometry.size.width, geometry.size.height))
                
                
                NavigationLink(destination: SuperRequestForGeofence(), isActive: $showgeofenceRequest) { EmptyView() }
                

            }
            
            .onAppear(){
                obs.Superreqapi()
            }
        }
            
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
        
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)

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

struct dropdown1: View {
    
    @Binding var value: String?
    @State var value1 = ""
    @Binding var showCompanyPicker: Bool
    
    let companyList = ["Approved", "Rejected"]
    var placeholder = "Approved"
    
    var body: some View {
        
        HStack {
            Menu {
                ForEach(companyList, id: \.self) { company in
                    Button(action: {
                        self.value1 = company
                        self.value = company
                        self.showCompanyPicker.toggle()
                    }) {
                        Text(company)
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                            .foregroundColor(Color.blue) // Set text color to blue
                    }
                }
            } label: {
                VStack(spacing: 5) {
                    HStack {
                        Text(value1.isEmpty ? placeholder : value1)
                            .foregroundColor(value1.isEmpty ? .blue : .blue) // Set text color to blue
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                            .padding(.leading, 5)
                            .lineLimit(1)
                        Spacer()
                        Image("Alt Arrow Down")
                            .foregroundColor(.blue) // Set arrow color to blue
                    .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                    }
                    
                }
            }
        }
        .frame(width: Responsiveframes.widthPercentageToDP(33), height: Responsiveframes.heightPercentageToDP(5))
        
        .background(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.blue, lineWidth: 1) // Set border color to blue
        )
    }
}

#Preview {
    SuperWorkerRequest()
}
