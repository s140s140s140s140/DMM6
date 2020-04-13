//
//  ActressSelectedByBirthday.swift
//  DMM6
//
//  Created by 佐藤一成 on 2019/12/27.
//  Copyright © 2019 s140. All rights reserved.
//

import Foundation
import SwiftUI

struct ActressSelectedByBirthday:View{
    
    @State var showSafari:Bool = false
    
    var actresses:[ActressViewModel]
    
    init(){
        self.actresses = []
        let calender:Calendar = Calendar(identifier: .gregorian)
        let today = calender.dateComponents([.month,.day], from: Date())
        for actress in ActressData.actresses{
            let birthday = calender.dateComponents([.month,.day], from: actress.birthday!)
            if today.day! == birthday.day!, today.month! == birthday.month!{
                self.actresses.append(actress)
            }
        }
    }
    var body:some View{
        NavigationView{
            List(self.actresses){actress in
                
                HStack{
                    LargeImageView(urlString: actress.largeImageURLString)
                    actress.body
                    Button(action: {
                        self.showSafari.toggle()
                    }){
                        Image(systemName: "safari")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .sheet(isPresented: self.$showSafari){
                                safari(urlString: actress.digital)
                        }
                    }
                    
                }
            }.navigationBarTitle(Text("Happy birthday"))
        }
    }
}





