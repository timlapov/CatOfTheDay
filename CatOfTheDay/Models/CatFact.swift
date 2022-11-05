//
//  CatFact.swift
//  CatOfTheDay
//
//  Created by Artem Lapov on 05.11.2022.
//

struct Cat {
    let catImageUrl: String
}

struct Fact: Decodable {
    let data: [String]
}
