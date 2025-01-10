//
//  MyWidgetBundle.swift
//  MyWidget
//
//  Created by Chetan Hedamba on 09/01/25.
//

import WidgetKit
import SwiftUI

@main
struct MyWidgetBundle: WidgetBundle {
    var body: some Widget {
        MyWidget()
        MyWidgetControl()
        MyWidgetLiveActivity()
    }
}
