//
//  PostModel.swift
//  ApiDemoSwiftUI
//
//  Created by Chetan Hedamba on 08/01/25.
//

import Foundation

struct Post: Decodable, Identifiable,Equatable {
    let id: Int
    let title: String
    let body: String
}


