//
//  ImageLoader.swift
//  DMM6
//
//  Created by 佐藤一成 on 2019/12/25.
//  Copyright © 2019 s140. All rights reserved.
//

import Foundation
import SwiftUI

struct SmallImageView:View{
    //65*65
    let imageSide:CGFloat = 50.0
    @ObservedObject var smallImageLoader = SmallImageLoader()
    init(urlString:String){
        guard urlString != "" else{
            print("No URL")
            return
        }
        guard let url = URL(string: urlString) else{
            print("INVALID URL")
            return
        }
        self.smallImageLoader.load(url: url)
    }
    
    var body:some View{
        if let imageData = self.smallImageLoader.downloadData, let img = UIImage(data: imageData){
            return Image(uiImage: img)
                .resizable()
                .frame(width: self.imageSide, height: self.imageSide)
                .cornerRadius(10.0)
        }else{
            return Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: self.imageSide, height: self.imageSide)
                .cornerRadius(0.0)
        }
    }
}

class SmallImageLoader:ObservableObject{
    @Published var downloadData:Data? = nil
    func load(url:URL){
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.downloadData = data
            }
        }
    }
}


struct LargeImageView:View{
    //125*125
    let imageSide:CGFloat = 100.0
    @ObservedObject var largeImageLoader = LargeImageLoader()
    init(urlString:String){
        guard urlString != "" else{
            print("No URL")
            return
        }
        guard let url = URL(string: urlString) else{
            print("INVALID URL")
            return
        }
        self.largeImageLoader.load(url: url)
    }
    
    var body:some View{
        if let imageData = self.largeImageLoader.downloadData, let img = UIImage(data: imageData){
            return Image(uiImage: img)
                .resizable()
                .frame(width: self.imageSide, height: self.imageSide)
                .cornerRadius(10.0)
        }else{
            return Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: self.imageSide, height: self.imageSide)
                .cornerRadius(0.0)
        }
    }
}

class LargeImageLoader:ObservableObject{
    @Published var downloadData:Data? = nil
    func load(url:URL){
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.downloadData = data
            }
        }
    }
}
