//
//  EmptyView.swift
//  Tapp Me
//
//  Created by Rohit wadhwa on 16/02/24.
//

import SwiftUI

struct EmptyListView: View {
    let screenName: String
    
    var body: some View {
        
        var emptyText: String {
            switch screenName {
            case "SuperWorkerRequest":
                return "Check in Request List Not Available"
            case "supertasklist":
                return "Task List Not Available"
            case "TimeSheet":
                return "Timesheet Not Available"
            case "WorkersubmittedReport":
                return "Worker submitted Report Not Available"
                
            case "WorkersubmittedReport":
                return "Worker submitted Report Not Available"
                
            case "supervisorsubmittedReport":
                return "Report Not Available"
          
            case "timsheet":
                return "Report Not Available"
         
           
                
                
                // Add more cases as needed
            default:
                return "No record(s) found."
            }
        }
        
        
        VStack {
            Image(systemName: "info.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.yellow)
            
            Text("No record(s) found.")
                .font(.headline)
                .foregroundColor(.gray)
        }
        .padding()
        
    }
}
//    struct EmptyListView_Previews: PreviewProvider {
//        static var previews: some View {
//            EmptyListView(screenName: "")
//        }
//    }
#Preview {
    EmptyListView(screenName: "")
}
