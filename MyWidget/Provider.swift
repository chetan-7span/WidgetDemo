//
//  Provider.swift
//  MyWidgetExtension
//
//  Created by Chetan Hedamba on 09/01/25.
//

import WidgetKit

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> PostEntry {
        PostEntry.mockPostEntry()
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> PostEntry {
        PostEntry.mockPostEntry()
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<PostEntry> {
        var arrPosts: [PostEntry] = []
        let currentDate = Date()
        let url = "https://jsonplaceholder.typicode.com/posts?_page=\(1)&_limit=\(3)"
        
        do {
            // Use the async request
            let posts: [Post] = try await APIManager.shared.requestAsync(url: url)
            
            let entry = PostEntry(date: currentDate, post: posts)
            arrPosts.append(entry)
        } catch {
            print("Failed to fetch posts: \(error.localizedDescription)")
        }
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 60, to: currentDate)!
        
        let timeline = Timeline(entries: arrPosts, policy: .after(refreshDate))
        return timeline
    }
}
