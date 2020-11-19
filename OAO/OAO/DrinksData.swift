//
//  DrinkData.swift
//  OAO
//
//  Created by User17 on 2020/11/17.
//

import SwiftUI
class DrinksData: ObservableObject{
    @AppStorage("drinks") var drinksData: Data?
    @Published var total = 0
    func caculateTotal(){
        total = 0
        for drink in drinks {
            total = total + drink.volume
        }
    }
    init(){
        if let drinksData = drinksData{
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([EAT].self, from: drinksData){
                drinks = decodedData
                for drink in drinks {
                    total = total + drink.volume
                }
            }
        }
        
        
    }
    @Published var drinks = [EAT](){
        didSet{
            let encoder = JSONEncoder()
            do{
                let data = try encoder.encode(drinks)
                drinksData = data
                
            }catch{
                
            }
        }
    }
}
