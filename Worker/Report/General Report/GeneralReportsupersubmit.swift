//
//  GeneralReportsupersubmit.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 27/04/24.
//

import Foundation
import SwiftUI

//
//  SuperReportDetails.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 11/01/24.
//


struct GeneralReportsupersubmit: View {
    
    @State private var isSubmittedSelected = true
    @State private var isdraftselected = false
    @State private var searchText = ""
    @Environment(\.presentationMode) var presentationMode
    var reportidmodeldata: WorkerGenralReportModel
    @State private var isDownloading = false
    @State private var progress: Float = 0.0
    @State private var destinationURL: URL?
    
    var documentController: UIDocumentInteractionController?
    
    
    @StateObject var obs = WorkerGeneralReportVM()
    
    @State private var description: String = ""
    @State var imageshow: Bool = false
    
    var body: some View {
        
        
        NavigationView{
            
            ZStack {
                GeometryReader { geometry in
                    
                    
                    VStack(spacing:10.0){
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
                        
                        
                        
                        
                        ScrollView(.vertical , showsIndicators: false){
                            
                            VStack(spacing:30.0){
                                
                                if !obs.workerReportDocResponses.isEmpty {
                                    VStack{
                                        PhotoSliderView(imageUrls: obs.workerReportDocResponses.map { $0.documentUrl })
                                            .frame(width: Responsiveframes.widthPercentageToDP(90))
                                    } .onTapGesture {
                                        imageshow.toggle()
                                    }
                                } else {
                                    Text("No images to display")
                                }
                                
                                
                                
                                
                                VStack{
                                    
                                    VStack( alignment: .leading, spacing:10 ){
                                        
                                        
                                        VStack{
                                            Text("Submitted: \(reportidmodeldata.etaskReportStatus ) Work Report ")
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
                                                
                                                
                                                let datestrng = DateConverter.convertDateFormatwithtime(dateString: reportidmodeldata.createdAt)
                                                
                                                Text("Submitted at " + datestrng)
                                                    .foregroundColor(.black)
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                
                                                Spacer()
                                            }
                                            
                                            
                                            HStack(alignment: .center, spacing:10.0) {
                                                Image("Vector")
                                                // .resizable()
                                                
                                                    .frame(width: Responsiveframes.widthPercentageToDP(4), height: Responsiveframes.widthPercentageToDP(3))
                                                Text(reportidmodeldata.location)
                                                    .foregroundColor(.black)
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                
                                                Spacer()
                                            }
                                            //  .padding()
                                            
                                        }  .frame(width: Responsiveframes.widthPercentageToDP(80))
                                        
                                    }
                                    .frame(width: Responsiveframes.widthPercentageToDP(80))
                                    
                                }
                                
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
                                        
                                        Text(reportidmodeldata.description)
                                            .font(ConstantClass.AppFonts.light)
                                            .foregroundColor(.gray)
                                            .padding(.leading, 5.0)
                                    }
                                    
                                    
                                    HStack(spacing:10){
                                        
                                        Text("Report submitted:")
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                            .foregroundColor(.black)
                                            .padding(.leading, 5.0)
                                        
                                        Text(reportidmodeldata.etaskReportStatus + " Work" )
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.8)))
                                            .foregroundColor(.gray)
                                            .padding(.leading, 5.0)
                                        
                                        Spacer()
                                        
                                    }
                                    VStack{
                                        
                                        
                                        
                                        
                                        Button(action: {
                                            
                                            obs.reportid = reportidmodeldata.reportId
                                            obs.downloadgeneralreport()
                                            
                                        }) {
                                            HStack {
                                                Spacer()
                                                Text("Download Report")
                                                    .foregroundColor(.white)
                                                    .font(ConstantClass.AppFonts.medium)
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(1)
                                                Spacer()
                                            }
                                        }
                                        .frame(width: Responsiveframes.widthPercentageToDP(90),height: Responsiveframes.heightPercentageToDP(6))
                                        .background(Color.accentColor)
                                        .cornerRadius(10)
                                        .multilineTextAlignment(.center)
                                        
                                        .onTapGesture {
                                            
                                            obs.reportid = reportidmodeldata.reportId
                                            obs.downloadgeneralreport()
                                            
                                        }
                                    }
                                    
                                }
                                
                                .frame(width: Responsiveframes.widthPercentageToDP(80))
                                Spacer()
                            }
                            .frame(width: Responsiveframes.widthPercentageToDP(90))
                            
                        }
                        .fullScreenCover(isPresented:$imageshow, content: {
                            ImageViewer2( imageUrls : obs.workerReportDocResponses.map { $0.documentUrl } )
                        })
                    }
                    
                    .frame(width: min(geometry.size.width, geometry.size.height))
                    .onAppear(){
                        obs.reportid = reportidmodeldata.reportId
                        obs.Getreportbyid()
                        
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
}

