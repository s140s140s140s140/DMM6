//
//  LoadingView.swift
//  DMM6
//
//  Created by 佐藤一成 on 2019/12/26.
//  Copyright © 2019 s140. All rights reserved.
//

import Foundation
import SwiftUI



struct LoadingView: View {
    //@EnvironmentObject var environmantalObject:EnvironmentalObjectClass
    @ObservedObject var control = ControlView(ageNum: 40)
    
    @State var showBDActress:Bool = false
    var body: some View {
        VStack{
            if self.control.isLoadedComplete{
                VStack{
                    ActressListRootView()//
                    Button(action: {
                        self.showBDActress.toggle()
                    }){
                        Text("Happy Birthday")
                    }.sheet(isPresented: self.$showBDActress, content: {ActressSelectedByBirthday()})
                }
            }else{
                VStack{
                    Text("Loading...")
                    Text("\(control.actressLoadedNum)/\(control.actressTotalNum)")
                }
            }
        }
    }
}
