//
//  MusicModel.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 11/19/23.
//

import Foundation

struct MusicData: Decodable {
    let data: [Data]
}

struct Data: Decodable{
    let title: String
//    let duration: Int
    let preview: String
    
}
