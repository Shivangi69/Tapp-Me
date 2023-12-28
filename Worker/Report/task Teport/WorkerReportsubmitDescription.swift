//
//  WorkerReportsubmitDescription.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 09/01/24.
//

import SwiftUI
import Combine

struct WorkerReportsubmitDescription: View {
    
    @State private var isSubmittedSelected = true
    @State private var isdraftselected = false
    @State private var searchText = ""
    @Environment(\.presentationMode) var presentationMode
    var reportidmodeldata: reportidmodel

    
    @StateObject var obs = WorkerSubmittedReportVM()

    @State private var description: String = ""

    var body: some View {
    
        NavigationView{
            ZStack {
                GeometryReader { geometry in
                    
                    ScrollView(.vertical , showsIndicators: false){
                        
                        VStack(spacing:30.0){
                            
                            HStack(spacing: 10){
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                    
                                })
                                {
                                    Image("Arrow Left-8")
                                        .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                                }
                                
                                Text(reportidmodeldata.name)
                                    .fontWeight(.semibold)
                                    .lineLimit(2)
                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                                
                                Spacer()
                            }
                            .frame(width: Responsiveframes.widthPercentageToDP(90))
                            
                            
                            VStack{
                                
                                VStack( alignment: .leading, spacing:10 ){
                                    
                                    
                                    VStack{
                                        Text("Submitted: \(reportidmodeldata.workerReportResponse.etaskReportStatus ) Work by \(reportidmodeldata.employeeID)")
                                            .foregroundColor(.white)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                            .frame(width: Responsiveframes.widthPercentageToDP(60), height: Responsiveframes.heightPercentageToDP(4))
                                            .background(Color.accentColor)
                                            .cornerRadius(6)
                                        
                                        
                                    }
                                    
                                    VStack(spacing:10){
                                        
                                        HStack(alignment: .center, spacing:10.0) {
                                            Image("Clock Circle")
                                                //.resizable()
                                                .frame(width: Responsiveframes.widthPercentageToDP(4), height: Responsiveframes.widthPercentageToDP(3))
                                            
                                            
                                            let datestrng = DateConverter.convertDateFormatwithtime(dateString: reportidmodeldata.workerReportResponse.createdAt)
                                           
                                            Text("Submitted at " + datestrng)
                                                .foregroundColor(.black)
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                            
                                            Spacer()
                                        }
                                        
                                        
                                        HStack(alignment: .center, spacing:10.0) {
                                            Image("Vector")
                                               // .resizable()
                                            
                                                .frame(width: Responsiveframes.widthPercentageToDP(4), height: Responsiveframes.widthPercentageToDP(3))
                                            Text(reportidmodeldata.workerReportResponse.location)
                                                .foregroundColor(.black)
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                            
                                            Spacer()
                                        }
                                        //  .padding()
                                        
                                    }  .frame(width: Responsiveframes.widthPercentageToDP(80))
                                    
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(80))
                                
                            }
                            //  .padding()
                            .frame(width: Responsiveframes.widthPercentageToDP(90),height: Responsiveframes.heightPercentageToDP(20))
                            .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .inset(by: 0.5)
                                    .stroke(Color.black.opacity(0.15), lineWidth: 1)
                            )
                            
                            
                            VStack(alignment: .leading, spacing: 20){
                                
                                VStack(alignment: .leading, spacing: 10){
                                    Text("Description:")
                                        .font(ConstantClass.AppFonts.light)
                                        .foregroundColor(.black)
                                        .padding(.leading, 5.0)
                                    
                                    Text(reportidmodeldata.workerReportResponse.description)
                                        .font(ConstantClass.AppFonts.light)
                                        .foregroundColor(.gray)
                                        .padding(.leading, 5.0)
                                }
                                
                                
                                HStack(spacing:10){
                                    
                                    Text("Report submitted:")
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                        .foregroundColor(.black)
                                        .padding(.leading, 5.0)
                                    
                                    Text(reportidmodeldata.workerReportResponse.etaskReportStatus + " work" )
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.8)))
                                        .foregroundColor(.gray)
                                        .padding(.leading, 5.0)
                                    
                                    Spacer()
                                    
                                }
                                VStack(alignment: .leading, spacing: 10){
                                    
                                    Text("Attached images:")
                                        .font(ConstantClass.AppFonts.light)
                                        .foregroundColor(.black)
                                        .padding(.leading, 5.0)
                                    
                                    HStack{
                                        
                                        // Assuming you have an array of image URLs called imageUrls
                                        // Assuming you want to display images in a 3-column grid
                                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) {
                                            ForEach(obs.workerReportDocRes, id: \.self) { imageUrlString in
                                                
                                                let imageRectangle2Path = imageUrlString.documentURL

                                                AsyncImage(
                                                
                                                    url: URL(string:imageRectangle2Path )!,
                                                    placeholder: {
                                                        Image("material-symbols_image")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: ConstantClass.mediumlogosize.logoWidth, height: ConstantClass.mediumlogosize.logoHeight)
                                                            .clipShape(Rectangle())
                                                            .overlay(Rectangle().stroke(Color.white, lineWidth: 5)) // Border
                                                            .padding(5)
                                                            .border(Color.gray)
                                                    },
                                                    image: { Image(uiImage: $0).resizable() }
                                                )
                                                .padding(5)
                                                .frame(width: ConstantClass.mediumlogosize.logoWidth, height: ConstantClass.mediumlogosize.logoHeight)
                                                .clipShape(Rectangle()) // Ensuring the clip shape applies to AsyncImage
                                                .overlay(Rectangle().stroke(Color.gray, lineWidth: 1)) // Additional border for AsyncImage
                                            }
                                        }

                                    }
                                }
                            }
                            
                            .frame(width: Responsiveframes.widthPercentageToDP(90))
                        
                            
                        }
                        .frame(width: Responsiveframes.widthPercentageToDP(90))
                        
                    }
                    
                  .frame(width: min(geometry.size.width, geometry.size.height), height: max(geometry.size.width, geometry.size.height))
                }
            }
            
            
            .onAppear(){
                
                
                obs.reportid = reportidmodeldata.workerReportResponse.reportID
                obs.Getreportbyid()
                print("rpintvdata" , reportidmodeldata)
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            
        }   .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)

        }
    }


//
//#Preview {
////    WorkerReportsubmitDescription(reportidmodeldata: reportidmodel(taskID: 0, name: "", employeeID: "", employeeName: "", workerReportResponse: WorkerReportResponse(reportID: 0, description: "", location: "", workerReportDocResponses: workerReportDocResponses(documentURL: "", fileName: "", workReportDocID: 0), isDraft: true, isSubmitted: true, isReportSent: true, createdAt: "", etaskReportStatus: "")))
//}
