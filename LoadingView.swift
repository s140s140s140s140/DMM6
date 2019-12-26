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
    @ObservedObject var control = ControlView(ageNum: 50)
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
