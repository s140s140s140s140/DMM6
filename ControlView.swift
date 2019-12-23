//
//  ControlView.swift
//  DMM6
//
//  Created by 佐藤一成 on 2019/12/22.
//  Copyright © 2019 s140. All rights reserved.
//

import Foundation
import SwiftUI

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
    var totalPages:Int = 0
    
    @Published var isLoadedComplete:Bool = false
    @Published var actressTotalNum:Int = 0
    @Published var actressLoadedNum:Int = 0{
        didSet{
            if self.actressLoadedNum == self.actressTotalNum{
                self.isLoadedComplete = true
            }
        }
    }
    init(){
        self.apiurl.changeDateToString(ageNum: 30)
        self.getPosts.append(GetPost(urlString: self.apiurl.getURL()))
        self.getPostsInitial()
    }
    
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
    func iterateStoreActress(actresses:[ActressModel.Result.Actress]){
        for actress in actresses{
            self.actressLoadedNum += 1
            ActressData.actresses.append(ActressViewModel(post: actress))
        }
    }
}

struct ActressViewModel{
    var post:ActressModel.Result.Actress
    var name:String{return post.name!}
    init(post:ActressModel.Result.Actress){
        self.post = post
    }
}


class EnvironmentalObjectClass:ObservableObject{

}

class ActressData{
    static var actresses = [ActressViewModel]()
}
