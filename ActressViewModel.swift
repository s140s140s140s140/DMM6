//
//  ActressViewModel.swift
//  DMM6
//
//  Created by 佐藤一成 on 2019/12/26.
//  Copyright © 2019 s140. All rights reserved.
//

import Foundation
import SwiftUI
import SafariServices
//女優VM
struct ActressViewModel:View,Identifiable{
    var id = UUID()
    var post:ActressModel.Result.Actress
    
    var appearString = [String]()
    var actressId:String//女優ID
    var name:String//女優名
    var ruby:String//女優名（読み仮名）0
    var birthday:Date?//生年月日1
    var bust:Int?//バスト2
    var waist:Int?//ウェスト3
    var hip:Int?//ヒップ4
    var height:Int?//身長5
    var cup:String?//カップ数6
    var blood_type:String?//血液型7
    var prefectures:String?//出身地8
    var hobby:String?//趣味9
    
    var smallImageURLString:String//画像（小）
    //var smallImageView:SmallImageView
    var largeImageURLString:String//画像（大）
    //var largeImageView:LargeImageView
    
    var digital:String//動画
    var monthly_premium:String//月額動画 見放題chプレミアム
    var ppm:String//10円動画
    var mono:String//DVD通販
    var rental:String//DVDレンタル
    
    
    
    init(post:ActressModel.Result.Actress){
        self.post = post
        //女優ID
        self.actressId = post.id!
        //女優名
        self.name = post.name!
        //女優名（読み仮名）0
        self.ruby = post.ruby!
        self.appearString.append(self.ruby)
        //生年月日1
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        self.birthday = dateFormatter.date(from:post.birthday!)
        self.appearString.append(post.birthday!)
        //バスト2
        if let myString = post.bust{
            self.bust = Int(myString)
            self.appearString.append("B:\(myString)cm")
        }else{
            self.bust = nil
            self.appearString.append("B:不明")
        }
        //ウェスト3
        if let myString = post.waist{
            self.waist = Int(myString)
            self.appearString.append("W:\(myString)cm")
        }else{
            self.waist = nil
            self.appearString.append("W:不明")
        }
        //ヒップ4
        if let myString = post.hip{
            self.hip = Int(myString)
            self.appearString.append("H:\(myString)cm")
        }else{
            self.hip = nil
            self.appearString.append("H:不明")
        }
        //身長5
        if let myString = post.height{
            self.height = Int(myString)
            self.appearString.append("身長:\(myString)cm")
        }else{
            self.height = nil
            self.appearString.append("身長:不明")
        }
        //カップ数6
        if let myString = post.cup{
            self.cup = myString
            self.appearString.append("\(myString)カップ")
        }else{
            self.cup = nil
            self.appearString.append("カップ数:不明")
        }
        //血液型7
        if let myString = post.blood_type{
            self.blood_type = myString
            self.appearString.append("血液型:\(myString)型")
        }else{
            self.blood_type = nil
            self.appearString.append("血液型:不明")
        }
        //出身地8
        if let myString = post.prefectures{
            self.prefectures = myString
            self.appearString.append("出身地:\(myString)")
        }else{
            self.prefectures = nil
            self.appearString.append("出身地不明")
        }
        //趣味9
        if let myString = post.hobby{
            self.hobby = myString
            self.appearString.append("趣味:\(myString)")
        }else{
            self.hobby = nil
            self.appearString.append("")
        }
        
        //画像（小）
        if let myString = post.imageURL?.small{
            self.smallImageURLString = myString
        }else{
            self.smallImageURLString = ""
        }
        //self.smallImageView = SmallImageView(urlString: self.smallImageURLString)
        
        //画像（大）
        if let myString = post.imageURL?.large{
            self.largeImageURLString = myString
        }else{
            self.largeImageURLString = ""
        }
        //self.largeImageView = LargeImageView(urlString: self.largeImageURLString)
        
        //動画
        if let myString = post.listURL?.digital{
            self.digital = myString
            if myString == ""{
                print("oookkkoookkk")
            }
        }else{
            self.digital = ""
        }
        
        //月額動画 見放題chプレミアム
        if let myString = post.listURL?.monthly_premium{
            self.monthly_premium = myString
        }else{
            self.monthly_premium = ""
        }
        
        //10円動画
        if let myString = post.listURL?.ppm{
            self.ppm = myString
        }else{
            self.ppm = ""
        }
        
        //DVD通販
        if let myString = post.listURL?.mono{
            self.mono = myString
        }else{
            self.mono = ""
        }
        
        //DVDレンタル
        if let myString = post.listURL?.rental{
            self.rental = myString
        }else{
            self.rental = ""
        }
        
    }
    
    @State var showSafari:Bool = false
    
    var body:some View{
        HStack{
            Text(self.name)
            Spacer()
            VStack{
                Button(action: {
                    
                    self.showSafari.toggle()
                    
                }){
                    Image(systemName: "safari")
                        .resizable()
                        .frame(width: 50, height: 50)
                    .sheet(isPresented: $showSafari){
                    safari(urlString: self.digital)
                }
            }
            }
            //Text(self.digital)
        }
    }
}


