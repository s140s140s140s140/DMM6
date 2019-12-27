//
//  ItemListByActress.swift
//  DMM6
//
//  Created by 佐藤一成 on 2019/12/26.
//  Copyright © 2019 s140. All rights reserved.
//

import Foundation
import SwiftUI
//import SafariServices

struct ItemListByActress:View{
    @State var showSafari:Bool = false
    var actress:ActressViewModel
    
    init(actressVM:ActressViewModel){
        self.actress = actressVM
        
        let apiURL = MakeAPIURL(apiType: .ItemList)
        apiURL.parameters[.site] = "FANZA"
        apiURL.parameters[.service] = "digital"
        apiURL.parameters[.floor] = "videoa"
        apiURL.parameters[.hits] = "100"
        apiURL.parameters[.sort] = "rank"
        apiURL.parameters[.article] = "actress"
        apiURL.parameters[.article_id] = self.actress.actressId
        
        print(apiURL.getURL())
    }
    
    
    
    var body:some View{
        List{
            HStack{
                LargeImageView(urlString: self.actress.largeImageURLString)
                self.actress.body
                Button(action: {
                    self.showSafari.toggle()
                }){
                    Image(systemName: "safari")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .sheet(isPresented: $showSafari){
                            safari(urlString: self.actress.digital)
                    }
                }
            }
        }
    }
}

