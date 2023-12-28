//
//  SuperCreateNewTask.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 11/01/24.
//

import SwiftUI

struct SuperCreateNewTask: View {
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
    
  @StateObject var createVM = CreateNewTaskVm()
    
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
                                    
                                    Text("Create New Task")
                                        .fontWeight(.semibold)
                                        .lineLimit(2)
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                                    
                                    Spacer()
                                    
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(90))
                                                                
                                
                                
                                ScrollView(.vertical , showsIndicators: false){
                                    
                                    
                                    
                                    VStack(spacing: 20){
                                        
                                        VStack{

                                            VStack(alignment: .leading){
                                                Text("Task name")
                                                    .font(ConstantClass.AppFonts.light)
                                                    .foregroundColor(.black)
                                                //         TextField(text: $fullname)
                                                TextField("Enter task name", text: $createVM.name)
                                                    .padding(.leading, 5.0)
                                                    .font(ConstantClass.AppFonts.light)
                                                
                                                    .frame(width:ConstantClass.Emptytextfield.width, height: ConstantClass.Emptytextfield.height)
                                                    .cornerRadius(ConstantClass.Emptytextfield.cornerRadius)
                                                    .overlay(
                                                        ConstantClass.Emptytextfield.getOverlay()
                                                    )
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
                                                //.padding(.leading, 5.0)
                                                
                                                
                                                //
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
                                                //  .cornerRadius(16)
                                                
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
                                    
                                }
                                
                                Button(action: {
                                    // Add your sign-in action here
                                    createVM.startDate = savedDatestr ?? ""
                                    createVM.dueDate = saveddueDate ?? ""
                                    createVM.priority = CompanyName ?? ""
                 
                                    createVM.crestetask {
                                        self.presentationMode.wrappedValue.dismiss()
                                        
                                    }

                           
                                    
                                }) {
                                    HStack {
                                        Spacer()
                                        Text("Create Task")
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
                                    createVM.startDate = savedDatestr ?? ""
                                    createVM.dueDate = saveddueDate ?? ""
                                    createVM.priority = CompanyName ?? ""
                 
                                      createVM.crestetask {
                                          self.presentationMode.wrappedValue.dismiss()
                                      }
                                }
                                
                                Spacer()
                            }
                        }
                        .frame(width: Responsiveframes.widthPercentageToDP(90))
                    }
                    
                    .disabled(showDatePicker) // Disable interaction with background when DatePicker is shown
                    .disabled(showDueDatePicker) // Disable interaction with background when DatePicker is shown

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



struct StartDatePicker: View {
    @Binding var showDatePicker: Bool
    @Binding var savedDate: Date?
    @State var selectedDate: Date = Date()
    @Binding var savedDatestr: String?
    @Binding var savedDatestr1: String?
    
    var body: some View {
        ZStack {
//            Color.black.opacity(0.3)
//                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 5.0) {
                DatePicker(
                    "Test",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .colorScheme(.dark)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.white.opacity(0.5))
                )
                .padding()
                
                Divider()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showDatePicker = false
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.white)
                    })
                    .frame(width: 110, height: 50)
                    .background(Color("blackcolor"))
                    .cornerRadius(10)
        
                    Button(action: {
                        let formatter1 = DateFormatter()
                        formatter1.dateFormat = "dd-MM-yyyy"
                        let stro = formatter1.string(from: selectedDate)
                        savedDatestr1 = stro
                        
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd"
                        let str = formatter.string(from: selectedDate)
                        
                        savedDatestr = str
                        savedDate = selectedDate
                        showDatePicker = false
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetDate"), object: self)
                        
                    }, label: {
                        Text("Set Date")
                            .foregroundColor(.white)
                    })
                    .frame(width: 110, height: 50)
                    .background(Color("redColor"))
                    .cornerRadius(10)
                }
                .padding(.horizontal)
            }
//            .background(
//                RoundedRectangle(cornerRadius: 30)
//                    .foregroundColor(Color.black)
//            )
            .background(
                RoundedRectangle(cornerRadius: 30)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.cdDarkGray, Color.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing))
//                    .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.darkblue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing))

            )
        }
    }
}


struct DueDatePicker: View {
    @Binding var showDatePicker: Bool
    @Binding var savedDate: Date?
    @State var selectedDate: Date = Date()
    @Binding var savedDatestr: String?
    @Binding var savedDatestr1: String?
    
    var body: some View {
        ZStack {
//            Color.black.opacity(0.3)
//                .edgesIgnoringSafeArea(.all)
//            
            VStack(spacing: 5.0) {

                
                DatePicker(
                    "Test",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .colorScheme(.dark)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.white.opacity(0.5))
                )
                .padding()
                
                Divider()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showDatePicker = false
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.white)
                    })
                    .frame(width: 110, height: 50)
                    .background(Color("blackcolor"))
                    .cornerRadius(10)
                    
                    Button(action: {
                        let formatter1 = DateFormatter()
                        formatter1.dateFormat = "dd-MM-yyyy"
                        let stro = formatter1.string(from: selectedDate)
                        savedDatestr1 = stro
                        
                        print(savedDatestr1)
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd"
                        let str = formatter.string(from: selectedDate)
                        
        
                        savedDatestr = str
                        
                        savedDate = selectedDate
                        showDatePicker = false
                        
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetDate"), object: self)
                        
                    }, label: {
                        Text("Set Date")
                            .foregroundColor(.white)
                    })
                    .frame(width: 110, height: 50)
                    .background(Color("redColor"))
                    .cornerRadius(10)
                }
                .padding(.horizontal)
            }
//            .background(
//                RoundedRectangle(cornerRadius: 30)
//                    .foregroundColor(Color.black)
//            )
            
            .background(
                RoundedRectangle(cornerRadius: 30)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.cdDarkGray, Color.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing))
//                    .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.darkblue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing))

            )
        }
    }
}




struct PriorityPickerView: View {
    
    @Binding var value: String?
    @State var value1 = ""
    @Binding var showCompanyPicekr: Bool
    
    let PriorityList = ["High", "Medium", "Low"] // Corrected spelling of Medium
    var placeholder = "Medium"
    
    init(value: Binding<String?>, showCompanyPicekr: Binding<Bool>) {
        self._value = value
        self._showCompanyPicekr = showCompanyPicekr
        self._value1 = State(initialValue: PriorityList[1] ) // Selecting priority at the second index
    }
    
    var body: some View {
        
        HStack{
            Menu {
                ForEach(PriorityList, id: \.self) { company in
                    Button(action: {
                        self.value1 = company
                        self.value = company
                        self.showCompanyPicekr.toggle()
                    }) {
                        Text(company)
                            .font(ConstantClass.AppFonts.light)
                    }
                }
            } label: {
                VStack(spacing: 5) {
                    HStack {
                        Text(value ?? "Medium")
                            .foregroundColor(.black)
                            .font(ConstantClass.AppFonts.light)
                            .padding(.leading, 5)
                            .padding(.trailing, 5)

                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(Color.gray)
                            .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                    }
                    
                }
            }
        }
        .frame(width:ConstantClass.Emptytextfield.width, height: ConstantClass.Emptytextfield.height)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
    
}



struct TextView: UIViewRepresentable {
    @Binding var text: String
    @Binding var textStyle: UIFont.TextStyle

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        
        // Set initial text and font
        textView.text = text
        textView.font = UIFont.preferredFont(forTextStyle: textStyle)
        
        // Configure keyboard type and appearance
        textView.returnKeyType = .done
        textView.keyboardAppearance = .default
        
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        // Update text and font if they change
        uiView.text = text
        uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func textViewDidChange(_ textView: UITextView) {
            // Update the binding when the text changes
            text = textView.text
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" {
                textView.resignFirstResponder() // Dismiss keyboard when return key is pressed
                return false
            }
            return true
        }
    }
}

#Preview {
    SuperCreateNewTask()
}
