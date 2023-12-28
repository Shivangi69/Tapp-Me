//
//  Profile.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 09/01/24.
//

import SwiftUI

struct Profile: View {
    @State private var PersonalInformation = false
    @State private var Employmentdetails = false
    @State private var LanguageSkills = false
    @State private var Certificates = false
    @State private var Bankaccountdetails = false
    @State private var workforce = false

    @State private var settingshow = false
    @State private var Workertimesheetshow = false
    
    @State private var completedtask = false

    @Environment(\.presentationMode) var presentationMode

    @State  var certificateURL = String()

//    @State var image = UIImage(UserDefaults.standard.string(forKey: "imageUrl"))

    
    
//    @State private var image: UIImage? = {
//          if let imageUrlString = UserDefaults.standard.string(forKey: "imageurlw"),
//             let imageUrl = URL(string: imageUrlString),
//             let imageData = try? Data(contentsOf: imageUrl) {
//              return UIImage(data: imageData)
//          }
//          return nil
//      }()
//    
//    
    
    @State private var image: UIImage? = {
        if let imageUrlString = UserDefaults.standard.string(forKey: "imageurlw"),
           let imageUrl = URL(string: imageUrlString),
           let imageData = try? Data(contentsOf: imageUrl) {
            return UIImage(data: imageData)
        }
        return nil
    }()

    @State var logoutAlertPresented = false
//     @Environment(\.presentationMode) var presentationMode
    
    @StateObject var WorkerCheckvm = WorkerCheckinVM()
    
    @State private var Logoutshow = false
    @StateObject var profilemodel = ProfileVM()
    
// @State public var imageRectangle2Path = UserDefaults.standard.string(forKey: "imageUrl")
    @StateObject var statuscheck = CompanylistbyemailVMgoogle()
    @StateObject var Profileimageupload = TaskListViewVM()
    @State private var showingActionSheet = false
    @State var showImagePicker: Bool = false

    @State var cmrstr = String()
    let radius: CGFloat = 65
    var offset: CGFloat {
        sqrt(radius * radius / 2)
    }
    @State private var isDownloading = false

    
    var body: some View {
        
        NavigationView{
            ZStack {
                GeometryReader { geometry in
                    
                    VStack{
                        
                        ScrollView(.vertical , showsIndicators: false){
                            VStack(spacing:30){
                                HStack{

                                    Button(action: {

                                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RemoveProfileView"), object: self)
                      
                                        
                                    })
                                    {
                                        
                                        if  statuscheck.homemodel?.isWorkerCheckedIn  == false {
                                            Image("Arrow Left-8")
                                                .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                                        }
                                        
                                    }
                                    
                                    Text("My Profile")
                                        .fontWeight(.semibold)
                                        .lineLimit(1)
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                                        .padding()
                                    Spacer()
                                }
                                .padding()
                                .frame(width: Responsiveframes.widthPercentageToDP(90))
                                
                                

                                
                                .frame(width: Responsiveframes.widthPercentageToDP(90))
                                
                                VStack(spacing:5){
//                                    AsyncImage(
//                                        url: NSURL(string: imageRectangle2Path ?? "")! as URL,
//                                        placeholder: {
//                                            Image("profileimg")
//                                                .resizable()
//                                                .aspectRatio(contentMode: .fit)
//                                        },
//                                        image: { Image(uiImage: $0).resizable() }
//                                    )
//                                    .frame(width: ConstantClass.mediumlogosize.logoWidth, height: ConstantClass.mediumlogosize.logoHeight)
//                                    .cornerRadius(10)
//                                   // .padding()
//                                    
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 10)
//                                            .inset(by: 0.5)
//                                            .stroke(Color.black.opacity(0.15), lineWidth: 1)
//                                    )
////                                    
//                                    
                    
//                                    VStack(spacing: 5.0){
//                                                                                
//                                        Image(uiImage: image!)
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fill)
//                                            .frame(width: ConstantClass.mediumlogosize.logoWidth, height: ConstantClass.mediumlogosize.logoHeight)
//                                            .cornerRadius(10)
//                                           // .padding()
//                                            
//                                            .overlay(
//                                                RoundedRectangle(cornerRadius: 10)
//                                                    .inset(by: 0.5)
//                                                    .stroke(Color.black.opacity(0.15), lineWidth: 1)
//                                            )
//                                            .overlay(
//                                                Button(action: {
//                                                    self.showingActionSheet = true
//                                                    
//                                                }) {
//                                                    
//                                                    Image("Image")
//                                                    // .foregroundColor(Color("purplecolor"))
//                                                    //       .padding(8)
//                                                    //    .background(Color.black)
//                                                        .clipShape(Circle())
//                                                        .background(
//                                                            Circle()
//                                                                .stroke(Color.white, lineWidth: 2)
//                                                            
//                                                        )
////                                                        .frame(width: 1, height: 1)
//
//                                                }.offset(x: offset, y: -offset)
//                                            )
//                                        
//                                            .actionSheet(isPresented: $showingActionSheet) {
//                                                ActionSheet(title: Text("Choose"), message: Text(""), buttons: [
//                                                    .default(Text("Camera")) {
//                                                        self.showImagePicker .toggle()
//                                                        cmrstr = "Camera"  },
//                                                    .default(Text("Gallery")) {
//                                                        self.showImagePicker.toggle()
//                                                        cmrstr = "Gallery" },
//                                                    
//                                                        .cancel()
//                                                ])
//                                            }
//                                            .sheet(isPresented: $showImagePicker) {
//                                                
//                                                if (cmrstr == "Camera"){
//                                                    ImagePickerView(sourceType: .camera) { image in
//                                                        self.image = image
//                                                        Profileimageupload.uploaadProfileImage(images: image)
//
//                                                    }
//                                                }
//                                                else  if (cmrstr == "Gallery"){
//                                                    ImagePickerView(sourceType: .photoLibrary) { image in
//                                                        self.image = image
//                                                        Profileimageupload.uploaadProfileImage(images: image)
//
//                                                    }
//                                                }
//                                            }
//                                            
//                                        
//                                    }
                                    
                                    VStack(spacing: 5.0){
                                        if let image = image {
                                            Image(uiImage: image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: ConstantClass.mediumlogosize.logoWidth, height: ConstantClass.mediumlogosize.logoHeight)
                                                .cornerRadius(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .inset(by: 0.5)
                                                        .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                                )
                                                .overlay(
                                                    Button(action: {
                                                        self.showingActionSheet = true
                                                    }) {
                                                        Image("Image")
                                                            .clipShape(Circle())
                                                            .background(
                                                                Circle()
                                                                    .stroke(Color.white, lineWidth: 2)
                                                            )
                                                    }.offset(x: offset, y: -offset)
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
                                                    if (cmrstr == "Camera") {
                                                        ImagePickerView(sourceType: .camera) { image in
                                                            self.image = image
                                                            Profileimageupload.uploaadProfileImage(images: image)
                                                        }
                                                    } else if (cmrstr == "Gallery") {
                                                        ImagePickerView(sourceType: .photoLibrary) { image in
                                                            self.image = image
                                                            Profileimageupload.uploaadProfileImage(images: image)
                                                        }
                                                    }
                                                }
                                        } else {
                                            // Provide a placeholder image or any UI to indicate no image is available
                                            Image(systemName: "person.crop.circle.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: ConstantClass.mediumlogosize.logoWidth, height: ConstantClass.mediumlogosize.logoHeight)
                                                .cornerRadius(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .inset(by: 0.5)
                                                        .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                                )
                                                .overlay(
                                                    Button(action: {
                                                        self.showingActionSheet = true
                                                    }) {
                                                        Image("Image")
                                                            .clipShape(Circle())
                                                            .background(
                                                                Circle()
                                                                    .stroke(Color.white, lineWidth: 2)
                                                            )
                                                    }.offset(x: offset, y: -offset)
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
                                                    if (cmrstr == "Camera") {
                                                        ImagePickerView(sourceType: .camera) { image in
                                                            self.image = image
                                                            Profileimageupload.uploaadProfileImage(images: image)
                                                        }
                                                    } else if (cmrstr == "Gallery") {
                                                        ImagePickerView(sourceType: .photoLibrary) { image in
                                                            self.image = image
                                                            Profileimageupload.uploaadProfileImage(images: image)
                                                        }
                                                    }
                                                }
                                        }
                                    }
                                    
                                    
                                    Text(profilemodel.ProfileModel?.name ?? "")
                                        .fontWeight(.semibold)
                                        .lineLimit(1)
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                  
                                    
                                }
                                
                                
                                
                                
                                
                                VStack(spacing:20){
                                    VStack{
                                        
                                        HStack {
                                            Text("Personal Information")
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                .padding()
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                withAnimation {
                                                    PersonalInformation.toggle()
                                                }
                                            }) {
                                                HStack {
                                                    
                                                    Image(PersonalInformation ? "Alt Arrow Down-6" : "Alt Arrow Up-6")
                                                        .resizable()
                                                        .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                                                }
                                            }
                                            .padding()
                                            
                                        }
                                        .onTapGesture {
                                            PersonalInformation.toggle()
                                            
                                        }
                                        .frame(width: Responsiveframes.widthPercentageToDP(75))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .inset(by: 0.5)
                                                .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                        )
                                        
                                        
                                        VStack{
                                            
                                            if PersonalInformation {
                                                
                                                VStack(spacing:20){
                                                    HStack {
                                                        
                                                        Text("Name")
                                                            .font(Font.custom("Poppins-Black-SemiBold", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                            .foregroundColor(.black)
                                                            .lineLimit(1)
                                                        
                                                        Spacer()
                                                        
                                                        Text(profilemodel.ProfileModel?.name ?? "")
                                                            .foregroundColor(.gray)
                                                            .lineLimit(1)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                        
                                                    }
                                                    .padding()
                                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                    
                                                    
                                                    HStack {
                                                        
                                                        Text("Phone number")
                                                            .font(Font.custom("Poppins-Black-SemiBold", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                            .foregroundColor(.black)
                                                            .lineLimit(1)
                                                        
                                                        Spacer()
                                                        
                                                        
                                                        Text(profilemodel.ProfileModel?.phoneNo ?? "")
                                                            .foregroundColor(.gray)
                                                            .lineLimit(1)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                        
                                                    }
                                                    .padding()
                                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                    
                                                    
                                                    HStack {
                                                        
                                                        Text("Email")
                                                            .font(Font.custom("Poppins-Black-SemiBold", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                            .foregroundColor(.black)
                                                            .lineLimit(1)
                                                        
                                                        Spacer()
                                                        
                                                        
                                                        Text(profilemodel.ProfileModel?.email ?? "")
                                                            .foregroundColor(.gray)
                                                            .lineLimit(1)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                        
                                                    }
                                                    .padding()
                                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                    
                                                    
                                                    HStack {
                                                        
                                                        Text("Date of Birth")
                                                            .font(Font.custom("Poppins-Black-SemiBold", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                            .foregroundColor(.black)
                                                            .lineLimit(1)
                                                        
                                                        Spacer()
                                                        
                                                        
                                                        Text(profilemodel.ProfileModel?.dob ?? "")
                                                            .foregroundColor(.gray)
                                                            .lineLimit(1)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                        
                                                    }
                                                    .padding()
                                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                    
                                                    
                                                    HStack {
                                                        
                                                        Text("Citizenship")
                                                            .font(Font.custom("Poppins-Black-SemiBold", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                            .foregroundColor(.black)
                                                            .lineLimit(1)
                                                        
                                                        Spacer()
                                                        
                                                        
                                                        Text(profilemodel.ProfileModel?.citizenship ?? "")
                                                            .foregroundColor(.gray)
                                                            .lineLimit(1)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                        
                                                    }
                                                    .padding()
                                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                    
                                                    
                                                    HStack {
                                                        
                                                        Text("Security number")
                                                            .font(Font.custom("Poppins-Black-SemiBold", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                            .foregroundColor(.black)
                                                            .lineLimit(1)
                                                        
                                                        Spacer()
                                                        
                                                        
                                                        Text(profilemodel.ProfileModel?.ssn ?? "")
                                                            .foregroundColor(.gray)
                                                            .lineLimit(1)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                    }
                                                    .padding()
                                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                }
                                                .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                
                                            }
                                            
                                        }
                            
                                    }
                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.5)
                                            .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                    )
                                    .onTapGesture {
                                        PersonalInformation.toggle()
                                        
                                    }
                                    VStack{
                                        
                                        HStack {
                                            Text("Employment details")
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                .padding()
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                withAnimation {
                                                    Employmentdetails.toggle()
                                                }
                                            }) {
                                                HStack {
                                                    
                                                    Image( Employmentdetails ? "Alt Arrow Down-6" : "Alt Arrow Up-6")
                                                        .resizable()
                                                        .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                                                }
                                            }
                                            .padding()
                                            
                                        }
                                        
                                        .frame(width: Responsiveframes.widthPercentageToDP(75))
                                        
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .inset(by: 0.5)
                                                .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                        )
                                        
                                        VStack{
                                            
                                            if Employmentdetails {
                                                
                                                
                                                VStack(spacing:20){
                                                    HStack {
                                                        
                                                        Text("Employ ID")
                                                            .font(Font.custom("Poppins-Black-SemiBold", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                            .foregroundColor(.black)
                                                            .lineLimit(1)
                                                        
                                                        Spacer()
                                                        
                                                        Text(profilemodel.UserProfilemodel?.employeeID ?? "")
                                                            .foregroundColor(.gray)
                                                            .lineLimit(1)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                    }
                                                    .padding()
                                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                    
                                                    
                                                    HStack {
                                                        
                                                        Text("Employment Type")
                                                            .font(Font.custom("Poppins-Black-SemiBold", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                            .foregroundColor(.black)
                                                            .lineLimit(1)
                                                        
                                                        Spacer()
                                                        
                                                        
                                                        Text(profilemodel.UserProfilemodel?.employmentType ?? "")
                                                            .foregroundColor(.gray)
                                                            .lineLimit(1)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                        
                                                    }
                                                    .padding()
                                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                    
                                                    
                                                    HStack {
                                                        
                                                        Text("Hire Date")
                                                            .font(Font.custom("Poppins-Black-SemiBold", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                            .foregroundColor(.black)
                                                            .lineLimit(1)
                                                        
                                                        Spacer()
                                                        
                                                        
                                                        Text(profilemodel.UserProfilemodel?.hireDate ?? "")
                                                            .foregroundColor(.gray)
                                                            .lineLimit(1)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                        
                                                    }
                                                    .padding()
                                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                    
                                                }
                                                .frame(width: Responsiveframes.widthPercentageToDP(75))
                                            }
                                        }
                                    }
                                    
                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.5)
                                            .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                    )
                                    .onTapGesture {
                                        Employmentdetails.toggle()
                                        
                                    }
                                    
                                    VStack{
                                        
                                        HStack {
                                            Text("Language Skills")
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                .padding()
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                withAnimation {
                                                    LanguageSkills.toggle()
                                                }
                                            }) {
                                                HStack {
                                                    
                                                    Image( LanguageSkills ? "Alt Arrow Down-6" : "Alt Arrow Up-6")
                                                        .resizable()
                                                        .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                                                }
                                            }
                                            .padding()
                                            
                                        }
                                        .frame(width: Responsiveframes.widthPercentageToDP(75))
                                        
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .inset(by: 0.5)
                                                .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                        )
                                        
                                        VStack {
                                            if LanguageSkills {
                                                VStack {
                                                    ScrollView {
                                                        LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 10){
                                                            ForEach(profilemodel.languageskillarray, id: \.self) { language in
                                                                RectangleView(language: language)
                                                            }
                                                        }
                                                    }
                                                    .padding()
                                                }
                                            }
                                        }
                                        
                                    }
                                    
                                    .onTapGesture {
                                        LanguageSkills.toggle()
                                        
                                    }
                                    
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.5)
                                            .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                    )
                                    
                                    
                                    VStack{
                                        
                                        HStack {
                                            Text("Certificates")
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                .padding()
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                withAnimation {
                                                    Certificates.toggle()
                                                }
                                            }) {
                                                HStack {
                                                    
                                                    Image(Certificates ? "Alt Arrow Down-6" : "Alt Arrow Up-6")
                                                        .resizable()
                                                        .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                                                }
                                            }
                                            .padding()
                                            
                                        }
                                        .frame(width: Responsiveframes.widthPercentageToDP(75))
                                        
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .inset(by: 0.5)
                                                .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                        )
                                        VStack{
                                            
                                            if Certificates {
                                                
                                                VStack{
                                                    
//                                                    ForEach(profilemodel.certificatearray , id: \.self) { certificate in
                                                     
                                             ForEach(Array(profilemodel.certificatearray.enumerated()), id: \.element) { index, certificate in

                                                        HStack {
                                                            Text(certificate.certificateName)
                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                                .padding()
                                                            
                                                            Spacer()
                                                            
                                                            Button(action: {
                                                                withAnimation {
                                                                    Certificates.toggle()
                                                                }
                                                            }) {
                                                                HStack {
                                                                    
                                                                    
                                                                    Button(action: {
                                                                        
                                                                    //    certificateURL = cetificate
                                                                        
                                                                        
                                                                        
                                                                    certificateURL =  certificate.documents.documentUrl
                                                                        
                                                                        
                                                                        downloadtaskreport()
                                                                        
                                                                     //   self.downloadDocument()
                                                                    }) {
                                                                        Image("material-symbols_download-1")
                                                                            .resizable()
                                                                            .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                                                                    }
                                                                    .padding()
                                                                    .onTapGesture(){
                                                                   // print(certificate.documents.documentId[index])
                                                                    //    certificateURL =  certificate.documents.documentId

                                                                    }
                                                 
                                                                }
                                                            }
                                                            .padding()
                                                            
                                                        }
                                                    }
                                                    
                                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .inset(by: 0.5)
                                                            .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                                    )
                                                    
                                                }
                                                .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                    .onTapGesture {
                                        Certificates.toggle()
                                        
                                    }
                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.5)
                                            .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                    )
                                    
                                    VStack{
                                        
                                        HStack {
                                            Text("Bank Account Details")
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                .padding()
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                withAnimation {
                                                    Bankaccountdetails.toggle()
                                                }
                                            }) {
                                                HStack {
                                                    
                                                    Image( Bankaccountdetails ? "Alt Arrow Down-6" : "Alt Arrow Up-6")
                                                        .resizable()
                                                        .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                                                }
                                            }
                                            .padding()
                                            
                                        }
                                        
                                        .frame(width: Responsiveframes.widthPercentageToDP(75))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .inset(by: 0.5)
                                                .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                        )
                                        
                                        
                                        VStack{
                                            
                                            if Bankaccountdetails {
                                                
                                                
                                                VStack(spacing:20){
                                                    HStack {
                                                        
                                                        Text("Bank Holder Name")
                                                            .font(Font.custom("Poppins-Black-SemiBold", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                            .foregroundColor(.black)
                                                            .lineLimit(1)
                                                        
                                                        Spacer()
                                                        
                                                        Text(profilemodel.bankdetails?.holderName ?? "")
                                                            .foregroundColor(.gray)
                                                            .lineLimit(1)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                    }
                                                    .padding()
                                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                    
                                                    HStack {
                                                        
                                                        Text("Bank Name")
                                                            .font(Font.custom("Poppins-Black-SemiBold", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                            .foregroundColor(.black)
                                                            .lineLimit(1)
                                                        
                                                        Spacer()
                                                        
                                                        
                                                        Text(profilemodel.bankdetails?.bankName ?? "")
                                                            .foregroundColor(.gray)
                                                            .lineLimit(1)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                    }
                                                    .padding()
                                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                    //
                                                    HStack {
                                                        
                                                        Text("Account Number")
                                                            .font(Font.custom("Poppins-Black-SemiBold", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                            .foregroundColor(.black)
                                                            .lineLimit(1)
                                                        
                                                        Spacer()
                                                        
//
//                                                        if let accountNumberString = profilemodel.bankdetails?.accountNumber {
//                                                            let length = accountNumberString.count
//                                                            
//                                                            if length >= 4 {
//                                                                let obscuredPart = String(repeating: "X", count: length - 4)
//                                                                let lastFourDigits = String(accountNumberString.supix(4))
//                                                                let maskedAccountNumber = "\(obscuredPart)-\(lastFourDigits)"
//                                                                Text(maskedAccountNumber)
//                                                                
//                                                                            .foregroundColor(.gray)
//                                                                            .lineLimit(1)
//                                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                            } else {
//                                                                // Handle case where account number is too short
//                                                                Text(accountNumberString)
//                                                                
//                                                                
//                                                            }
//                                                        }
                                                        if let accountNumberString = profilemodel.bankdetails?.accountNumber {
                                                            let length = accountNumberString.count
                                                            
                                                            if length >= 4 {
                                                                let lastFourDigits = accountNumberString.suffix(4)
                                                                let obscuredPart = String(repeating: "X", count: length - 6)
                                                                let maskedAccountNumber = "\(obscuredPart)\(lastFourDigits)"
                                                                
                                                                Text(maskedAccountNumber)
                                                                    .foregroundColor(.gray)
                                                                    .lineLimit(1)
                                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                            } else {
                                                                // Handle case where account number is too short
                                                                Text(accountNumberString)
                                                                    .foregroundColor(.gray)
                                                                    .lineLimit(1)
                                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                            }
                                                        }

                                                        
                                                        
                                                        
                                                        else {
                                                            // Handle case where account number is nil
                                                            Text("No account number available")
                                                                .frame(width: 10.0)

                                                        }

                                                        
                                                    }
                                                    .padding()
                                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                    
                                                    
                                                    
                                                    
                                                    HStack {
                                                        
                                                        Text("Account Type")
                                                            .font(Font.custom("Poppins-Black-SemiBold", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                            .foregroundColor(.black)
                                                            .lineLimit(1)
                                                        
                                                        Spacer()
                                                        
                                                        Text(profilemodel.bankdetails?.accountType ?? "")
                                                            .foregroundColor(.gray)
                                                            .lineLimit(1)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                        
                                                    }
                                                    .padding()
                                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                    
                                                    
                                                    HStack {
                                                        
                                                        Text("IBAN Number")
                                                            .font(Font.custom("Poppins-Black-SemiBold", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                            .foregroundColor(.black)
                                                            .lineLimit(1)
                                                        
                                                        Spacer()
                                                        
                                                        Text(profilemodel.bankdetails?.ibanNumber ?? "")
                                                            .foregroundColor(.gray)
                                                            .lineLimit(1)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
//                                                        
                                                    }
                                                    .padding()
                                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                    
                                                }
                                                .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                    .onTapGesture {
                                        Bankaccountdetails.toggle()
                                        
                                    }
                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.5)
                                            .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                    )
                                    
                                    VStack{
                                        
                                        HStack {
                                            Text("My Workforce")
                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                .padding()
                                            
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                withAnimation {
                                                    workforce.toggle()
                                                }
                                            }) {
                                                HStack {
                                                    
                                                    Image( workforce ? "Alt Arrow Down-6" : "Alt Arrow Up-6")
                                                        .resizable()
                                                        .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                                                }
                                            }
                                            .padding()
                                            
                                        }
                                        
                                        .frame(width: Responsiveframes.widthPercentageToDP(75))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .inset(by: 0.5)
                                                .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                        )
                                        
                                        
                                        VStack{
                                            
                                            if workforce {
                                                
                                                
                                                VStack(spacing:20){
                                                    HStack {
                                                        
                                                        Text("Workforce name")
                                                            .font(Font.custom("Poppins-Black-SemiBold", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                            .foregroundColor(.black)
                                                            .lineLimit(1)
                                                        
                                                        Spacer()
                                                        
                                                        Text(profilemodel.workforce?.name ?? "")
                                                            .foregroundColor(.gray)
                                                            .lineLimit(1)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                    }
                                                    .padding()
                                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                    
                                                    HStack {
                                                        
                                                        Text("Site name")
                                                            .font(Font.custom("Poppins-Black-SemiBold", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                            .foregroundColor(.black)
                                                            .lineLimit(1)
                                                        
                                                        Spacer()
                                                        
                                                        Text(profilemodel.workforce?.companySites ?? "")
                                                            .foregroundColor(.gray)
                                                            .lineLimit(1)
                                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                        
                                                    }
                                                    .padding()
                                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                    //
                                                    
                                                    if (UserDefaults.standard.string(forKey: "Role") == "WORKER"){
                                                        
                                                        HStack {
                                                            
                                                            Text("Supervisor")
                                                                .font(Font.custom("Poppins-Black-SemiBold", size: Responsiveframes.responsiveFontSize(2.0)))
                                                                .foregroundColor(.black)
                                                                .lineLimit(1)
                                                            
                                                            Spacer()
                                                         
                                                            Text(profilemodel.workforce?.supervisorName ?? "")
                                                                .foregroundColor(.gray)
                                                                .lineLimit(1)
                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                            
                                                        }
                                                        .padding()
                                                        .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                        
                                                        
                                                        
                                                    }
                                                    
                                                    else{
                                                        
                                                        HStack {
                                                            
                                                            Text("Total Workers")
                                                                .font(Font.custom("Poppins-Black-SemiBold", size: Responsiveframes.responsiveFontSize(2.0)))
                                                                .foregroundColor(.black)
                                                                .lineLimit(1)
                                                            
                                                            Spacer()
                                                            let workersCount = profilemodel.workforce?.workers ?? 0 // Assuming workers is an integer
                                                            let text = "\(workersCount)"
                                                            Text(text)
                                                                .foregroundColor(.gray)
                                                                .lineLimit(1)
                                                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                            
                                                        }
                                                        .padding()
                                                        .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                        
                                                        
                                                    }
                                                }
                                                .frame(width: Responsiveframes.widthPercentageToDP(75))
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                    .onTapGesture {
                                        workforce.toggle()
                                        
                                    }
                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.5)
                                            .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                    )
                                    
                                    
                                    HStack {
                                        Text("Settings")
                                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                            .padding()
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            withAnimation {
                                                settingshow.toggle()
                                            }
                                        }) {
                                            HStack {
                                                
                                                Image( "Settings 1" )
                                                    .resizable()
                                                    .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                                            }
                                        }
                                        .padding()
                                        
                                    }
                                    .onTapGesture {
                                        settingshow.toggle()
                                        
                                    }
                                    
                                    //                                    .fullScreenCover(isPresented: $settings, content: {
                                    //                                        WorkerSetting()
                                    //                                    })
                                    
                                    .frame(width: Responsiveframes.widthPercentageToDP(75))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.5)
                                            .stroke(Color.black.opacity(0.15), lineWidth: 1)
                                    )
                                    
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(75))
                                
                                
                                
                                
                                VStack(spacing: 20){
                                    
                                    if UserDefaults.standard.integer(forKey: "workforceId") != 0{
                                        if   (UserDefaults.standard.string(forKey: "Role") ==  "SUPERVISOR"){
                                            
                                            Button(action: {
                                                // Add your sign-in action here
                                                Workertimesheetshow.toggle()
                                                
                                            }) {
                                                HStack {
                                                    Spacer()
                                                    Text("My Time Sheet")
                                                        .foregroundColor(.black)
                                                        .font(ConstantClass.AppFonts.medium)
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(1)
                                                    Spacer()
                                                }
                                            }
                                            .frame(width: Responsiveframes.widthPercentageToDP(75),height: Responsiveframes.heightPercentageToDP(7))
                                            .background(Color.offwhite)
                                            .cornerRadius(10)
                                            .multilineTextAlignment(.center)
                                            
                                            .onTapGesture {
                                                //       mainview.toggle()
                                                Workertimesheetshow.toggle()
                                            }
                                            
                                            
                                        }
                                        
                                        else{
                                            Button(action: {
                                                // Add your sign-in action here
                                                completedtask.toggle()
                                            }) {
                                                HStack {
                                                    Spacer()
                                                    Text("My Completed Tasks")
                                                        .foregroundColor(.black)
                                                        .font(ConstantClass.AppFonts.medium)
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(1)
                                                    Spacer()
                                                }
                                            }
                                            .frame(width: Responsiveframes.widthPercentageToDP(75),height: Responsiveframes.heightPercentageToDP(7))
                                            .background(Color.offwhite)
                                            .cornerRadius(10)
                                            .multilineTextAlignment(.center)
                                            
                                            .onTapGesture {
                                                //       mainview.toggle()
                                                completedtask.toggle()
                                                
                                            }
                                        }
                                        
                                    }
                                    
                                    
                                    Button(action: {
                                              // Show the logout alert
                                              logoutAlertPresented.toggle()

                                        
                                          }) {
                                              HStack {
                                                  Text("Logout")
                                                      .foregroundColor(.white)
                                                      .font(ConstantClass.AppFonts.medium)
                                                      .multilineTextAlignment(.center)
                                                      .lineLimit(1)
                                                  Spacer()
                                                  Image("Arrows A Logout")
                                                      .resizable()
                                                      .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                                              }
                                          }
                                          .padding()
                                          .frame(width: Responsiveframes.widthPercentageToDP(75), height: Responsiveframes.heightPercentageToDP(7))
                                          .background(Color.accentColor)
                                          .cornerRadius(10)
                                          .multilineTextAlignment(.center)
                                          .alert(isPresented: $logoutAlertPresented) {
                                              Alert(title: Text("Logout"), message: Text("Are you sure you want to logout?"), primaryButton: .default(Text("Yes")) {
                                                  
                                                  
                                                  //  WorkerCheckvm.siteId = UserDefaults.standard.string(forKey: "siteId")
                                               WorkerCheckvm.LogoutAPI()
                                             
                                          
                                                  clearUserData()
                                                 // Logoutshow.toggle()
                                                  if let window = UIApplication.shared.windows.first {
                                                             window.rootViewController = UIHostingController(rootView: ContentView())
                                                             window.makeKeyAndVisible()
                                                         }
                                            
                                                  // Dismiss all views
                                                 // presentationMode.wrappedValue.dismiss()
                                              }, secondaryButton: .cancel(Text("No")))
                                          }
                                    
                                          .fullScreenCover(isPresented: $Logoutshow, content: {
                                              Login()
                                          })
                                }
                            }
                            
                            .frame(width: Responsiveframes.widthPercentageToDP(80))
                            .padding()
                            
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                            )
                            
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .inset(by: 0.5)
                                    .stroke(Color.black.opacity(0.15), lineWidth: 0.5)
                            )
                            
                        }
                    }
                    
               // .frame(width: min(geometry.size.width, geometry.size.height), height: max(geometry.size.width, geometry.size.height))

                    
                    .frame(width: geometry.size.width) // Adjusted frame width based on geometry
                    .onAppear(){
                        statuscheck.GetallStatus()
                        profilemodel.profilefetch()
                        profilemodel.WorkForceapi()
                    }
                    
                    NavigationLink(destination: WorkerSetting(), isActive: $settingshow) { EmptyView() }
                    NavigationLink(destination: WorkerTimeReport(), isActive: $Workertimesheetshow) { EmptyView() }
                    NavigationLink(destination: MyCompletedTask(), isActive: $completedtask) { EmptyView() }
                    
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        
        
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    
    func uploadImagesToAPI() {
        // Call your API function with the array of selected images
        Profileimageupload.uploaadProfileImage(images: image!)
        
    }
    
    func downloadtaskreport() {
        
      //  let str = "http://62.171.153.83:8080/tappme-api-development/worker/report/download/pdf/" + String(reportid)

        
        let str = certificateURL

        if let pdfURL = URL(string: str),
           let pdfData = try? Data(contentsOf: pdfURL) {
            savePDFToCustomDirectory(pdfData: pdfData)
        } else {
            print("Invalid PDF URL or unable to fetch PDF data")
        }
    }
    
    
    
    func savePDFToCustomDirectory(pdfData: Data) {
        let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let customDirectory = documentsDirectory.appendingPathComponent(appName)
        
        // Check if the custom directory exists
        if !FileManager.default.fileExists(atPath: customDirectory.path) {
            // If not, create it
            do {
                try FileManager.default.createDirectory(at: customDirectory, withIntermediateDirectories: true, attributes: nil)
                print("Custom directory created: \(customDirectory)")
            } catch {
                print("Error creating custom directory: \(error.localizedDescription)")
                return
            }
        }
        
        let pdfFileName = "downloadedPDF-\(UUID().uuidString).pdf"
            let pdfFileURL = customDirectory.appendingPathComponent(pdfFileName)
            
            do {
                // Write the PDF data to the file URL
                try pdfData.write(to: pdfFileURL)
                print("PDF downloaded and saved to: \(pdfFileURL)")
                Toast(text: "Certificate downloaded Successfully").show()

            } catch {
                print("Error saving PDF: \(error.localizedDescription)")
            }
        }
    
    func clearUserData() {
        let deviceToken = UserDefaults.standard.string(forKey: "devicetoken")
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
        }
        UserDefaults.standard.setValue(deviceToken, forKey: "devicetoken")
        
        UserDefaults.standard.removeObject(forKey: "login")

        
    }

    
    func downloadDocument() {
        
        guard let url = URL(string: "https://example.com/document.pdf") else {
            print("Invalid URL")
            return
        }
        
        isDownloading = true
        
        URLSession.shared.downloadTask(with: url) { (location, response, error) in
            defer {
                self.isDownloading = false
            }
            
            if let error = error {
                print("Download failed: \(error.localizedDescription)")
                return
            }
            
            guard let location = location else {
                print("Download location not found")
                return
            }
            
            do {
                let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let destinationURL = documentsURL.appendingPathComponent("document.pdf")
                
                try FileManager.default.moveItem(at: location, to: destinationURL)
                
                print("Document downloaded successfully: \(destinationURL)")
                
                // Handle document here, for example, open it using UIDocumentInteractionController or share it
            } catch {
                print("Failed to save document: \(error.localizedDescription)")
            }
        }.resume()
    }
}

struct RectangleView: View {
    var language: String

    var body: some View {

        VStack (alignment: .leading){
            Text(language)
                .lineLimit(1)
                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))                         .multilineTextAlignment(.center)
                .foregroundColor(.lightblue)
        }
        .padding()
       .frame(width: Responsiveframes.widthPercentageToDP(25), height: Responsiveframes.heightPercentageToDP(7))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .inset(by: 0.5)
                .stroke(Color.lightblue, lineWidth: 1)
        )
    }
}


#Preview {
    Profile()
}

