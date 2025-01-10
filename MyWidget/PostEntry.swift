//
//  PostEntry.swift
//  MyWidgetExtension
//
//  Created by Chetan Hedamba on 09/01/25.
//

import WidgetKit

struct PostEntry: TimelineEntry {
    let date: Date
    let post: [Post]
    static func mockPostEntry() -> PostEntry {
        PostEntry (date: Date(), post: [Post.init(id: 1, title: "Post Title Text", body: "Post's Descrption")])
    }
}
