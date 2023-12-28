//
//  WorkerHoursHistory.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 10/01/24.
//

import SwiftUI

struct WorkerHoursHistory: View {
    
    @State private var mainview = false
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var gettimeobs = SupertimesheetVM()
    
    @State var showcompanypicker: Bool = false
    @State var CompanyName : String? = nil
    
    @State var selectedYear: Int?
    @State var selectedMonth: Int?
    @State var showPicker: Bool
    
    

    var body: some View {
        
        NavigationView{
        ZStack {
            GeometryReader { geometry in
       
                    
                    VStack(spacing:20.0){
                        
                        HStack{
                            
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                                
                            })
                            {
                                Image("Arrow Left-8")
                                    .frame(width: Responsiveframes.widthPercentageToDP(8), height: Responsiveframes.heightPercentageToDP(8))
                                
                                
                            }
                            
                            Text("Hours History")
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                                .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.5)))
                            
                            Spacer()
                            
                            
                            filterofweek(value: $CompanyName,
                                showCompanyPicker: $showcompanypicker,
                                onChange: {
                                if CompanyName == "Yesterday" {
                                    gettimeobs.filter = "Yesterday"
                                    gettimeobs.Getallhours()
                                    
                                }
                                else if CompanyName == "This Week" {
                                  
                                    gettimeobs.filter = "ThisWeek"
                                    gettimeobs.Getallhours()
                                }
                                
                                else if CompanyName == "Last Week" {
                           
                                    gettimeobs.filter = "LastWeek"
                                    gettimeobs.Getallhours()
                                }
                                else if CompanyName == "This Month" {
                          
                                    gettimeobs.filter = "ThisMonth"
                                    gettimeobs.Getallhours()
                                }
                                
                                else if CompanyName == "Last Month" {
                                    gettimeobs.filter = "LastMonth"
                                    gettimeobs.Getallhours()
                                }
                       })
                        }
                        .frame(width: Responsiveframes.widthPercentageToDP(90))
                        
                        
                        ScrollView(.vertical, showsIndicators: false){
                            
                            VStack(spacing:20.0){
                            VStack(alignment: .leading){
                                HStack{
                                    
                                    Image("Ellipse 1098")
                                    
                                    
                                    Text("Normal Working Hours")
                                        .lineLimit(1)
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.gray)
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                    
                                    Spacer()
                                }
                                HStack{
                                    
                                    Image("Ellipse 1099")
                                    
                                    Text("Overtime Working Hours")
                                        .lineLimit(1)
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.gray)
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                    
                                    Spacer()
                                    
                                    
                                }
                            }
                            .frame(width: Responsiveframes.widthPercentageToDP(90))
                            
                            
                            
                            HStack{
                                Text("Total working hours:")
                                    .lineLimit(1)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.gray)
                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                
                                Text (String(gettimeobs.totalhrs?.hours ?? 0) + " Hours " +  String(gettimeobs.totalhrs?.minutes ?? 0) + " Minutes" )
                                    .lineLimit(1)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.accentColor)
                                    .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                                
                                Spacer()
                            }
                            .frame(width: Responsiveframes.widthPercentageToDP(90))
                            
                            
                            
                            //    ZStack(alignment: .center){
                            //
                            //                        VStack {
                            //                            if let percentageString = gettimeobs.normaltime?.percentage,
                            //                               let percentageFloat = Float(percentageString) {
                            //                                let progress: CGFloat = CGFloat(percentageFloat / 100.0) // Divide by 100.0 to convert to percentage
                            //
                            //                                PieChart(progress: progress)
                            //                                    .frame(width: 150, height: 150)
                            //                            } else {
                            //                                // Handle the case where percentageString is nil or cannot be converted to Float
                            //                                Text("Invalid percentage")
                            //                            }
                            //                        }
                            
                            Spacer()
                            
                            ZStack {
                                if let normalTimePercentageString = gettimeobs.normaltime?.percentage,
                                   let normalTimePercentageFloat = Float(normalTimePercentageString),
                                   let overTimePercentageString = gettimeobs.overtime?.percentage,
                                   let overTimePercentageFloat = Float(overTimePercentageString) {
                                    
                                    let normalTimeProgress: CGFloat = CGFloat(normalTimePercentageFloat / 100.0)
                                    let overTimeProgress: CGFloat = CGFloat(overTimePercentageFloat / 100.0)
                                    
                                    PieChart(normalTimeProgress: normalTimeProgress, overTimeProgress: overTimeProgress)
                                    
                                   .frame(width: 180, height: 180)
                                }
                                
                                
                                
                                else {
                                    PieChart(normalTimeProgress: 0, overTimeProgress: 0)

                                }
                            }
                            
                            
                            Spacer()
                            
                            //   }
                            
                            VStack(spacing: 10){
                                HStack{
                                    Text("Working hours Overview")
                                        .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(2.0)))
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                .frame(width: Responsiveframes.widthPercentageToDP(90))
                                
                                
                                VStack(spacing: 0) {
                                    HStack(spacing: 0) {
                                        CellView(text: "", width: UIScreen.main.bounds.width/3)
                                        CellView(text: "Normal", width: UIScreen.main.bounds.width/3)
                                        CellView(text: "Overtime", width: UIScreen.main.bounds.width/3)
                                    }
                                    
                                    HStack(spacing: 0) {
                                        CellView(text: "Total hours worker", width: UIScreen.main.bounds.width/3)
                                        
                                        let normatimestr = String(gettimeobs.normaltime?.hours ?? 0) + " Hours " +
                                        String(gettimeobs.normaltime?.minutes ?? 0) + " Minutes"
                                        
                                        let overtimestr = String(gettimeobs.overtime?.hours ?? 0 ) + " Hours " + String(gettimeobs.overtime?.minutes ?? 0) + " Minutes"
                                        
                                        CellView(text:  normatimestr , width: UIScreen.main.bounds.width/3)
                                        CellView(text: overtimestr, width: UIScreen.main.bounds.width/3)
                                    }
                                }
                                //                                  .frame(width: UIScreen.main.bounds.width)
                                
                                
                                .frame(width: Responsiveframes.widthPercentageToDP(30))
                                
                                
                                Spacer()
                                
                                
                            }
                        }
                    }
                    
                }
              .frame(width: min(geometry.size.width, geometry.size.height), height: max(geometry.size.width, geometry.size.height))
            }
        }
            
            
        .onAppear(){
            
            
            gettimeobs.filter = "Yesterday"
            gettimeobs.Getallhours()
            
            
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    
        }
        .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            
    }
}



struct PieChart: View {
    var normalTimeProgress: CGFloat
    var overTimeProgress: CGFloat
    
    var body: some View {
        
        
        
            ZStack {
                // Outer circle for normal time progress
                Circle()
                    .trim(from: 0, to: 1) // Full circle
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)
                
                // Progress circle for normal time
                Circle()
                    .trim(from: 0, to: normalTimeProgress)
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.blue)
                    .rotationEffect(Angle(degrees: -90))
                
                //    Text showing normal time progress percentage
                //            Text(String(format: "%.0f%%", normalTimeProgress * 100))
                //                .font(.headline)
                //
                
                Text("Working Hours")
                    .font(.headline)
                
                
            }
            .frame(width: 200, height: 200)
            .padding()
            
            
//            
//            Text(String(format: "%.0f%%", normalTimeProgress * 100))
//                  .font(.headline)

            
        
        
        
        ZStack{
            // Inner circle for overtime progress
            Circle()
                .trim(from: 0, to: 1) // Full circle
                .stroke(lineWidth: 6) // Adjust the lineWidth as needed
                .opacity(0.3)
                .foregroundColor(Color.gray)
            
            // Progress circle for overtime
            Circle()
                .trim(from: 0, to: overTimeProgress)
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round)) // Adjust the lineWidth as needed
                .foregroundColor(Color.lightorange) // Adjust the color as needed
                .rotationEffect(Angle(degrees: -90))
            
            // Text showing overtime progress percentage
//            Text(String(format: "%.0f%%", overTimeProgress * 100))
//                .font(.headline)
        }
        .frame(width: 170, height: 170)

//        .aspectRatio(contentMode: .fit)
      .padding()
    }
}

//
//struct PieChart: View {
//    
//    var progress: CGFloat
//    
//    var body: some View {
//        
//        ZStack{
//        ZStack {
//            Circle()
//                .stroke(lineWidth: 10)
//                .opacity(0.3)
//                .foregroundColor(Color.gray)
//            
//            Circle()
//                .trim(from: 0, to: progress)
//                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//                .foregroundColor(Color.blue)
//                .rotationEffect(Angle(degrees: -90))
//            
//            Text(String(format: "%.0f%%", progress * 100))
//                .font(.headline)
//        }
//        
//        
//        
//        
//        
//        ZStack {
//            Circle()
//                .stroke(lineWidth: 10)
//                .opacity(0.3)
//                .foregroundColor(Color.gray)
//            
//            Circle()
//                .trim(from: 0, to: progress)
//                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//                .foregroundColor(Color.blue)
//                .rotationEffect(Angle(degrees: -90))
//            
//            Text(String(format: "%.0f%%", progress * 100))
//                .font(.headline)
//        }
//    }
//        
//        
//        
//        
//    }
//}

struct TableCell: View {
    var text: String
    
    var body: some View {
        Text(text)
            .padding()
            .border(Color.black, width: 1) // Add cell border
    }
}




struct filterofweek: View {
    
    
    @Binding var value: String?
    @State var value1 = ""
    @Binding var showCompanyPicker: Bool

    
    let typetasklist = ["Yesterday", "This Week", "Last Week", "This Month", "Last Month"]
    var placeholder = "Yesterday"
    
    var onChange: (() -> Void)? // Callback function to notify parent
    
    var body: some View {
        
        HStack {
            Menu {
                ForEach(typetasklist, id: \.self) { company in
                    Button(action: {
                        self.value1 = company
                        self.value = company
                        self.showCompanyPicker.toggle()
                        onChange?() // Invoke callback
                        
                    }) {
                        Text(company)
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                            .foregroundColor(Color.blue) // Set text color to blue
                    }
                }
            } label: {
                VStack{
                    HStack {
                        Text(value1.isEmpty ? placeholder : value1)
                            .foregroundColor(value1.isEmpty ? .gray : .gray) // Set text color to blue
                            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))
                            .padding(.leading, 10)
                            .lineLimit(1)
                        Spacer()
                        Image("Alt Arrow Down-7")
                            .resizable()
                            .foregroundColor(.gray) // Set arrow color to blue
                            .frame(width: Responsiveframes.heightPercentageToDP(3), height: Responsiveframes.heightPercentageToDP(3))
                            .padding()
                        
                    }
                    // .padding()
                    
                }
            }
        }
        .frame(width: Responsiveframes.widthPercentageToDP(35), height: Responsiveframes.heightPercentageToDP(5))
        
        .background(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray, lineWidth: 1) // Set border color to blue
        )
    }
}



struct CellView: View {
    var text: String
    var width: CGFloat
    
    var body: some View {
        
        Text(text)
            .font(Font.custom("Poppins-Black", size: Responsiveframes.responsiveFontSize(1.6)))

            .frame(width: Responsiveframes.widthPercentageToDP(20), height: Responsiveframes.heightPercentageToDP(6))
            .padding()
            .border(Color.black)
    }
}


//.
