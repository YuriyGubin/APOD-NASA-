//
//  Picture.swift
//  APOD(NASA)
//
//  Created by Yuriy on 24.02.2023.
//

import Foundation
// API Key = 2wFOs9LvwMlowZyKVWTkM5rTKwpA6GtjDwE72YUa

struct Picture: Decodable {
    let copyright: String
    let date: String
    let explanation: String
    let hdurl: String
    let title: String
    let url: String
}
