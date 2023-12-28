//
//  WorkerList.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 17/01/24.
//

import SwiftUI

struct WorkerList: View {

    @Environment(\.presentationMode) var presentationMode
    
    @State var showcompanypicker: Bool = false
    @State var CompanyName : String? = nil
    @State private var searchText = ""
    @State  var keyboardHeight: CGFloat = 0
    @StateObject var obs = workerassigntaskVM()

    @State private var showTasks = false
    
    @State var taskIndex = Int()

    @State private var mainview = false
    @ObservedObject private var keyboard = KeyboardResponder()

    var body: some View {
        NavigationView{

        ZStack {
            GeometryReader { geometry in
                
                    
                    VStack(spacing:0){
                        HStack(spacing:10){

                            Text("Workers")
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                                .foregroundColor(Color.black)
                            
                            Spacer()
//                        workerliststatus(value: $CompanyName, showCompanyPicker: $showcompanypicker)
//                           // .animation(.linear)
//                            .transition(.opacity)
//                            .frame(width: Responsiveframes.widthPercentageToDP(30), height: Responsiveframes.heightPercentageToDP(5))

                        }
                
                        .frame(width: Responsiveframes.widthPercentageToDP(90))
                        
                        
                        VStack{
                            
                            SearchBarView1(searchText: $obs.filtername)
                        }
                       
                        
                        
                        ScrollView(.vertical , showsIndicators: false){
                        VStack{
                            
                            ForEach(Array(obs.workerTaskassignModel.enumerated()).filter { _, taskassign in
                                return taskassign.employeeId.lowercased().contains(obs.filtername) ||
                                    taskassign.name.lowercased().contains(obs.filtername.lowercased()) ||
                                    obs.filtername.isEmpty
                            }, id: \.element) { index, taskassign in
                       //      WorkerListCell()
                    
                                    VStack {
                                        
                                        HStack {
                                            HStack {
                                                Text(taskassign.name)
                                                    .fontWeight(.semibold)
                                                    .lineLimit(1)
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                                    .foregroundColor(Color.black)
                                                    .multilineTextAlignment(.leading)
                                                
                                                Spacer()
                                                
                                                
                                                HStack(alignment: .center) {
                                                    Text("#" + taskassign.employeeId )
                                                        .lineLimit(1)
                                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.4)))                         .multilineTextAlignment(.center)
                                                        .foregroundColor(.white)
                                                        .frame(width: Responsiveframes.widthPercentageToDP(20))

                                                }
                                                .padding(6)
                                                .background(Color.lightblue)
                                                
                                            }
                                            
                                            
                                            Button(action: {
                                                // Add action for the button here
                                                self.taskIndex = index

                                                mainview.toggle()
                                            }) {
                                                Text("View Details")
                                                    .lineLimit(1)
                                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(.lightblue)
                                                    .padding(6)
                                                    .background(Color.white)
                                                    .cornerRadius(8) 
                                                    .frame(width: Responsiveframes.widthPercentageToDP(30))
// Add corner radius to mimic button style
                                            }
                                            .onTapGesture {
                                                self.taskIndex = index

                                                mainview.toggle()
                                            }
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color.lightblue, lineWidth: 1)
                                            )
                                            
                                            
                                            
                                            
                                        //    NavigationLink(destination: WorkerViewTasklist(), isActive: $mainview) { EmptyView() }
                                            
                                            if (obs.workerTaskassignModel.count>0){
                                                NavigationLink(destination: WorkerViewTasklist(reportidmodeldata: obs.workerTaskassignModel[self.taskIndex]), isActive: $mainview) {
                                                    EmptyView()
                                                }
                                                
                                            }
                                            
                                            
                                        }
                                        .padding()
                                        .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(9))
                                        .background(Color.white)
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.gray.opacity(0.17), lineWidth: 1)
                                        )
                                        
                                    }
                                    
                             //    .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 2, y: 2)

                                
                            }
                            
                        }
                        
                    }
                }
                      .edgesIgnoringSafeArea(.bottom)
                   
                
              //  .frame(width: min(geometry.size.width, geometry.size.height))
         }
        }
            
            
        .onAppear() {
            obs.Getworkerlistwithfilter()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)

        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)

    }
   
}




//struct SearchBarView: View {
//    @Binding var searchText: String
//    @State private var showCancelButton: Bool = false
//    var onCommit: () -> Void = { print("onCommit") }
//
//    var body: some View {
//        VStack {
//            HStack {
//                HStack {
//                    Image("xmark.circle.fill")
//                    ZStack(alignment: .leading) {
//                        if searchText.isEmpty {
//                            Text("Search Worker by ID or Name...")
//                                .foregroundColor(.gray)
//                                .padding(.horizontal, 8)
//                        }
//                        
//                        // Move the TextField outside the conditional block
//                        TextField("", text: $searchText, onEditingChanged: { isEditing in
//                            self.showCancelButton = true
//                        }, onCommit: onCommit)
//                        .foregroundColor(.gray)
//                        .padding(.horizontal, 8)
//                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                    }
//                    
//                    // Clear button
//                    Button(action: {
//                        self.searchText = ""
//                    }) {
//                        Image(systemName: "xmark.circle.fill")
//                            .opacity(searchText == "" ? 0 : 1)
//                    }
//                }
//                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
//                .background(Color.white)
//                .cornerRadius(10.0)
//                .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 2)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10.0)
//                        .stroke(Color.gray, lineWidth: 0.5)
//                )
//                 .frame(width: Responsiveframes.widthPercentageToDP(90), height: Responsiveframes.heightPercentageToDP(10))
////                .padding(.horizontal, 27)
//           
//            }
//            .padding(.horizontal)
//          .edgesIgnoringSafeArea(.bottom)
//        }
//    }
//
//    private func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}



struct workerliststatus: View {

    @Binding var value: String?
    @State var value1 = ""
    @Binding var showCompanyPicker: Bool
    
    let typetasklist = ["All", "Absent", "Out for Work" , "Checked-in" , "Checked-out" , "Break"]
    var placeholder = "All"
    
    var body: some View {
        
        HStack {
            Menu {
                ForEach(typetasklist, id: \.self) { company in
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
                           .padding(.leading, 10)
                           // .lineLimit(1)
                        Spacer()
                        Image("Alt Arrow Down")
                        .foregroundColor(.blue) // Set arrow color to blue
                       .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                       .padding(.trailing, 2)

                    }
                    
                   // .padding()
                    
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
WorkerList()
}
