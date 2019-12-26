//
//  ActressModel.swift
//  DMM5
//
//  Created by 佐藤一成 on 2019/12/20.
//  Copyright © 2019 s140. All rights reserved.
//

import Foundation
struct Request:Codable{
    struct Parameters:Codable {
    }
    var parameters:Parameters?
}


struct ActressModel:Codable {
    
    var request:Request?
    
    //--------------
    struct Result:Codable{
        var status:String?
        var result_count:Int?
        var total_count:String?
        //var first_position:String?
        struct Actress:Codable{
            var id:String?
            var name:String?
            var ruby:String?
            var bust:String?
            var cup:String?
            var waist:String?
            var hip:String?
            var height:String?
            var birthday:String?
            var blood_type:String?
            var hobby:String?
            var prefectures:String?
            struct ImageURL:Codable{
                var small:String?
                var large:String?
            }
            var imageURL:ImageURL?
            struct ListURL:Codable{
                var digital:String?
                var monthly_premium:String?
                var ppm:String?
                var mono:String?
                var rental:String?
            }
            var listURL:ListURL?
        }
        var actress:[Actress]?
    }
    var result:Result
}
