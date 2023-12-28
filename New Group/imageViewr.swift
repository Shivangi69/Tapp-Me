import SwiftUI

struct ImageViewer: View {
    let imageUrls: [String]
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
//            GeometryReader { geometry in
//                ScrollView(.horizontal, showsIndicators: true) {
//                    HStack(spacing: 0) {
//                        ForEach(imageUrls, id: \.self) { imageUrl in
//                            AsyncImage(url: URL(string: imageUrl)!) { phase in
//                                switch phase {
//                                    case .success(let image):
//                                        image
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fit)
//                                            .frame(width: geometry.size.width)
//                                            .padding()
//                                    case .failure:
//                                        // Placeholder or error handling image
//                                        Image(systemName: "photo")
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fit)
//                                            .frame(width: geometry.size.width)
//                                            .padding()
//                                }
//                            }
//                        }
//                    }
//                }
//                .edgesIgnoringSafeArea(.all)
//            }
            
            VStack{
                PhotoSliderView1(imageUrls: imageUrls)
           .frame(width: Responsiveframes.widthPercentageToDP(90))

            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                Button(action: {
                    // Dismiss the view
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                }
            )
        }
    }
}

struct ImageViewer2: View {
    let imageUrls: [String]
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 20) {
                    PhotoSliderView2(imageUrls: imageUrls)
                }
                .padding()
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                Button(action: {
                    // Dismiss the view
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                }
            )
        }
    }
}
