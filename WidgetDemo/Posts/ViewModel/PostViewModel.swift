//
//  PostViewModel.swift
//  ApiDemoSwiftUI
//
//  Created by Chetan Hedamba on 08/01/25.
//

import Foundation

class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = [] // Holds the list of posts
    @Published var alertMessage: AlertMessage? // For handling alerts
    @Published var isLoading: Bool = false // Tracks initial loading state
    @Published var isLoadingMore: Bool = false // Tracks loading state for pagination
    
    private var currentPage = 1 // Tracks the current page
    private let pageSize = 10 // Number of items per page
    private var isLastPage = false // Tracks if the last page is reached

    /// Fetch posts (handles both initial load and pagination)
    func fetchPosts(isLoadingMore: Bool = false) {
        guard !isLoading else { return }

        if isLoadingMore {
            self.isLoadingMore = true
        } else {
            self.isLoading = true
        }
        
        let url = "https://jsonplaceholder.typicode.com/posts?_page=\(currentPage)&_limit=\(pageSize)"
        
        APIManager.shared.request(url: url) { (result: Result<[Post], Error>) in
            DispatchQueue.main.async {
                if isLoadingMore {
                    self.isLoadingMore = false
                } else {
                    self.isLoading = false
                }

                switch result {
                case .success(let newPosts):
                    if newPosts.count < self.pageSize {
                        self.isLastPage = true // No more data to load
                    }
                    self.posts.append(contentsOf: newPosts)
                    self.currentPage += 1 // Increment the page
                    print(self.posts.count)
                    print(self.currentPage)
                case .failure(let error):
                    self.alertMessage = AlertMessage(message: error.localizedDescription)
                }
            }
        }
    }
}


struct AlertMessage: Identifiable {
    let id = UUID()
    let message: String
}
