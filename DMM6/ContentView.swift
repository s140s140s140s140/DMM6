//
//  ContentView.swift
//  DMM6
//
//  Created by 佐藤一成 on 2019/12/22.
//  Copyright © 2019 s140. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    //@EnvironmentObject var environmantalObject:EnvironmentalObjectClass
    @ObservedObject var control = ControlView(ageNum: 40)
    var body: some View {
        VStack{
            if self.control.isLoadedComplete{
                    ActressListRootView()
            }else{
                VStack{
                    Text("Loading...")
                    Text("\(control.actressLoadedNum)/\(control.actressTotalNum)")
                }
            }
        }
    }
}


struct ContentView: View {
    var body: some View {
        LoadingView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
