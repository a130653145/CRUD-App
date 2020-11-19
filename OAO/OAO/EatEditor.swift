//
//  EatEditor.swift
//  OAO
//
//  Created by User17 on 2020/11/17.
//


import SwiftUI

struct EatEditor: View {
    @Environment(\.presentationMode) var presentationMode
    var drinksData: DrinksData
    var editDrinkIndex: Int?
    @State private var note = ""
    @State private var volume = 0
    @State private var time = ""
    var body: some View {
        
        Form{
            TextField("註記 早／中／晚 餐 或 菜名", text: $note)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Stepper(value: $volume, in: 0...10000, step: 10){
                Text("目前：\(volume) kcal \n（按一下+-10kcal）")
               
            }
          
            Stepper(value: $volume, in: 0...10000, step: 50){
                Text("目前：\(volume) kcal \n（按一下+-50kcal）")
               
            }
            
            Stepper(value: $volume, in: 0...10000, step: 100){
                Text("目前：\(volume) kcal \n（按一下+-100kcal）")
               
            }
            
            TextField("time 00:00", text: $time)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .onAppear(perform: {
            if let editDrinkIndex = editDrinkIndex{
                let editDrink = drinksData.drinks[editDrinkIndex]
                note = editDrink.note
                volume = editDrink.volume
                time = editDrink.time
            }
        })
        .navigationBarTitle(editDrinkIndex == nil ? "Add New Eat": "Edit eat")
        .toolbar(content:{
            Button("Save"){
                let drink = EAT(note: note, volume: volume, time: time)
                if let editDrinkIndex = editDrinkIndex{
                    drinksData.total = drinksData.total - drinksData.drinks[editDrinkIndex].volume + drink.volume
                    drinksData.drinks[editDrinkIndex] = drink
                    
                }
                else{
                    drinksData.drinks.insert(drink, at: drinksData.drinks.endIndex)
                    drinksData.total = drinksData.total + drink.volume
                }
                presentationMode.wrappedValue.dismiss()
            }
        })
        
    }
}

struct EatEditor_Previews: PreviewProvider {
    static var previews: some View {
        EatEditor(drinksData: DrinksData())
    }
}
