//
//  MyWidget.swift
//  MyWidget
//
//  Created by Chetan Hedamba on 09/01/25.
//

import WidgetKit
import SwiftUI


struct MyWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    var body: some View {
        ZStack{
            Color(.brown).cornerRadius(12)
            switch family {
            case .systemSmall:
                smallSizeWidget
            default:
                MediumWidgetView(entry: entry)
            }
        }
    }
    
    @ViewBuilder
    var smallSizeWidget: some View {
        VStack(alignment: .leading) {
            Text(entry.date, style: .time).font(.title2).foregroundColor(.black)
            Text(entry.post.first?.title ?? "Title")
                .font(.headline)
            Text(entry.post.first?.body ?? "Body")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct MyWidget: Widget {
    let kind: String = "MyWidget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, provider: Provider()) { entry in
            MyWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

#Preview(as: .systemSmall) {
    MyWidget()
} timeline: {
    PostEntry.mockPostEntry()
    
}
