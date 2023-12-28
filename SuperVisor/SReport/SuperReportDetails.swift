//
//  SuperReportDetails.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 11/01/24.
//

import SwiftUI

struct SuperReportDetails: View {
   
    @State private var isSubmittedSelected = true
    @State private var isdraftselected = false
    @State private var searchText = ""
    @Environment(\.presentationMode) var presentationMode
    var reportidmodeldata: reportidmodel

    @State var imageshow: Bool = false
    @StateObject var obs = WorkerSubmittedReportVM()

    @State private var description: String = ""
    
    
    
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
                        
//                        
//                        PhotoSliderView(images: ["e93dd2790ba3df7fce985b7e532dcf18", "profileimg", "e93dd2790ba3df7fce985b7e532dcf18"])
//                        
                        if !obs.workerReportDocRes.isEmpty {
                            VStack{
                                PhotoSliderView(imageUrls: obs.workerReportDocRes.map { $0.documentURL })
                                    .frame(width: Responsiveframes.widthPercentageToDP(90))
                                
                            }  .onTapGesture {
                                imageshow.toggle()
                            }
                                 } else {
                                     
                                     
                                     Text("No images to display")
                                 }
                        
                        
                        
                        
                           // .frame(width: Responsiveframes.widthPercentageToDP(90))
                        
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
                            
                            Button(action: {
                                // Add your sign-in action here
                                
                                obs.reportid = reportidmodeldata.workerReportResponse.reportID
                                obs.downloadtaskreport()
                                
                                

                                
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
                                
                                obs.reportid = reportidmodeldata.workerReportResponse.reportID
                                obs.downloadtaskreport()
                            }
                         
                            
                        }
                        
                        .frame(width: Responsiveframes.widthPercentageToDP(80))
                        Spacer()
                    }
                    .frame(width: Responsiveframes.widthPercentageToDP(90))
                    .fullScreenCover(isPresented:$imageshow, content: {
                        ImageViewer2( imageUrls : obs.workerReportDocRes.map { $0.documentURL } )
                   })
                }
            }
                
                .frame(width: min(geometry.size.width, geometry.size.height))
                .onAppear(){
                    obs.reportid = reportidmodeldata.workerReportResponse.reportID
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




struct PhotoSliderView: View {
    let imageUrls: [String] // URLs of images
    
    @State private var currentIndex: Int = 0

    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                // Load the image from a URL
                if let url = URL(string: imageUrls[currentIndex]) {
                    AsyncImage(
                        url: url,
                        placeholder: {
                            ProgressView()
                        },
                        image: { Image(uiImage: $0).resizable() }
                    )
                    .id(currentIndex) // Ensure the view is recreated when currentIndex changes

                    .aspectRatio(contentMode: .fill)
                    .frame(width: Responsiveframes.widthPercentageToDP(90), height: 200)

                    .clipped()
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 0.5)
                            .stroke(Color.black.opacity(0.15), lineWidth: 1)
                    )
                }
                
                // Navigation buttons
                HStack {
                    Button(action: {
                        self.showPreviousImage()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button(action: {
                        self.showNextImage()
                    }) {
                        Image(systemName: "chevron.right")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
                .offset(y: -60)
                .padding()
                
                // Indicators
                HStack(alignment: .bottom, spacing: 10) {
                   ForEach(0..<imageUrls.count, id: \.self) { index in
                        
                      //  ForEach(0..<imageUrls.count) { index in

                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(index == self.currentIndex ? .blue : .gray)
                            .onTapGesture {
                                self.currentIndex = index
                            }
                    }
                }
                .padding(.bottom, 10)
            }
        }
    }
//    
//    private func showNextImage() {
//        currentIndex = (currentIndex + 1) % imageUrls.count
//    }
//    
//    private func showPreviousImage() {
//        currentIndex = (currentIndex - 1 + imageUrls.count) % imageUrls.count
//    }
    
    private func showNextImage() {
        currentIndex = (currentIndex + 1) % imageUrls.count
        print("Next Index: \(currentIndex)")
    }

    private func showPreviousImage() {
        currentIndex = (currentIndex - 1 + imageUrls.count) % imageUrls.count
        print("Previous Index: \(currentIndex)")
    }
}




//
//#Preview {
//    SuperReportDetails()
//}
struct PhotoSliderView1: View {
    let imageUrls: [String] // URLs of images
    
    @State private var currentIndex: Int = 0

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                ForEach(imageUrls.indices, id: \.self) { index in
                    // Load the image from a URL
                    if let url = URL(string: imageUrls[index]) {
                        AsyncImage(
                            url: url,
                            placeholder: {
                                ProgressView()
                            },
                            image: { Image(uiImage: $0).resizable() }
                        )
                        .id(index) // Ensure the view is recreated when currentIndex changes
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .clipped()
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .inset(by: 0.5)
                                .stroke(Color.black.opacity(0.15), lineWidth: 1)
                        )
                    }
                }
            }
        }
        .onAppear {
            currentIndex = 0 // Ensure currentIndex is reset when the view appears
        }
    }
}
import SwiftUI

struct PhotoSliderView2: View {
    let imageUrls: [String] // URLs of images
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(imageUrls.indices, id: \.self) { index in
                if let url = URL(string: imageUrls[index]) {
                    AsyncImage(
                        url: url,
                        placeholder: {
                            ProgressView()
                        },
                        image: { Image(uiImage: $0).resizable() }
                    )
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width-90, height: UIScreen.main.bounds.height-20)
//                    .clipped()
//                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 20)
//                            .inset(by: 0.5)
//                            .stroke(Color.black.opacity(0.15), lineWidth: 1)
//                    )
                }
            }
        }
    }
}
