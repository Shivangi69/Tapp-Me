//
//  GeneralDraftReport.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 25/04/24.
//




import SwiftUI
import PhotosUI
import CoreLocation
import GoogleMaps
import Combine
import Alamofire
import SSSwiftUILoader


struct GeneralDraftReport: View {
 

    @State   var dataArr = NSMutableArray()

    @State   var showview = false
    @State private var backgroundDisabled = false
    @StateObject var tasklistviewVM = TaskListViewVM()

    @State private var loadingImages: [String: Bool] = [:]  // Tracks loading state of images

    @State private var selectedImageapi: [ImageData] = []

    
    
    @State var showcompanypicker: Bool = false
    @State var CompanyName : String? = nil
    
    @State var image = UIImage()
    @State var cmrstr = String()
    @State var showImagePicker: Bool = false
    let radius: CGFloat = 65
    @State private var showingActionSheet = false
    var offset: CGFloat {
        sqrt(radius * radius / 2)
    }
    @StateObject var obs = WorkerGeneralReportVM()


    @State private var isShowingPopup = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var reportidmodeldata: WorkerGenralReportModel
    @State  var textStyle = UIFont.TextStyle.body
    
    
//    @State var dataArr = NSMutableArray()
 //   @State var dataArr: [[String: String]] = []

    @State private var selectedImages: [UIImage] = []
    @State private var mainselectedImages: [UIImage] = []

  

  //  @State var imagesInfo: [String: String] = [:]

    var dic  = NSDictionary()

    
    @ObservedObject var locationManager = LocationManager()
    
   // @StateObject var tasklistviewVM = TaskListViewVM()
    
    
    @State private var description: String = ""
    @State private var showlocation = ""

    
    
    @State private var mainview = false
    var body: some View {
        
        NavigationView{
            ZStack {
                GeometryReader { geometry in
                    VStack{
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
                                }.onAppear(){
                                    tasklistviewVM.Reportname = reportidmodeldata.name
                                }
                                
                                
                                
                                
                                VStack{
                                    
                                    
                                    
                           
                                    
                                    VStack( alignment: .leading, spacing:10 ){
                                        
                                        
                                        VStack{
                                            
                                            let datestrng = DateConverter.convertDatetotime(dateString: reportidmodeldata.createdAt)
                                            
                                            Text("Saved to drafts: at " + datestrng)
                                                .foregroundColor(.white)
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                                .frame(width : Responsiveframes.widthPercentageToDP(50), height: Responsiveframes.heightPercentageToDP(4))
                                                .background(Color.accentColor)
                                                .cornerRadius(6)
                                            
                                        }
                                        
                                        VStack{
                                            
                                            
                                            HStack(alignment: .center, spacing:10.0) {
                                                Image("Vector")
                                                //  .resizable()
                                                    .frame(width: Responsiveframes.widthPercentageToDP(4), height: Responsiveframes.widthPercentageToDP(3))
                                                
                                                
                                                Text(showlocation)
                                                    .foregroundColor(.black)
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                
                                                Spacer()
                                            }
                                            //  .padding()
                                            
                                        }  .frame(width: Responsiveframes.widthPercentageToDP(80))
                                        
                                    }
                                    .frame(width: Responsiveframes.widthPercentageToDP(80))
                                    
                                }
                                .padding()
                                .frame(width: Responsiveframes.widthPercentageToDP(90),height: Responsiveframes.heightPercentageToDP(15))
                                .shadow(color: .black.opacity(0.07), radius: 9, x: 0, y: 4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .inset(by: 0.5)
                                        .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                )
                                
                                
                                VStack(alignment: .leading){
                                    
                                    VStack(alignment: .leading){
                                        
                                        Text("Description")
                                            .font(ConstantClass.AppFonts.light)
                                            .foregroundColor(.black)
                                            .padding(.leading, 5.0)
                                        
                                        TextView(text: $tasklistviewVM.descriptionText, textStyle: $textStyle)
                                            .padding(.leading, 5.0)
                                            .multilineTextAlignment(.leading)
                                            .font(ConstantClass.AppFonts.light)
                                            .frame(width: ConstantClass.Emptytextfield.textdescriptionwidth, height: ConstantClass.Emptytextfield.textdescriptionheight)
                                            .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
                                            .overlay(
                                                ConstantClass.Emptytextfield.getOverlay()
                                            )
                                        
                                        
//                                            .onAppear(){
//                                                tasklistviewVM.descriptionText = reportidmodeldata.description
//                                            }
                                        
                                        
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
                                    Text("Report Submitted")
                                        .font(ConstantClass.AppFonts.light)
                                        .foregroundColor(.black)
                                        .padding(.leading, 5.0)
                                    
                                    ReportlistPickerViewWithsavedValue(value: $CompanyName, value1 : reportidmodeldata.etaskReportStatus,
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
                                .onAppear(){
                                    handleLocationAndTaskCreation()
                                    CompanyName = reportidmodeldata.etaskReportStatus
                                    tasklistviewVM.eTaskReportStatus = CompanyName ?? "Before"

                                }
                                VStack(alignment: .leading, spacing: 20){
                                    
                                    Text("Attached images")
                                        .font(ConstantClass.AppFonts.light)
                                        .foregroundColor(.black)
                                        .padding(.leading, 5.0)
                                    
                                    Button(action: {
                                            // Trigger the action to open gallery or camera
                                            self.showingActionSheet = true
                                        }) {
                                            HStack {
                                                Image("Upload Minimalistic") // Ensure this image is correctly named in your assets
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: ConstantClass.mediumlogosize.logoWidth, height: ConstantClass.mediumlogosize.logoHeight)
                                                    .multilineTextAlignment(.center)
                                                Spacer()
                                            }
                                            .frame(width: ConstantClass.mediumlogosize.logoWidth, height: ConstantClass.mediumlogosize.logoHeight)
                                            .clipShape(Rectangle())
                                            .overlay(Rectangle().stroke(Color.white, lineWidth: 5)) // Border
                                            .padding(5)
                                            .border(Color.gray)
                                        }
                                    .overlay(
                                        Button(action: {
                                            self.showingActionSheet = true
                                        }) {
                                            Image("icon")
                                                .clipShape(Circle())
                                                .background(
                                                    Circle()
                                                        .stroke(Color.white, lineWidth: 2)
                                                )
                                        }
                                            .offset(x: offset, y: -offset)
                                    )
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
                                    
//                                    .onChange(of: selectedImages) { _ in
//                                        if !selectedImages.isEmpty {
//                                            uploadImagesToAPI()
//                                            
//                                        }
//                                    }
                                    
                                    VStack{
                                        LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 10) {
                                            ForEach(selectedImages.indices, id: \.self) { index in
                                                ZStack {
                                                    // Image
                                                    VStack{
                                                        Image(uiImage: selectedImages[index])
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: ConstantClass.mediumlogosize.logoWidth, height: ConstantClass.mediumlogosize.logoHeight)
                                                            .clipShape(Rectangle())
                                                            .overlay(Rectangle().stroke(Color.white, lineWidth: 5)) // Border
                                                            .padding(5)
                                                            .border(Color.gray)
                                                    }
                                                    .frame(width: ConstantClass.mediumlogosize.logoWidth, height: ConstantClass.mediumlogosize.logoHeight)
                                                    .clipShape(Rectangle())
                                                    .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
                                                    
                                                    // Padding from the border
                                                    
                                                    // Delete Button
                                                    Button(action: {
                                                        // Remove the selected image when delete button is tapped
                                                        selectedImages.remove(at: index)
                                                        
                                                    }) {
                                                        Image("Group 1000001084")
                                                            .resizable()
                                                            .frame(width: Responsiveframes.widthPercentageToDP(5), height: Responsiveframes.heightPercentageToDP(5)) // Adjust the size as needed
                                                            .foregroundColor(Color.red)
                                                            .background(Color.white)
                                                            .clipShape(Circle())
                                                    }
                                                    .offset(x: 35, y: -35) // Adjust the position as needed

                                                    .buttonStyle(PlainButtonStyle())
                                                }
                                            }
                                           
                                        }
                                          
                                            ScrollView {
                                          
                                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) {
                                                    ForEach(obs.workerReportDocResponses, id: \.self) { imageUrlString in
                                                        
                                                        let imageRectangle2Path = imageUrlString.documentUrl
                                                        let imageRectanglefile = imageUrlString.fileName

                                                        ZStack{
                                                            AsyncImage(
                                                                url: URL(string: imageRectangle2Path)!,
                                                                placeholder: {
                                                                    Image("material-symbols_image")
                                                                        .resizable()
                                                                        .aspectRatio(contentMode: .fit)
                                                                        .frame(width: ConstantClass.mediumlogosize.logoWidth, height: ConstantClass.mediumlogosize.logoHeight)
                                                                        .clipShape(Rectangle())
                                                                        .overlay(Rectangle().stroke(Color.white, lineWidth: 5))
                                                                        .padding(5)
                                                                        .border(Color.gray)
                                                                },
                                                                image: { Image(uiImage: $0).resizable() }
                                                            )
                                                            .padding(5)
                                                            .frame(width: ConstantClass.mediumlogosize.logoWidth, height: ConstantClass.mediumlogosize.logoHeight)
                                                            .clipShape(Rectangle())
                                                            .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
                                                            .onAppear(){
                                                                if let image = UIImage(contentsOfFile: imageRectanglefile) {
                                                                    self.selectedImages.append(image)
                                                                    print("Selected images:", selectedImages)
                                                                }
                                                            }
//                                                            .onChange(of: selectedImages) { _ in
//                                                                uploadImagesToAPI()
//                                                            }

                                                            Button(action: {
                                                                obs.workReportDocID = imageUrlString.generalReportDocId
                                                                
                                                                obs.deletedata()
                                                                
                                                                if let index = obs.workerReportDocResponses.firstIndex(where: { $0.generalReportDocId == imageUrlString.generalReportDocId }) {
                                                                      obs.workerReportDocResponses.remove(at: index)
                                                                  }
                                                                
                                                                
                                                            }) {
                                                                Image("Group 1000001084")
                                                                    .resizable()
                                                                    .frame(width: Responsiveframes.widthPercentageToDP(5), height: Responsiveframes.heightPercentageToDP(5))
                                                                    .foregroundColor(.red)
                                                                    .background(Color.white)
                                                                    .clipShape(Circle())
                                                            }
                                                            .offset(x: 35, y: -35)
                                                            .buttonStyle(PlainButtonStyle())
                                                        }

                                                     
                                                    }
                                                    
                                                }
                                             
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
                                        
                                        uploadImagesToAPI()
                                        handleLocationAndTaskCreation()
                                        tasklistviewVM.isDraft = true
                                        
                                        tasklistviewVM.taskid =  reportidmodeldata.reportId
                                       
                                        

                                    }
                                    else {
                                        handleLocationAndTaskCreation()
                                        tasklistviewVM.isDraft = true
                                        tasklistviewVM.taskid =  reportidmodeldata.reportId
                                        tasklistviewVM.UpdateGenralReport{
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
 
                                    
                                    
                                    tasklistviewVM.isDraft = true
                                    tasklistviewVM.taskid =  reportidmodeldata.reportId
                                    tasklistviewVM.UpdateGenralReport{
                                        self.presentationMode.wrappedValue.dismiss()
                                        
                                    }
                                    
                                    
                                    
                                }
                                
                                Button(action: {
                                    // Add your sign-in action here
                                    
                                    if selectedImages.count != 0 {
                                        
                                        uploadImagesToAPI()
                                        handleLocationAndTaskCreation()
                                        tasklistviewVM.isDraft = false
                                        tasklistviewVM.ismailsent = true
                                        tasklistviewVM.taskid =  reportidmodeldata.reportId

                                    }
                                    else {
                                        handleLocationAndTaskCreation()
                                        tasklistviewVM.isDraft = false
                                        tasklistviewVM.ismailsent = true
                                        tasklistviewVM.taskid =  reportidmodeldata.reportId
                                        tasklistviewVM.UpdateGenralReport{
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
                                        tasklistviewVM.UpdateGenralReport{
                                         self.presentationMode.wrappedValue.dismiss()
                                         
                                     }
                                    }
                                }
                                
                          
                                
                            }
                            
                        }
                        
                        .frame(width: Responsiveframes.widthPercentageToDP(90))
                        
                    }
                    .frame(width: geometry.size.width) // Adjusted frame width based on geometry
                    
                }
                
                if isShowingPopup == true{
                
                    
                    StandardPopUp(
                        isShowingPopup: $isShowingPopup,
                        title: "Are you sure, you want to submit the report?",
                        yesButtonLabel: "Yes",
                        noButtonLabel: "No",
                        onYesTapped: {
                            
                            self.backgroundDisabled = false
                            
                            withAnimation{

                                
                                
                                      if selectedImages.count != 0 {
                                          
                                          uploadImagesToAPI()
                                          handleLocationAndTaskCreation()
                                          tasklistviewVM.taskid =  reportidmodeldata.reportId
                                          tasklistviewVM.isDraft = false
                                          
                                      }
                                      else {
                                          handleLocationAndTaskCreation()
                                          tasklistviewVM.isDraft = false
                                          tasklistviewVM.taskid =  reportidmodeldata.reportId
                                          tasklistviewVM.UpdateGenralReport{
                                              self.presentationMode.wrappedValue.dismiss()
                                              
                                          }
                                      }
//                                tasklistviewVM.taskid =  reportidmodeldata.reportId
//                                tasklistviewVM.UpdateGenralReport{
//                             
//                                    self.presentationMode.wrappedValue.dismiss()
//                                    
//                                }
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
            
            .onAppear(){
                
     
                
                
                handleLocationAndTaskCreation()
                
                showlocation = reportidmodeldata.location
                tasklistviewVM.descriptionText = reportidmodeldata.description

                
                obs.reportid = reportidmodeldata.reportId
                obs.Getreportbyid()
                
                

            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
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
                          
                                tasklistviewVM.UpdateGenralReport{
                             
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
//    func uploadImagesToAPI() {
//        // Call your API function with the array of selected images
//        tasklistviewVM.uploadImage(images: selectedImages)
//    }
//    
}
    


//struct ImageData {
//    var image: UIImage
//    var type: String
//}



//struct ReportlistPickerView1: View {
//    
//    @Binding var value: String?
//    @State var value1 = ""
//    @Binding var showCompanyPicker: Bool
//    
//    let typetasklist = ["After", "During" , "Before" ]
//    var placeholder = "Before"
//    var onChange: (() -> Void)? // Callback function to notify parent
//
//    var body: some View {
//        
//        HStack {
//            Menu {
//                ForEach(typetasklist, id: \.self) { company in
//                    Button(action: {
//                        self.value1 = company
//                        self.value = company
//                        self.showCompanyPicker.toggle()
//                        onChange?() // Invoke callback
//
//                    }) {
//                        Text(company)
//                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                            .foregroundColor(Color.black) // Set text color to blue
//                    }
//                }
//            } label: {
//                VStack(spacing: 5) {
//                    HStack {
//                        Text(value1.isEmpty ? placeholder : value1)
//                            .foregroundColor(value1.isEmpty ? .black : .black) // Set text color to blue
//                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                           .padding(.leading, 10)
//                           // .lineLimit(1)
//                        Spacer()
//                        Image(systemName: "chevron.down")
//                            .foregroundColor(Color.gray) // Set arrow color to blue
//                       .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
//                       .padding(.trailing, 2)
//
//                    }
//                   // .padding()
//                    
//                }
//            }
//        }
//        .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(5))
//        
//        .background(
//            RoundedRectangle(cornerRadius: 6)
//                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
//        )
//    }
//}
//
//#Preview {
//    WorkerReportDraftDescription(, reportidmodeldata: <#reportidmodel#>)
//}
