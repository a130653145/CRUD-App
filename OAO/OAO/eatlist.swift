//
//  eatlist.swift
//  OAO
//
//  Created by User17 on 2020/11/17.
//

import SwiftUI
func caculate(target: Int, num: Int) -> Double{
    return Double(num)/Double(target)
}

struct eatlist: View {
    @StateObject var drinksData = DrinksData()
    @State private var showEditDrink = false
    let target = 2000
    
    let pictures = ["長條圖","圓餅圖"]
    @State private var selectPicture = "長條圖"
   
    
    
    var body: some View {
        
        NavigationView{
           
                VStack{
                    
                        VStack(alignment: .leading) {
                            Picker("換圖", selection: $selectPicture) {
                                ForEach(pictures, id: \.self) { (picture) in
                                    Text(picture)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    
                    
                    ZStack{
                        if selectPicture == "長條圖"
                        {
                            if drinksData.total < 1600
                            {
                                
                                
                                
                                
                                Rectangle()  //色快
                                    .opacity(0.3)
                                    .foregroundColor(.green)
                                    .frame(width: 250, height: CGFloat(caculate(target: target, num: drinksData.total)*250))
                                    .offset(x: 0, y: (250-(CGFloat(caculate(target: target, num: drinksData.total)*250)))/2)
                                
                                Rectangle() //框框和中間的字
                                    .stroke(Color.black, lineWidth: 10)
                                    .overlay(
                                                Text("\(Int(caculate(target: target, num: drinksData.total)*100))%")
                                                    .font(.largeTitle)
                                                    .foregroundColor(.black)
                                                    .padding(40)
                                
                                            )
                                
                            }
                            else if drinksData.total <= 2000
                            {
                                
                                
                                
                                Rectangle()  //色快
                                    .opacity(0.3)
                                    .foregroundColor(.red)
                                    .frame(width: 250, height: CGFloat(caculate(target: target, num: drinksData.total)*250))
                                    .offset(x: 0, y: (250-(CGFloat(caculate(target: target, num: drinksData.total)*250)))/2)
                                
                                Rectangle() //框框和中間的字
                                    .stroke(Color.black, lineWidth: 10)
                                    .overlay(
                                                
                                                Text("該注意熱量啦")
                                                    .font(.largeTitle)
                                                    .foregroundColor(.black)
                                                    .offset(x: 0, y: -40)
                                
                                            )
                                    .overlay(
                                                
                                        
                                                Text("\(Int(caculate(target: target, num: drinksData.total)*100))%")
                                                    .font(.largeTitle)
                                                    .foregroundColor(.black)
                                                    .padding(40)
                                        
                                                    
                                
                                            )
                                
                                
                            }
                            else if drinksData.total > 2000
                            {
                                
                                
                                
                                Rectangle() //色塊
                                    .opacity(0.7)
                                    .foregroundColor(.red)
                                    .frame(width: 250, height: 250)
                                    
                                
                                Rectangle() //框框和中間的字
                                    .stroke(Color.black, lineWidth: 10)
                                    .overlay(
                                                
                                                Text("熱量爆炸啦")
                                                    .font(.largeTitle)
                                                    .foregroundColor(.black)
                                                    
                                                    .offset(x: 0, y: -40)
                                
                                            )
                                    .overlay(
                                                
                                                Text("\(Int(caculate(target: target, num: drinksData.total)*100))%")
                                                    .font(.largeTitle)
                                                    .foregroundColor(.black)
                                                    .padding(40)
                                
                                            )
                                    
                            }                        }
                        if selectPicture == "圓餅圖"
                        {
                            
                        
                        
                            Circle() //圓餅底圖
                                .stroke(Color.gray, lineWidth: 10)
                                .opacity(0.2)
                                .overlay(
                                    Text("\(Int(caculate(target: target, num: drinksData.total)*100))%")
                                        .font(.largeTitle)
                                        .foregroundColor(.black)
                                        .padding(40)
                                )
                            
                            if caculate(target: target, num:  drinksData.total)*100 > 80 //畫圖８０％以上
                            {
                                Circle()
                                    .trim(from: 0, to: CGFloat(caculate(target: target, num: drinksData.total)))
                                    .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                                    .rotationEffect(.degrees(-90))
                                    
                                    .overlay(
                                                
                                                Text("該注意熱量啦")
                                                    .font(.largeTitle)
                                                    .foregroundColor(.black)
                                                    .offset(x: 0, y: -40)
                                
                                            )
                                    
                            }
                            else //畫圖８０％以下
                            {
                                Circle()
                                    .trim(from: 0, to: CGFloat(caculate(target: target, num: drinksData.total)))
                                    .stroke(Color.green, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                                    .rotationEffect(.degrees(-90))
                                    
                            }
                            
                        }
                        
                        
                    }//zstack
                    .frame(width: 250, height: 250, alignment: .center)
                    
                    
                    Text("目前／建議上限：\(drinksData.total)kcal／\(target)kcal")
                    
                    if drinksData.total<=2000
                    {
                        Text("剩餘\(target-drinksData.total)kcal")
                    }
                    else if drinksData.total > 2000
                    {
                        Text("已超過\(-(target-drinksData.total))kcal")
                    }
                    
                    List{
                        
                        Section(header:Text("今天吃下的東西熱量清單")){
                            ForEach(drinksData.drinks.indices, id : \.self){(index) in
                                NavigationLink(destination:EatEditor(drinksData: drinksData, editDrinkIndex: index)){
                                    eat_row_note(drink: drinksData.drinks[index])
                                        
                                }
                                
                            }
                            .onDelete{(indexSet) in
                                drinksData.drinks.remove(atOffsets: indexSet)
                                drinksData.caculateTotal()
                            }
                        }
                        
                       
                        
                    }
                
               
                    
                    /*.navigationBarTitle("目標:\(target)ml")*/
                    .navigationBarTitle("飲食和熱量")
                    .toolbar(content: {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                showEditDrink = true
                                
                            }, label: {
                                Image(systemName: "plus.circle.fill")
                                Text("新增一項紀錄")
                                Image(systemName: "plus.circle.fill")
                                })
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            EditButton()
                        }
                    })
                    .sheet(isPresented:$showEditDrink){
                        NavigationView{
                            EatEditor(drinksData: drinksData)
                        }
                    }
                    
                }
            
        }
    }
}

struct eatlist_Previews: PreviewProvider {
    static var previews: some View {
        eatlist()
    }
}
