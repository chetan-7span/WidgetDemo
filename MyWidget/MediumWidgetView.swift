//
//  MediumWidgetView.swift
//  MyWidgetExtension
//
//  Created by Chetan Hedamba on 09/01/25.
//

import SwiftUI

struct MediumWidgetView: View {
    var entry: Provider.Entry
    var body: some View {
        VStack(alignment: .leading) {
            Text(entry.date, style: .time).font(.title2).foregroundColor(.black)
            ForEach(entry.post) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
            }
        }
    }
}
