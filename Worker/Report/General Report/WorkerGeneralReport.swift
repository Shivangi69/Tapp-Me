//
//  WorkerGeneralReport.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 05/01/24.
//

import SwiftUI
import CoreLocation
import Alamofire
import SSSwiftUILoader

struct WorkerGeneralReport: View {
//
//    @State private var Report: String = ""
//    @State private var description: String = ""
//    
    @State   var dataArr = NSMutableArray()

    @State   var showview = false

    @State var image = UIImage(named: "AppIcon")
    @State private var backgroundDisabled = false

    @State private var isShowingPopup = false

    @State var cmrstr = String()
    @State var showImagePicker: Bool = false
    
    @State var showcompanypicker: Bool = false
    @State var CompanyName : String? = nil
    let radius: CGFloat = 65
    var offset: CGFloat {
        sqrt(radius * radius / 2)
    }
    @ObservedObject var locationManager = LocationManager()
    @State private var showingActionSheet = false
    @State private var selectedImages: [UIImage] = []
    
    @StateObject var tasklistviewVM = TaskListViewVM()

    @State private var mainview = false
    @State private var isshowreportpopup = false

    @State  var textStyle = UIFont.TextStyle.body

    @Environment(\.presentationMode) var presentationMode
    
    @State private var WorkerReportDraftDescription = false
    @State private var WorkerGeneralReport = false
    @State private var WorkkerCheckin = false
    

    var body: some View {
        
        NavigationView{
            ZStack {
                GeometryReader { geometry in
                    
                    VStack{
                        
                        ScrollView(.vertical , showsIndicators: false){
                            
                            VStack{
                                
                                VStack(alignment: .center, spacing: 20){
                                    HStack{
                                        
                                        Button(action: {
                                            self.presentationMode.wrappedValue.dismiss()
                                            
                                        })
                                        {
                                            Image("Arrow Left-8")
                                                .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                                            
                                        }
                                        
                                        Text("New Report")
                                        
                                            .fontWeight(.semibold)
                                            .lineLimit(1)
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(.black)
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                                        Spacer()

                                    }
                                    
                                    .frame(width: Responsiveframes.widthPercentageToDP(90))
                                    VStack(spacing: 20){
                                        
                                        VStack(alignment: .leading){

                                        VStack(alignment: .leading){
                                            Text("Report name")
                                                .font(ConstantClass.AppFonts.light)
                                                .foregroundColor(.black)
                                                .padding(.leading, 5.0)
                                            //         TextField(text: $fullname)
                                            TextField("Enter Report Name", text: $tasklistviewVM.Reportname)
                                                .padding(.leading, 5.0)
                                                .font(ConstantClass.AppFonts.light)

                                               .frame(width:ConstantClass.Emptytextfield.width, height: ConstantClass.Emptytextfield.height1)
                                                .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
                                                .overlay(
                                                    ConstantClass.Emptytextfield.getOverlay()
                                                )
                                        }
                                            
                                        
                                            if (tasklistviewVM.showError && ((tasklistviewVM.errorState).object(forKey: "name") != nil)){
                                                if let emailErrors = tasklistviewVM.errorState["name"] as? [String], !emailErrors.isEmpty {
                                                    ForEach(emailErrors, id: \.self) { errorMessage in
                                                        HStack(spacing: 15) {
                                                            Text(errorMessage)
                                                                .foregroundColor(.red)
                                                            //       .padding(.leading, 16)
                                                                .multilineTextAlignment(.leading)
                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.4)))
                                                            
                                                            Spacer()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                        VStack(alignment: .leading){
                                            
                                            VStack(alignment: .leading){
                                                Text("Description")
                                                    .font(ConstantClass.AppFonts.light)
                                                    .foregroundColor(.black)
                                                    .padding(.leading, 5.0)
                                                //         TextField(text: $fullname)
                                                TextField("Enter Description...", text: $tasklistviewVM.descriptionText)
                                                    .padding(.leading, 5.0)
                                                    .font(ConstantClass.AppFonts.light)

                                                    .multilineTextAlignment(.leading)
                                                    .frame(width:ConstantClass.Emptytextfield.width, height: ConstantClass.Emptytextfield.height1)                                            .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
                                                    .overlay(
                                                        ConstantClass.Emptytextfield.getOverlay()
                                                    )
                                            }
                                            
                                            
                                            if (tasklistviewVM.showError && ((tasklistviewVM.errorState).object(forKey: "description") != nil)){
                                                if let emailErrors = tasklistviewVM.errorState["description"] as? [String], !emailErrors.isEmpty {
                                                    ForEach(emailErrors, id: \.self) { errorMessage in
                                                        HStack(spacing: 15) {
                                                            Text(errorMessage)
                                                                .foregroundColor(.red)
                                                            //       .padding(.leading, 16)
                                                                .multilineTextAlignment(.leading)
                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.4)))
                                                            
                                                            Spacer()
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        
                                        VStack(alignment: .leading){
                                            Text("Report Status")
                                                .font(ConstantClass.AppFonts.light)
                                                .foregroundColor(.black)
                                                .padding(.leading, 5.0)
                                            
                                            ReportlistPickerView1(value: $CompanyName,
                                                                  showCompanyPicker: $showcompanypicker,
                                                                  onChange: {
                                                if CompanyName == "After" {
                                                    
                                                    tasklistviewVM.eTaskReportStatus = "After"
                                                    //  tasklistviewVM.Getalltaskreport()
                                                    
                                                } else if CompanyName == "Before" {
                                                    tasklistviewVM.eTaskReportStatus = "Before"
                                                    
                                                }
                                                
                                                else if CompanyName == "During" {
                                                    tasklistviewVM.eTaskReportStatus = "During"
                                                }
                                            })
                                        }
                                        .frame(width:ConstantClass.Emptytextfield.width1, height: ConstantClass.Emptytextfield.height1)
                                        
                                        
                                        VStack(alignment: .leading){
                                            Text("Attach images")
                                                .font(ConstantClass.AppFonts.light)
                                                .foregroundColor(.black)
                                                .padding(.leading, 5.0)
                                            
                                            
                                            VStack(spacing: 20.0) {
                                                HStack {
                                                    HStack {
                                                        Text("Upload")
                                                            .padding(.leading, 5.0)
                                                            .multilineTextAlignment(.leading)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                                            .foregroundColor(.gray)
                                                        Image("Upload Minimalistic") // Add your upload icon system name
                                                        Spacer()
                                                    }
                                                    .onTapGesture {
                                                        self.showingActionSheet = true
                                                    }
                                                    .padding(.leading, 5.0)
                                                    .frame(width: ConstantClass.Emptytextfield.width, height: ConstantClass.Emptytextfield.height1)
                                                    .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
                                                    .overlay(ConstantClass.Emptytextfield.getOverlay())
                                                
                                                    .actionSheet(isPresented: $showingActionSheet) {
                                                        ActionSheet(title: Text("Choose"), message: Text(""), buttons: [
                                                            .default(Text("Camera")) {
                                                                self.showImagePicker.toggle()
                                                                cmrstr = "Camera"
                                                            },
                                                            .default(Text("Gallery")) {
                                                                self.showImagePicker.toggle()
                                                                cmrstr = "Gallery"
                                                            },
                                                            .cancel()
                                                        ])
                                                    }
                                                    .sheet(isPresented: $showImagePicker) {
                                                        if cmrstr == "Camera" {
                                                            ImagePickerView1(sourceType: .camera) { images in
                                                                for image in images {
                                                                    self.selectedImages.append(image)
                                                                }
                                                            }
                                                        } else if cmrstr == "Gallery" {
                                                            ImagePickerView1(sourceType: .photoLibrary) { images in
                                                                for image in images {
                                                                    self.selectedImages.append(image)
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                                .onTapGesture {
                                                    self.showingActionSheet = true
                                                }

                                                
                                                
                                                
                                                
//                                                HStack {
//                                                    Text("Upload")
//                                                        .padding(.leading, 5.0)
//                                                        .multilineTextAlignment(.leading)
//                                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
//                                                        .foregroundColor(.gray)
//                                                    Image("Upload Minimalistic") // Add your upload icon system name
//                                                    Spacer()
//                                                }
//                                                .onTapGesture {
//                                                    // Open gallery or camera here
//                                                    self.showingActionSheet = true
//                                                }
//                                                .padding(.leading, 5.0)
//                                                .frame(width: ConstantClass.Emptytextfield.width, height: ConstantClass.Emptytextfield.height1)
//                                                .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
//                                                .overlay(ConstantClass.Emptytextfield.getOverlay())
//                                                .overlay(
//                                                    Button(action: {
//                                                        self.showingActionSheet = true
//                                                    }) {
//                                                        Image("icon")
//                                                            .clipShape(Circle())
//                                                            .background(
//                                                                Circle()
//                                                                    .stroke(Color.white, lineWidth: 2)
//                                                            )
//                                                    }
//                                                        .offset(x: offset, y: -offset)
//                                                )
//                                                .actionSheet(isPresented: $showingActionSheet) {
//                                                    ActionSheet(title: Text("Choose"), message: Text(""), buttons: [
//                                                        .default(Text("Camera")) {
//                                                            self.showImagePicker.toggle()
//                                                            cmrstr = "Camera"
//                                                        },
//                                                        .default(Text("Gallery")) {
//                                                            self.showImagePicker.toggle()
//                                                            cmrstr = "Gallery"
//                                                        },
//                                                        .cancel()
//                                                    ])
//                                                }
//                                                .sheet(isPresented: $showImagePicker) {
//                                                    if cmrstr == "Camera" {
//                                                        ImagePickerView1(sourceType: .camera) { images in
//                                                            for image in images {
//                                                                self.selectedImages.append(image)
//                                                            }
//                                                        }
//                                                    } else if cmrstr == "Gallery" {
//                                                        ImagePickerView1(sourceType: .photoLibrary) { images in
//                                                            for image in images {
//                                                                self.selectedImages.append(image)
//                                                            }
//                                                        }
//                                                    }
//                                                }
//                                                
//                                                .onChange(of: selectedImages) { _ in
//                                                    if !selectedImages.isEmpty {
//                                                        uploadImagesToAPI()
//                                                        
//                                                    }
//                                                }
                                                LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 10) {
                                                    ForEach(selectedImages.indices, id: \.self) { index in
                                                        ZStack {
                                                            // Image
                                                            Image(uiImage: selectedImages[index])
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fill)
                                                                .frame(width: ConstantClass.mediumlogosize.logoWidth, height: ConstantClass.mediumlogosize.logoHeight)
                                                                .clipShape(Rectangle())
                                                                .overlay(Rectangle().stroke(Color.white, lineWidth: 5)) // Border
                                                                .padding(5)
                                                                .border(Color.gray)
                                                            // Padding from the border
                                                            
                                                            // Delete Button
                                                            Button(action: {
                                                                // Remove the selected image when delete button is tapped
                                                                selectedImages.remove(at: index)
                                                            }) {
                                                                Image("Group 1000001084")
                                                                    .resizable()
                                                                    .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8)) // Adjust the size as needed
                                                                    .foregroundColor(Color.red)
                                                                    .background(Color.white)
                                                                    .clipShape(Circle())
                                                                    .offset(x: 35, y: -35) // Adjust the position as needed
                                                            }
                                                            .buttonStyle(PlainButtonStyle())
                                                        }
                                                    }
                                                }
                                                
                                            }
                                             
                                            VStack(alignment: .center, spacing: 15){
                                                
                                                Button(action: {
                              
                                                    isShowingPopup.toggle()
                                                  
                                                }) {
                                                    HStack {
                                                        Spacer()
                                                        Text("Submit Report")
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
                                             
                                                    isShowingPopup.toggle()

                                                }
                                                
                                            
                                                
                                                Button(action: {
                                                    // Add your sign-in action here
                                                    
                                                    
                                                           if selectedImages.count != 0 {
                                                               
                                                               handleLocationAndTaskCreation()
                                                               tasklistviewVM.isDraft = true
                                                               uploadImagesToAPI()
                                                            
                                                               
                                                           }
                                                           else {
                                                               
                                                               handleLocationAndTaskCreation()
                                                               tasklistviewVM.isDraft = true
                                                               tasklistviewVM.CreateGeneralReport{
                                                                   self.presentationMode.wrappedValue.dismiss()
                                                                   
                                                               }
                                                               
                                                           }
                                           

                                                }) {
                                                    HStack {
                                                        Spacer()
                                                        Text("Save as Draft")
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
                                                    
                                                      
//
                                                   
                                                           if selectedImages.count != 0 {
                                                               
                                                               handleLocationAndTaskCreation()
                                                                  tasklistviewVM.isDraft = true
                                                               uploadImagesToAPI()
                                                         
   //
                                                               
                                                           }
                                                           else {
                                                               
                                                               handleLocationAndTaskCreation()
                                                               
                                                                           tasklistviewVM.isDraft = true
                                                                           tasklistviewVM.CreateGeneralReport{
                                                                           self.presentationMode.wrappedValue.dismiss()
                                                                           
                                                                       }
                                                           }
                                                }
                                                
                                                Button(action: {
                           
                                                    if selectedImages.count != 0 {
                                                        
                                                    uploadImagesToAPI()
                                                     handleLocationAndTaskCreation()
                                                        
                                                        tasklistviewVM.isDraft = false
                                                            tasklistviewVM.ismailsent = true
                                                        
                                                    }
                                                    else {
                                                        handleLocationAndTaskCreation()

                                                        
                                                        tasklistviewVM.isDraft = false
                                                            tasklistviewVM.ismailsent = true

                                                               tasklistviewVM.CreateGeneralReport{
                                                                self.presentationMode.wrappedValue.dismiss()
                                                                
                                                            }
                                                    }
                                                           
                                                    
                                                }) {
                                                    HStack {
                                                        Image("Image 1")
                                                        
                                                        Text("Send to supervisor via email")
                                                            .foregroundColor(.accentColor)
                                                            .font(ConstantClass.AppFonts.medium)
                                                            .multilineTextAlignment(.center)
                                                            .lineLimit(1)
                                                        //  Spacer()
                                                    }
                                                }
                                                .frame(width: Responsiveframes.widthPercentageToDP(90),height: Responsiveframes.heightPercentageToDP(6))
                                                .multilineTextAlignment(.center)
                                                .onTapGesture {
//
                                                    
                                                    if selectedImages.count != 0 {
                                                        
                                                        uploadImagesToAPI()
                                                     handleLocationAndTaskCreation()
                                                        
                                                        tasklistviewVM.isDraft = false
                                                            tasklistviewVM.ismailsent = true
                                                        
                                                    }
                                                    else {
                                                        handleLocationAndTaskCreation()

                                                        
                                                        tasklistviewVM.isDraft = false
                                                            tasklistviewVM.ismailsent = true

                                                               tasklistviewVM.CreateGeneralReport{
                                                                self.presentationMode.wrappedValue.dismiss()
                                                                
                                                            }
                                                    }
                                       

                                                }
                                                
                                                
                                                
                                                
                                               
                                                
                                            }
                                        }
                                    }
                                    
                                }
                              //  .padding()
                              //  .frame(width: Responsiveframes.widthPercentageToDP(75))
                                
                                
                            }
                            
                            .frame(width: Responsiveframes.widthPercentageToDP(90))
                            .padding()
                        
                            NavigationLink(destination: Tapp_Me.WorkerGeneralReport(), isActive: $WorkerGeneralReport) { EmptyView() }
                            
                            NavigationLink(destination: Tapp_Me.WorkkerCheckin(), isActive: $WorkkerCheckin) { EmptyView() }
                            
                        }
                    }
                    
//                    .background(
//                        RoundedRectangle(cornerRadius: 6)
//                            .fill(Color.white)
//                            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
//                    )
//                    
                    .frame(width: geometry.size.width) // Adjusted frame width based on geometry

                    .disabled(backgroundDisabled)
                   
                }
                
                if isShowingPopup == true
                         {
                             
                             StandardPopUp(
                                 isShowingPopup: $isShowingPopup,
                                 title: "Are you sure, you want to submit the General report?",
                                 yesButtonLabel: "Yes",
                                 noButtonLabel: "No",
                                 onYesTapped: {
                                 
                                     self.backgroundDisabled = false

                                     withAnimation{
                                   
                                         if selectedImages.count != 0 {
                                             
                                             uploadImagesToAPI()
                                             handleLocationAndTaskCreation()
                                             tasklistviewVM.isDraft = false
                                             
                                         }
                                         else {
                                             handleLocationAndTaskCreation()
                                               tasklistviewVM.isDraft = false
                                                  tasklistviewVM.CreateGeneralReport{
                                                   self.presentationMode.wrappedValue.dismiss()
                                               }
                                         }
                                     
                                     }
                                 },
                                 onNoTapped: {
                                     // Custom action for No button
                                     self.backgroundDisabled = false

                                     withAnimation{
                                         isShowingPopup = false
                                     }
                                 }
                             )
                             .onAppear(){
                                 self.backgroundDisabled = true
                            }
                    }
            }
            
        
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            
        }
        .onAppear(){
            
            tasklistviewVM.eTaskReportStatus = CompanyName ?? "Before"
            tasklistviewVM.isDraft = false
            handleLocationAndTaskCreation()

        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
  
    }
    
    
    
    func handleLocationAndTaskCreation() {
        if let location = locationManager.location {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if let error = error {
                    print("Reverse geocoding failed with error: \(error.localizedDescription)")
                    return
                }
                
                guard let placemark = placemarks?.first else {
                    print("No placemarks found")
                    return
                }
                
                // Extract address components
                let thoroughfare = placemark.name ?? ""
                let locality = placemark.locality ?? ""
                let administrativeArea = placemark.administrativeArea ?? ""
                let postalCode = placemark.postalCode ?? ""
                let country = placemark.country ?? ""
                
                print("Address: \(thoroughfare), \(locality), \(administrativeArea), \(postalCode), \(country)")
                
                let addressString = "\(thoroughfare) \(locality) \(administrativeArea) \(postalCode) \(country)"
                print("Combined Address: \(addressString)")
                
                let placesData = "\(thoroughfare), \(locality), \(administrativeArea), \(postalCode), \(country)"
                tasklistviewVM.place = placesData
                
                tasklistviewVM.lat = location.coordinate.latitude
                tasklistviewVM.long = location.coordinate.longitude
                
                print(tasklistviewVM.place)
            }
        }
        
        
    }
    
    func uploadImagesToAPI() {
        // Call your API function with the array of selected images
        uploadImage(images: selectedImages)
    }
    
    func uploadImage(images: [UIImage]) {
        
        SSLoader.shared.startloader("Loading...", config: .defaultSettings)//http://eventsapp.biz/

        let baseURL = URL(string: "http://62.171.153.83:8080/tappme-api-staging/upload/report/doc")!
        let headers: HTTPHeaders = ["Content-type": "multipart/form-data"]
        Alamofire.upload(multipartFormData: { (formData) in

            // Iterate over each image and append it to the formData
            for (index, image) in images.enumerated() {
                guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                    continue // Skip to the next image if unable to get JPEG data
                }
                formData.append(imageData, withName: "files", fileName: "image\(index).jpg", mimeType: "image/jpeg")
            }
        }, to: baseURL, method: .post, headers: headers) { (result) in
            switch result {
                
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    SSLoader.shared.stopLoader()

                    if let json = response.value as? [String: Any] {
                        if let status = json["status"] as? Bool, status {
                            
                            if let message = json["message"] as? String {
                                print("Message: \(message)")
                            }
                            
                            dataArr = []
                            
                            
                            if let dataArray = json["data"] as? [[String: String]] {
                                let filenames = dataArray.map { $0["filename"] ?? "" }
                                // Do something with the filenames array, such as storing it or using it further
                                print("Uploaded filenames: \(filenames)")
                                
                                // Append dictionaries to dataArr
                                var dic  = NSDictionary()
                                
                                for filename in filenames {
                                    let dic: [String: String] = [
                                        "filename": filename
                                    ]
                                    self.showview = true
                                    
                                    self.dataArr.add(dic)
                                }
                                //     self.uploaddone = true
                                
                                tasklistviewVM.dataArr = dataArr
                                
                                
                                tasklistviewVM.CreateGeneralReport{
                                    self.presentationMode.wrappedValue.dismiss()
                                    
                                }
                            }
                        }
                        
                        
                        else {
                            if let errorMessage = json["errorMessage"] as? String {
                                print("Error: \(errorMessage)")
                            }
                        }
                    }
                }
                case .failure(let error):
                SSLoader.shared.stopLoader()

                print("Error in upload: \(error.localizedDescription)")
                // Handle error here
            }
        }
    }

    
}

struct WorkPicker: View {
    
    @Binding var value: String?
    @State var value1 = ""
    @Binding var showCompanyPicekr: Bool
    
    
    let companyList = ["After Work", "Before Work", "During Work"]
    var placeholder = "After Work"
    
    
    var body: some View {
        
        HStack{
            Menu {
                ForEach(companyList, id: \.self) { company in
                    Button(action: {
                        self.value1 = company
                        self.value = company
                        self.showCompanyPicekr.toggle()
                    }) {
                        Text(company)
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                    }
                }
            } label: {
                VStack(spacing: 5) {
                    HStack {
                        Text(value1.isEmpty ? placeholder : value1)
                            .foregroundColor(value1.isEmpty ? .gray : .black)
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                            .padding(.leading, 5)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(Color.gray)
                    .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                    }
                    
                }
            }
        }
        .frame(width: Responsiveframes.widthPercentageToDP(75), height: Responsiveframes.heightPercentageToDP(5))
        
        .background(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
    
}



public struct ImagePickerView: UIViewControllerRepresentable {
    
    private let sourceType: UIImagePickerController.SourceType
    private let onImagePicked: (UIImage) -> Void
    @Environment(\.presentationMode) private var presentationMode
    
    public init(sourceType: UIImagePickerController.SourceType, onImagePicked: @escaping (UIImage) -> Void) {
        self.sourceType = sourceType
        self.onImagePicked = onImagePicked
    }
    
    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = self.sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(
            onDismiss: { self.presentationMode.wrappedValue.dismiss() },
            onImagePicked: self.onImagePicked
        )
    }
    
    final public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        private let onDismiss: () -> Void
        private let onImagePicked: (UIImage) -> Void
        
        init(onDismiss: @escaping () -> Void, onImagePicked: @escaping (UIImage) -> Void) {
            self.onDismiss = onDismiss
            self.onImagePicked = onImagePicked
        }
        
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                self.onImagePicked(image)
            }
            self.onDismiss()
        }
        
        public func imagePickerControllerDidCancel(_: UIImagePickerController) {
            self.onDismiss()
        }
    }
}






#Preview {
    WorkerGeneralReport()
}
