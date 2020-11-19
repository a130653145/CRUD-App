//
//  eat_row_note.swift
//  OAO
//
//  Created by User17 on 2020/11/17.
//

import SwiftUI

struct eat_row_note: View {
    var drink: EAT
    var body: some View {
        HStack{
            
            Text(drink.note)
            Text("\(drink.time)")
            Text("\(drink.volume)kcal")
            
            
        }
    }
}

struct eat_row_note_Previews: PreviewProvider {
    static var previews: some View {
        eat_row_note(drink: EAT(note: "早餐", volume: 200, time: "13:00"))
    }
}
