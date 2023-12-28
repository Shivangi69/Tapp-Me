////
////  RefreshScrollview.swift
////  Tapp Me
////
////  Created by Rohit wadhwa on 06/06/24.


import SwiftUI

struct RefreshScrollview<Content: View>: UIViewRepresentable {
    let content: () -> Content
    let onRefresh: () -> Void
    
    init(@ViewBuilder content: @escaping () -> Content, onRefresh: @escaping () -> Void) {
        self.content = content
        self.onRefresh = onRefresh
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(context.coordinator, action: #selector(Coordinator.handleRefresh), for: .valueChanged)
        scrollView.refreshControl = refreshControl
        
        let hostingController = UIHostingController(rootView: content())
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostingController.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        if let hostingController = uiView.subviews.first(where: { $0 is UIHostingController<Content>.Type }) as? UIHostingController<Content> {
            hostingController.rootView = content()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onRefresh: onRefresh)
    }
    
    class Coordinator: NSObject {
        let onRefresh: () -> Void
        
        init(onRefresh: @escaping () -> Void) {
            self.onRefresh = onRefresh
        }
        
        @objc func handleRefresh(_ sender: UIRefreshControl) {
            onRefresh()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                sender.endRefreshing()
            }
        }
    }
}
