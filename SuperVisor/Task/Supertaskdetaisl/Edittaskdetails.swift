//
//  Edittaskdetails.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 28/03/24.
//

import SwiftUI

struct Edittaskdetails: View {
    @State private var Report: String = ""
    @State private var description: String = ""
    
    @State var image = UIImage(named: "AppIcon")
    
    @State var cmrstr = String()
    @State var showImagePicker: Bool = false
    
    @State  var textStyle = UIFont.TextStyle.body
    
    @State var showcompanypicker: Bool = false
    @State var CompanyName : String? = "Medium"
    let radius: CGFloat = 65
    var offset: CGFloat {
        sqrt(radius * radius / 2)
    }
    @State private var showingActionSheet = false
    @State private var selectedImages: [UIImage] = []
    @State private var mainview = false
    @State var showDatePicker: Bool = false
    @State var savedDate: Date? = nil
    @State var savedDatestr  : String? = nil
    @State var savedDatestr1 : String? = nil
    @State var setnewpassword: Bool = false
    
    
    @State var showDueDatePicker: Bool = false
    @State var savedDatedue: Date? = nil
    @State var saveddueDate  : String? = nil
    @State var savedDatedue1 : String? = nil
    
        var TaskDetaildata: Tasklist

       @StateObject var createVM = CreateNewTaskVm()
        @State private var isEditingTaskName = false
        @State private var isEditingDescription = false
        @State private var isEditingStartDate = false
        @State private var isEditingDueDate = false
        @State private var isEditingPriority = false

    
    @Environment(\.presentationMode) var presentationMode
    
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
                                    
                                    Text("Edit Task")
                                        .fontWeight(.semibold)
                                        .lineLimit(2)
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                                    
                                    Spacer()
                                    
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(90))
                                ScrollView(.vertical , showsIndicators: false){
                                    
                                    
                                    VStack(alignment: .leading, spacing: 20) {
                                    //    if isEditingTaskName {
                              
                                            VStack{
                                                
                                                VStack(alignment: .leading){
                                                    Text("Task name")
                                                        .font(ConstantClass.AppFonts.light)
                                                        .foregroundColor(.black)
                                                    
                                                    
                                                    TextField("", text: $createVM.name)
                                                        .padding(.leading, 5.0)
                                                        .font(ConstantClass.AppFonts.light)
                                                    
                                                        .frame(width:ConstantClass.Emptytextfield.width, height: ConstantClass.Emptytextfield.height1)
                                                        .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
                                                        .overlay(
                                                            ConstantClass.Emptytextfield.getOverlay()
                                                        )
                                                }.onAppear(){
                                                    createVM.name = TaskDetaildata.name
                                                }
                                                if (createVM.showError && ((createVM.errorState).object(forKey: "name") != nil)){
                                                    if let emailErrors = createVM.errorState["name"] as? [String], !emailErrors.isEmpty {
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

                                
                                
                                
//                                if isEditingDescription {
                               
                                    
                                    
                                    VStack{
                                        
                                        VStack(alignment: .leading){
                                            Text("Description")
                                                .font(ConstantClass.AppFonts.light)
                                                .foregroundColor(.black)
                                            // .padding(.leading, 5.0)
                                            //         TextField(text: $fullname)
                                            
                                            TextView(text: $createVM.descriptionText, textStyle: $textStyle)
                                                .padding(.leading, 5.0)
                                                .multilineTextAlignment(.leading)
                                                .font(ConstantClass.AppFonts.light)
                                            
                                                .frame(width:ConstantClass.Emptytextfield.textdescriptionwidth, height: ConstantClass.Emptytextfield.textdescriptionheight)
                                                .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
                                                .overlay(
                                                    ConstantClass.Emptytextfield.getOverlay()
                                                )
                                                .onAppear(){
                                                    createVM.descriptionText = TaskDetaildata.description
                                                }
                                            
                                        }
                                        if (createVM.showError && ((createVM.errorState).object(forKey: "description") != nil)){
                                            if let emailErrors = createVM.errorState["description"] as? [String], !emailErrors.isEmpty {
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
                                    
                       
                                    
                                    VStack{
                                        
                                        VStack(alignment: .leading){
                                            Text("Start Date")
                                                .font(ConstantClass.AppFonts.light)
                                                .foregroundColor(.black)
                                            // .padding(.leading, 5.0)
                                            
                                            HStack{
                                                
                                                Text(savedDatestr1 ?? "DD/MM/YYYY")
                                                    .font(ConstantClass.AppFonts.light)
                                                    .padding(.leading, 5.0)
                                                    .foregroundColor(savedDatestr1 != nil ? .black : .gray)
                                                
                                                Spacer()
                                                Image("Image 3")
                                                    .resizable()
                                                    .padding(.trailing, 7.0)
                                                    .frame(width: 30.0, height: 30.0)
                                                
                                                
                                            }
                                            .frame(width:ConstantClass.Emptytextfield.width, height: ConstantClass.Emptytextfield.height)
                                            .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
                                            .overlay(
                                                ConstantClass.Emptytextfield.getOverlay()
                                            )
                                            .onTapGesture {
                                                showDatePicker.toggle()
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                
                                            }
                                            
                                            .onAppear(){
                                       
                                             //   let dueDate = DateConverter.convertDateFormat1(dateString: TaskDetaildata.startDate)

                                                savedDatestr1 = TaskDetaildata.startDate

                                            }
                                            .onChange(of: savedDatestr1) { newValue in
                                                  // This block executes when the user changes the date
                                                  // Update your ViewModel here with the new start date
                                                  if let newStartDate = newValue {
                                                      createVM.startDate = newStartDate
                                                      print(createVM.startDate)
                                                  }
                                              }
                                        }
                                        
                                        
                                        if (createVM.showError && ((createVM.errorState).object(forKey: "startDate") != nil)){
                                            if let emailErrors = createVM.errorState["startDate"] as? [String], !emailErrors.isEmpty {
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
                                    
                                    VStack{
                                        
                                        VStack(alignment: .leading){
                                            Text("Due Date")
                                                .font(ConstantClass.AppFonts.light)
                                                .foregroundColor(.black)
                                         
                                            HStack(spacing: 20.00){
                                                

                                                Text(savedDatedue1 ?? "DD/MM/YYYY")
                                                    .font(ConstantClass.AppFonts.light)
                                                
                                                    .foregroundColor(savedDatedue1 != nil ? .black : .gray)
                                                
                                                    .padding(.leading, 5.0)
                                                Spacer()
                                                
                                                Image("Image 3")
                                                    .resizable()
                                                    .padding(.trailing, 7.0)
                                                    .frame(width: 30.0, height: 30.0)
                                                
                                            }
                                            .frame(width:ConstantClass.Emptytextfield.width, height: ConstantClass.Emptytextfield.height)
                                            .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
                                            .overlay(
                                                ConstantClass.Emptytextfield.getOverlay()
                                            )
                                            .onTapGesture {
                                                showDueDatePicker.toggle()
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                
                                            }
                                            .onAppear(){
                                         //   let dueDate = DateConverter.convertDateFormat1(dateString: TaskDetaildata.dueDate)

                                                savedDatedue1 = TaskDetaildata.dueDate
                                         
                                            }
                                            
                                            .onChange(of: savedDatedue1) { newValue in
                                                  // This block executes when the user changes the date
                                                  // Update your ViewModel here with the new start date
                                                  if let newdueDate = newValue {
                                                      createVM.dueDate = newdueDate
                                                      print(createVM.dueDate)
                                                  }
                                              }
                                            
                                        }
                                        if (createVM.showError && ((createVM.errorState).object(forKey: "dueDate") != nil)){
                                            if let emailErrors = createVM.errorState["dueDate"] as? [String], !emailErrors.isEmpty {
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
                                    
                                        VStack{
                                        VStack(alignment: .leading){
                                            Text("Select Priority")
                                                .font(ConstantClass.AppFonts.light)
                                                .foregroundColor(.black)
                                            // .padding(.leading, 5.0)
                                            
                                            PriorityPickerView(value: $CompanyName, showCompanyPicekr: $showcompanypicker)
                                            // .animation(.linear)
                                                .transition(.opacity)
                                                .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(5))
                                        }
                                        .onAppear(){
                                            createVM.priority = TaskDetaildata.priority
                                        }
                                        
                                        if (createVM.showError && ((createVM.errorState).object(forKey: "priority") != nil)){
                                            if let emailErrors = createVM.errorState["priority"] as? [String], !emailErrors.isEmpty {
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
                         
                                    
                                
                            }
                            .padding()
                            
                        }
                    
                        
                        Button(action: {
                           
                            if let startDate = savedDatestr {
                                 createVM.startDate = startDate
                             } else {
                                 createVM.startDate = TaskDetaildata.startDate
                             }
                            
                            if let duedate = saveddueDate {
                                 createVM.dueDate = duedate
                             } else {
                                 createVM.dueDate = TaskDetaildata.dueDate
                             }
                            
                            createVM.priority = CompanyName ?? ""
                            createVM.taskid = TaskDetaildata.taskId
                            
                            createVM.Updatetaskdetails {
                                self.presentationMode.wrappedValue.dismiss()
                                
                            }
                            //    setnewpassword.toggle()
                            
                        }) {
                            HStack {
                                Spacer()
                                Text("Update Task")
                                    .foregroundColor(.white)
                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                //        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                Spacer()
                            }
                        }
                        .frame(width: Responsiveframes.widthPercentageToDP(90),height: Responsiveframes.heightPercentageToDP(6))
                        .background(Color.accentColor)
                        .cornerRadius(10)
                        .multilineTextAlignment(.center)
                        
                        .onTapGesture {
                            
                            if let startDate = savedDatestr {
                                 createVM.startDate = startDate
                             } else {
                                 createVM.startDate = TaskDetaildata.startDate
                             }
                            
                            if let duedate = saveddueDate {
                                 createVM.dueDate = duedate
                             } else {
                                 createVM.dueDate = TaskDetaildata.dueDate
                             }
                            
                            createVM.Updatetaskdetails {
                                self.presentationMode.wrappedValue.dismiss()
                                
                            }
                            
                        }
                        
                        Spacer()
                    }
                
                    
                            
                        }
                        .frame(width: Responsiveframes.widthPercentageToDP(90))
                   
                    }
                    
                    .frame(width: geometry.size.width)  // Adjusted frame width based on geometry
                    
                    if showDatePicker {
                        StartDatePicker(showDatePicker: $showDatePicker, savedDate: $savedDate, selectedDate: savedDate ?? Date(), savedDatestr: $savedDatestr, savedDatestr1: $savedDatestr1)
                        // .animation(.linear)
                            .transition(.opacity)
                    }
                    
                    
                    if showDueDatePicker {
                        DueDatePicker(showDatePicker: $showDueDatePicker, savedDate: $savedDatedue, selectedDate: savedDatedue ?? Date(), savedDatestr: $saveddueDate, savedDatestr1: $savedDatedue1)
                        // .animation(.linear)
                            .transition(.opacity)
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

//
//#Preview {
//    Edittaskdetails()
//}
