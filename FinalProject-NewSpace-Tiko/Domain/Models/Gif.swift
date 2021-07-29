//
//  Gif.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 22.07.21.
//

import Foundation

struct GifData: Codable {
    let data: [InsideGifData]
}

struct InsideGifData: Codable {
    let type : String
    let images: Images
}

struct Images: Codable {
    let fixed_height: InsditeFixHeight
}

struct InsditeFixHeight: Codable {
     let url : String?
}

struct GifsList {
    let type: String?
//    let gif: FLAnimatedImage?
}
