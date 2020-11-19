//
//  EAT.swift
//  OAO
//
//  Created by User17 on 2020/11/17.
//


import Foundation
struct EAT: Identifiable, Codable{
    var id = UUID()
    var note: String
    var volume: Int
    var time: String
}
