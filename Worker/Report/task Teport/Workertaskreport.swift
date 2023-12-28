//
//  Workertaskreport.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 08/01/24.
//

import SwiftUI
import PhotosUI
import CoreLocation
import GoogleMaps
import Combine

import Alamofire
import SSSwiftUILoader

struct Workertaskreport: View {
    @State private var Report: String = ""
    @State private var description: String = ""
    @State  var latitude: Double = 0.0
    @State  var longitude: Double = 0.0
    @State var showcompanypicker: Bool = false
    @State var CompanyName : String? = nil
    
    @State   var dataArr = NSMutableArray()
    @State   var showview = false
    @State var uploadProgress: [Double] = []
    
    @State var image = UIImage(named: "AppIcon")
    @State var cmrstr = String()
    @State var showImagePicker: Bool = false
    let radius: CGFloat = 65
    var offset: CGFloat {
        sqrt(radius * radius / 2)
    }
    @State private var backgroundDisabled = false
    
    @State private var showingActionSheet = false
    @State private var selectedImages: [UIImage] = []
    @ObservedObject var locationManager = LocationManager()
    
    @StateObject var tasklistviewVM = TaskListViewVM()
    
    @State private var mainview = false
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingPopup = false
    
    var TaskDetaildata: tasklistmodel
    
    @State  var currentLocation: CLLocationCoordinate2D?
    @State private var isLoading = false
    
    
    @State  var textStyle = UIFont.TextStyle.body
    
    var body: some View {
        
        NavigationView{
            ZStack {
                GeometryReader { geometry in
                    
                    VStack{
                        VStack{
                            VStack(alignment: .center, spacing: 10){
                                HStack(alignment: .center, spacing:10){
                                    Button(action: {
                                        self.presentationMode.wrappedValue.dismiss()
                                        
                                    })
                                    {
                                        Image("Arrow Left-8")
                                            .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                                        
                                    }
                                    
                                    Text(TaskDetaildata.name)
                                        .fontWeight(.semibold)
                                        .lineLimit(2)
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                                    
                                    Spacer()
                                    
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(90))
                                
                                
                                ScrollView(.vertical , showsIndicators: false){
                                    
                                    
                                    VStack(alignment: .center, spacing: 10){
                                        
                                        VStack(spacing: 10){
                                            VStack{
                                                VStack(alignment: .leading){
                                                    Text("Description")
                                                        .font(ConstantClass.AppFonts.light)
                                                        .foregroundColor(.black)
                                                        .padding(.leading, 5.0)
                                                    //         TextField(text: $fullname)
                                                    TextView(text: $tasklistviewVM.descriptionText, textStyle: $textStyle)
                                                        .padding(.leading, 5.0)
                                                        .multilineTextAlignment(.leading)
                                                        .font(ConstantClass.AppFonts.light)
                                                        .frame(width:ConstantClass.Emptytextfield.textdescriptionwidth, height: ConstantClass.Emptytextfield.textdescriptionheight)
                                                        .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
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
                                                        
                                                        tasklistviewVM.eTaskReportStatus1 = "After"
                                                        //  tasklistviewVM.Getalltaskreport()
                                                        
                                                    } else if CompanyName == "Before" {
                                                        tasklistviewVM.eTaskReportStatus1 = "Before"
                                                        
                                                    }
                                                    
                                                    else if CompanyName == "During" {
                                                        tasklistviewVM.eTaskReportStatus1 = "During"
                                                    }
                                                    else  if CompanyName == "" {
                                                        tasklistviewVM.eTaskReportStatus1 = "Before"
                                                        
                                                    }
                                               
                                                })
                                                 
                                                
                                                
                                            }
                                            .onTapGesture {
                                                hideKeyboard()
                                            }
                                            
                                            VStack(alignment: .leading){
                                                Text("Attach images")
                                                    .font(ConstantClass.AppFonts.light)
                                                    .foregroundColor(.black)
                                                    .padding(.leading, 5.0)
                                                //         TextField(text: $fullname)
                                                
                                                
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
                                                        .padding(.leading, 5.0)
                                                        .frame(width: ConstantClass.Emptytextfield.width, height: ConstantClass.Emptytextfield.height1)
                                                        .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
                                                        .overlay(ConstantClass.Emptytextfield.getOverlay())
                                                        .onTapGesture {
                                                            self.showingActionSheet = true
                                                        }
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
                                                    }
                                                    .onTapGesture {
                                                        // Open gallery or camera here
                                                        self.showingActionSheet = true
                                                    }

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
                                                                    
                                                                    
                                                                    //                                                                    deletedata
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
                                                 
                                                        if selectedImages.count != 0 {
                                                            
                                                            uploadImagesToAPI()
                                                            handleLocationAndTaskCreation()
                                                            tasklistviewVM.isDraft = true
                                                            tasklistviewVM.taskid =  TaskDetaildata.taskID
                                                         
                                                        }
                                                        else {
                                                            
                                                            handleLocationAndTaskCreation()
                                                            tasklistviewVM.isDraft = true
                                                            tasklistviewVM.taskid =  TaskDetaildata.taskID
                                                            tasklistviewVM.CreateTaskReport{
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
                                                  
                                                        
                                                        if selectedImages.count != 0 {
                                                            uploadImagesToAPI()
                                                            handleLocationAndTaskCreation()
                                                            tasklistviewVM.isDraft = true
                                                            tasklistviewVM.taskid =  TaskDetaildata.taskID
                                                         
                                                            
                                                        }
                                                        else {
                                                            
                                                            handleLocationAndTaskCreation()
                                                            tasklistviewVM.isDraft = true
                                                            tasklistviewVM.taskid =  TaskDetaildata.taskID
                                                            tasklistviewVM.CreateTaskReport{
                                                                self.presentationMode.wrappedValue.dismiss()
                                                                
                                                            }
                                                            
                                                        }
                                                         
                                                    }
                                         
                                                    
                                                    Button(action: {
                                                    
                                                        
                                                        if selectedImages.count != 0 {
                                                            uploadImagesToAPI()
                                                            
                                                            handleLocationAndTaskCreation()
                                                            
                                                            tasklistviewVM.taskid =  TaskDetaildata.taskID
                                                            tasklistviewVM.isDraft = false
                                                            tasklistviewVM.ismailsent = true
                                                        }
                                                        
                                                        else {
                                                            handleLocationAndTaskCreation()
                                                            
                                                            tasklistviewVM.taskid =  TaskDetaildata.taskID
                                                            tasklistviewVM.isDraft = false
                                                            tasklistviewVM.ismailsent = true
                                                            tasklistviewVM.CreateTaskReport{
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
                                                        }
                                                    }
                                                    .frame(width: Responsiveframes.widthPercentageToDP(90),height: Responsiveframes.heightPercentageToDP(6))
                                                    .multilineTextAlignment(.center)
                                                    .onTapGesture {
                                                        if selectedImages.count != 0 {
                                                            uploadImagesToAPI()
                                                            
                                                            handleLocationAndTaskCreation()
                                                            
                                             
                                                            tasklistviewVM.taskid =  TaskDetaildata.taskID
                                                            tasklistviewVM.isDraft = false
                                                            tasklistviewVM.ismailsent = true
                                                        }
                                                        
                                                        else {
                                                            handleLocationAndTaskCreation()
                                                            
                                                            tasklistviewVM.taskid =  TaskDetaildata.taskID
                                                            tasklistviewVM.isDraft = false
                                                            tasklistviewVM.ismailsent = true
                                                            tasklistviewVM.CreateTaskReport{
                                                                self.presentationMode.wrappedValue.dismiss()
                                                            }
                                                            
                                                        }
                                                        
                                                    }
                                                }
                                            }
                                            
                                            .frame(width: Responsiveframes.widthPercentageToDP(90))
                                        }
                                        
                                    }
                                    .frame(width: Responsiveframes.widthPercentageToDP(90))
                                }
                                
                                Spacer()
                            }
                            
                            
                        }
                        .frame(width: Responsiveframes.widthPercentageToDP(90))
                    }
                    
                    .disabled(backgroundDisabled)
                    
                    .frame(width: geometry.size.width)  // Adjusted frame width based on geometry
                    
                    
                }
                
                if isShowingPopup == true
                {
                    
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
                                    tasklistviewVM.isDraft = false
                                      tasklistviewVM.taskid =  TaskDetaildata.taskID
                                    
                                }
                                
                                
                                else {
                                    handleLocationAndTaskCreation()
                                    tasklistviewVM.isDraft = false
                                    tasklistviewVM.taskid =  TaskDetaildata.taskID
                                    tasklistviewVM.CreateTaskReport{
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
            
            .onAppear(){
                 
                
                
                if selectedImages.count != 0 {
                    tasklistviewVM.eTaskReportStatus = CompanyName ?? "Before"
                }
                else
                {
                    tasklistviewVM.eTaskReportStatus = CompanyName ?? "Before"
                }
                
                
                tasklistviewVM.isDraft = false
                handleLocationAndTaskCreation()
          
            }
            
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
    
    func uploadImagesToAPI() {
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
                                tasklistviewVM.CreateTaskReport{
                                    self.presentationMode.wrappedValue.dismiss()
                                    
                                }
                                
                                
                            }
     
                            
                            
                            

                        } else {
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
}





class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var location: CLLocation?

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.location = location
        }
    }
}


public struct ImagePickerView1: UIViewControllerRepresentable {
    private let sourceType: UIImagePickerController.SourceType
    private let onImagesPicked: ([UIImage]) -> Void
    @Environment(\.presentationMode) private var presentationMode
    
    public init(sourceType: UIImagePickerController.SourceType, onImagesPicked: @escaping ([UIImage]) -> Void) {
        self.sourceType = sourceType
        self.onImagesPicked = onImagesPicked
    }
    
    public func makeUIViewController(context: Context) -> UIViewController {
        if sourceType == .camera {
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = .camera
            cameraPicker.delegate = context.coordinator
            return cameraPicker
        } else {
            var configuration = PHPickerConfiguration()
            configuration.filter = .images
            configuration.selectionLimit = 0  // 0 means unlimited selection
            let photoPicker = PHPickerViewController(configuration: configuration)
            photoPicker.delegate = context.coordinator
            return photoPicker
        }
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(
            onDismiss: { self.presentationMode.wrappedValue.dismiss() },
            onImagesPicked: self.onImagesPicked
        )
    }
    
    final public class Coordinator: NSObject, PHPickerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        private let onDismiss: () -> Void
        private let onImagesPicked: ([UIImage]) -> Void
        
        init(onDismiss: @escaping () -> Void, onImagesPicked: @escaping ([UIImage]) -> Void) {
            self.onDismiss = onDismiss
            self.onImagesPicked = onImagesPicked
        }
        
        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            var selectedImages: [UIImage] = []
            let group = DispatchGroup()
            
            for result in results {
                group.enter()
                result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                    defer { group.leave() }
                    if let image = object as? UIImage {
                        selectedImages.append(image)
                    }
                }
            }
            
            group.notify(queue: .main) {
                self.onImagesPicked(selectedImages)
                self.onDismiss()
            }
        }
        
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                self.onImagesPicked([image]) // Sending as an array to maintain consistency with the PHPicker functionality
            }
            self.onDismiss()
        }
        
        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.onDismiss()
        }
    }
}
