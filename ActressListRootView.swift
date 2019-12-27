//
//  ActressListRootView.swift
//  DMM6
//
//  Created by 佐藤一成 on 2019/12/26.
//  Copyright © 2019 s140. All rights reserved.
//

import Foundation
import SwiftUI

struct ActressListRootView: View {
    @ObservedObject var actressListViewControl:ActressListViewControl
    
    
    init(){
        self.actressListViewControl = ActressListViewControl()
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker(selection: self.$actressListViewControl.selectionIndex, label: Text("並べ替え"), content: {
                        ForEach(0..<self.actressListViewControl.selectionArray.count){
                            Text(self.actressListViewControl.selectionArray[$0])
                        }
                    })//.pickerStyle(WheelPickerStyle())
                }
                
                List(0..<self.actressListViewControl.pageCount){page in
                    NavigationLink(destination: ActressListView(actressArray: self.actressListViewControl.actressesBunchArray[page])){
                        Image(systemName: "\(page+1).circle")
                            .resizable()
                            .frame(width: 25.0, height: 25.0)
                        HStack{
                            SmallImageView(urlString: self.actressListViewControl.actresses[self.actressListViewControl.pageRange[page].first!].smallImageURLString)
                            VStack(alignment:.leading){
                                Text(self.actressListViewControl.actresses[self.actressListViewControl.pageRange[page].first!].name)
                                Text("\(self.actressListViewControl.actresses[self.actressListViewControl.pageRange[page].first!].appearString[self.actressListViewControl.actressAppearIndex])")
                                    .font(.caption)
                            }
                            Spacer()
                            
                            HStack{
                                
                                VStack(alignment:.trailing){
                                    Text(self.actressListViewControl.actresses[self.actressListViewControl.pageRange[page].last!].name)
                                    Text("\(self.actressListViewControl.actresses[self.actressListViewControl.pageRange[page].last!].appearString[self.actressListViewControl.actressAppearIndex])")
                                        .font(.caption)
                                }
                                SmallImageView(urlString: self.actressListViewControl.actresses[self.actressListViewControl.pageRange[page].last!].smallImageURLString)
                            }
                        }
                    }
                }
            }
        }
    }
}
