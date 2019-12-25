//
//  ControlView.swift
//  DMM6
//
//  Created by 佐藤一成 on 2019/12/22.
//  Copyright © 2019 s140. All rights reserved.
//

import Foundation
import SwiftUI
//JSONデータ書き出し用
class GetPost{
    var url:URL
    init(urlString:String){
        self.url = URL(string: urlString)!
    }
    func getPost(completion:@escaping (ActressModel?)->()){
        URLSession.shared.dataTask(with: self.url){data,response,error in
            guard let data = data,error==nil else{
                print("error!")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            let post = try? JSONDecoder().decode(ActressModel.self,from: data)
            DispatchQueue.main.async {
                completion(post)
            }
        }.resume()
    }
}

class ControlView:ObservableObject{
    var apiurl:MakeAPIURL = MakeAPIURL(apiType: .ActressSearch)
    var getPosts:[GetPost] = [GetPost]()
    var totalPages:Int = 999
    
    @Published var isLoadedComplete:Bool = false
    @Published var actressTotalNum:Int = 0
    @Published var actressLoadedNum:Int = 0{
        didSet{
            if self.actressLoadedNum == self.actressTotalNum{
                self.isLoadedComplete = true
            }
        }
    }
    init(ageNum:Int){
        self.apiurl.changeDateToString(ageNum: ageNum)
        self.getPosts.append(GetPost(urlString: self.apiurl.getURL()))
        self.getPostsInitial()
    }
    //    JSONデータをページ数分呼び出し
    func getPostsInitial(){
        self.getPosts[0].getPost(completion: {post in
            guard let result = post?.result else{
                print("error")
                return
            }
            let totalNum:Int = Int(result.total_count!)!
            self.actressTotalNum = totalNum
            self.totalPages = (totalNum-1)/100
            self.iterateStoreActress(actresses: result.actress!)
            if self.totalPages>1{
                self.getPostsFromSecondPages()
            }
        })
    }
    
    func getPostsFromSecondPages(){
        for i in 1...self.totalPages{
            let urlString = "\(self.apiurl.getURL())&offset=\(i*100+1)"
            self.getPosts.append(GetPost(urlString: urlString))
            self.getPosts[i].getPost(completion: {post in
                guard let result = post?.result else{
                    print("error")
                    return
                }
                self.iterateStoreActress(actresses: result.actress!)
            })
        }
    }
    //ActressDataクラスにデータを格納
    func iterateStoreActress(actresses:[ActressModel.Result.Actress]){
        for actress in actresses{
            self.actressLoadedNum += 1
            ActressData.actresses.append(ActressViewModel(post: actress))
        }
    }
}



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
    var largeImageView:LargeImageView
    
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
        self.largeImageView = LargeImageView(urlString: self.largeImageURLString)
    }
    var body:some View{
        HStack{
            self.largeImageView.body
        }
    }
}

//environmentObject
class EnvironmentalObjectClass:ObservableObject{
    
}
//女優データを格納
class ActressData{
    static var actresses = [ActressViewModel]()
}
