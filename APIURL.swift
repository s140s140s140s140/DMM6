//
//  URLLoader.swift
//  DMM3
//
//  Created by 佐藤一成 on 2019/12/13.
//  Copyright © 2019 s140. All rights reserved.
//

import Foundation
import SwiftUI


@propertyWrapper class kanaToUTF8{
    var value:String = ""
    var wrappedValue:String{
        get{value}
        set{
            if let myValue = newValue.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed){
                self.value = myValue
            }
        }
    }
}


class MakeAPIURL:ObservableObject{

    //var actressViewModel = ActressViewModel()
    
    
    enum apiType{
        case ActressSearch,ItemList
    }
    
    enum requestParameters{
        case api_id,affiliate_id,initial,actress_id,
        keyword,gte_bust,lte_bust,gte_waist,lte_waist,
        gte_hip,lte_hip,gte_height,lte_height,gte_birthday,
        lte_birthday,hits,offset,sort,output,site,service,
        floor,cid,article,article_id,gte_date,lte_date,mono_stock
    }
    
    var parameters = Dictionary<requestParameters,String>()
    
    
    
    var mainURL:String
    @kanaToUTF8 var parameterString:String
    
    
    
    
    let sortRule:Dictionary<String,String> = ["名前昇順":"name","名前降順":"-name","バスト昇順":"bust","バスト降順":"-bust","ウエスト昇順":"waist","ウエスト降順":"-waist","ヒップ昇順":"hip","ヒップ降順":"-hip","身長昇順":"height","身長降順":"-height","生年月日昇順":"birthday","生年月日降順":"-birthday"]
    var sortRuleArray:[String] = []
    

    
    @Published var selectedRuleIndex:Int = 0{
        didSet{
            let myKey = self.sortRuleArray[self.selectedRuleIndex]
            let myValue = self.sortRule[myKey]!
            self.parameters[.sort] = myValue
        }
    }
    
    
    
    init(apiType:apiType){
        self.mainURL = "https://api.dmm.com/affiliate/v3/\(apiType)?"
        
        self.parameters[.api_id] = "J0Zp5Xx6C50uw9cgZrqu"
        self.parameters[.affiliate_id] = "s140s140-990"
        self.parameters[.output] = "json"
        self.parameters[.hits] = "100"
        
        for rule in self.sortRule{
            self.sortRuleArray.append(rule.key)
        }
        self.sortRuleArray.sort()
        
    }
    
    func getURL()->String{
        self.parameterString = self.parameters.map{"\($0.key)=\($0.value)"}.joined(separator: "&")
        let urlString = self.mainURL + self.parameterString
        return urlString
    }
    
    func changeDateToString(ageNum:Int){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let calender = Calendar.current
        let compos = DateComponents(year: -1 * ageNum - 1)
        let targetDay = calender.date(byAdding: compos, to: Date())!
        let targetDayString = dateFormatter.string(from: targetDay)
        self.parameters[.gte_birthday] = String(targetDayString)
        
    }
    
}
