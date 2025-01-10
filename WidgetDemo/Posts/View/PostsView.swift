//
//  PostView.swift
//  ApiDemoSwiftUI
//
//  Created by Chetan Hedamba on 08/01/25.
//

import SwiftUI

struct PostsView: View {
    @StateObject private var viewModel = PostsViewModel() // Initialize the ViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                PostsListView(viewModel: viewModel)
                    .navigationTitle("Posts")
                    .onAppear {
                        viewModel.fetchPosts()
                    }
                    .alert(item: $viewModel.alertMessage) { alert in
                        Alert(
                            title: Text("Error"),
                            message: Text(alert.message),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                
                LoadingOverlayView(isLoading: viewModel.isLoading)
                LoadingPaginationView(isLoadingMore: viewModel.isLoadingMore)
            }
        }
    }
}

struct PostsListView: View {
    @ObservedObject var viewModel: PostsViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .onAppear {
                    if post == viewModel.posts.last {
                        viewModel.fetchPosts(isLoadingMore: true)
                    }
                }
            }
        }
    }
}

struct LoadingOverlayView: View {
    var isLoading: Bool
    
    var body: some View {
        if isLoading {
            Color.black.opacity(0.4) // Semi-transparent overlay
                .ignoresSafeArea()
            ProgressView("Loading...")
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
        }
    }
}

struct LoadingPaginationView: View {
    var isLoadingMore: Bool
    
    var body: some View {
        if isLoadingMore {
            HStack {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
    }
}



#Preview {
    PostsView()
}
