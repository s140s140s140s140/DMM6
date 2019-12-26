//
//  ActressListView.swift
//  DMM6
//
//  Created by 佐藤一成 on 2019/12/23.
//  Copyright © 2019 s140. All rights reserved.
//

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

class ActressListViewControl:ObservableObject{
    enum PickerStrings:String, CaseIterable{
        case hiraganaIncrement = "あいうえお順"
        case hiraganaDecrement = "あいうえお逆順"
        case ageIncrement = "若い順"
        case ageDecrement = "若くない順"
        case bustDecrement = "バストが大きい順"
        case bustIncrement = "バストが小さい順"
        case weistIncrement = "ウエストが細い順"
        case weistDecrement = "ウエストが細くない順"
        case hipIncrement = "ヒップが大きい順"
        case hipDecrement = "ヒップが小さい順"
        case heightIncrement = "背が低い順"
        case heightDecrement = "背が高い順"
        case cupIncrement = "カップ数が小さい順"
        case cupDecrement = "カップ数が大きい順"
        case bloodType = "血液型別"
        case prefecture = "出身地別"
        
        case random = "ランダム"
    }
    
    
    @Published var actresses:[ActressViewModel]
    @Published var actressesBunchArray:[[ActressViewModel]]
    var actressAppearIndex:Int = 0
    var selectionArray = [PickerStrings.RawValue]()

    var selectionIndex:Int = 0{
        didSet{
            switch self.selectionArray[self.selectionIndex]{
            //"あいうえお順"
            case PickerStrings.hiraganaIncrement.rawValue:
                self.actresses.sort{$0.ruby < $1.ruby}
                self.actressAppearIndex = 0
            //"あいうえお逆順"
            case PickerStrings.hiraganaDecrement.rawValue:
                self.actresses.sort{$0.ruby > $1.ruby}
                self.actressAppearIndex = 0
                
            //"若い順"
            case PickerStrings.ageIncrement.rawValue:
                self.actresses.sort{$0.birthday! > $1.birthday!}
                self.actressAppearIndex = 1
            //"若くない順"
            case PickerStrings.ageDecrement.rawValue:
                self.actresses.sort{$0.birthday! < $1.birthday!}
                self.actressAppearIndex = 1
            //"バストが大きい順"
            case PickerStrings.bustDecrement.rawValue:
                self.actresses.sort{(a1,a2) ->Bool in
                    if a1.bust == nil{return false}
                    if let aa1 = a1.bust,let aa2 = a2.bust{return aa1>aa2}
                    return true
                }
                self.actressAppearIndex = 2
            //"バストが小さい順"
            case PickerStrings.bustIncrement.rawValue:
                self.actresses.sort{(a1,a2) ->Bool in
                    if a1.bust == nil{return false}
                    if let aa1 = a1.bust,let aa2 = a2.bust{return aa1<aa2}
                    return true
                }
                self.actressAppearIndex = 2
                
            //"ウエストが細い順"
            case PickerStrings.weistIncrement.rawValue:
                self.actresses.sort{(a1,a2) ->Bool in
                    if a1.waist == nil{return false}
                    if let aa1 = a1.waist,let aa2 = a2.waist{return aa1<aa2}
                    return true
                }
                self.actressAppearIndex = 3
            //"ウエストが細くない順"
            case PickerStrings.weistDecrement.rawValue:
                self.actresses.sort{(a1,a2) ->Bool in
                    if a1.waist == nil{return false}
                    if let aa1 = a1.waist,let aa2 = a2.waist{return aa1>aa2}
                    return true
                }
                self.actressAppearIndex = 3
                
            //"ヒップが大きい順"
            case PickerStrings.hipDecrement.rawValue:
                self.actresses.sort{(a1,a2) ->Bool in
                    if a1.hip == nil{return false}
                    if let aa1 = a1.hip,let aa2 = a2.hip{return aa1<aa2}
                    return true
                }
                self.actressAppearIndex = 4
            //"ヒップが小さい順"
            case PickerStrings.hipIncrement.rawValue:
                self.actresses.sort{(a1,a2) ->Bool in
                    if a1.hip == nil{return false}
                    if let aa1 = a1.hip,let aa2 = a2.hip{return aa1>aa2}
                    return true
                }
                self.actressAppearIndex = 4
            //"背が低い順"
            case PickerStrings.heightIncrement.rawValue:
                self.actresses.sort{(a1,a2) ->Bool in
                    if a1.height == nil{return false}
                    if let aa1 = a1.height,let aa2 = a2.height{return aa1<aa2}
                    return true
                }
                self.actressAppearIndex = 5
            //"背が高い順"
            case PickerStrings.heightDecrement.rawValue:
                self.actresses.sort{(a1,a2) ->Bool in
                    if a1.height == nil{return false}
                    if let aa1 = a1.height,let aa2 = a2.height{return aa1>aa2}
                    return true
                }
                self.actressAppearIndex = 5
                
            //"カップ数が小さい順"
            case PickerStrings.cupIncrement.rawValue:
                self.actresses.sort{(a1,a2) ->Bool in
                    if a1.cup == nil{return false}
                    if let aa1 = a1.cup,let aa2 = a2.cup{return aa1<aa2}
                    return true
                }
                self.actressAppearIndex = 6
            //"カップ数が大きい順"
            case PickerStrings.cupDecrement.rawValue:
                self.actresses.sort{(a1,a2) ->Bool in
                    if a1.cup == nil{return false}
                    if let aa1 = a1.cup,let aa2 = a2.cup{return aa1>aa2}
                    return true
                }
                self.actressAppearIndex = 6
                
            //"血液型別"
            case PickerStrings.bloodType.rawValue:
                self.actresses.sort{(a1,a2) ->Bool in
                    if a1.blood_type == nil{return false}
                    if let aa1 = a1.blood_type,let aa2 = a2.blood_type{return aa1<aa2}
                    return true
                }
                self.actressAppearIndex = 7
                
            //"出身地別"
            case PickerStrings.prefecture.rawValue:
                self.actresses.sort{(a1,a2) ->Bool in
                    if a1.prefectures == nil{return false}
                    if let aa1 = a1.prefectures,let aa2 = a2.prefectures{return aa1>aa2}
                    return true
                }
                self.actressAppearIndex = 8
                
            //"ランダム"
            case PickerStrings.random.rawValue:
                self.actresses.shuffle()
                self.actressAppearIndex = 9
                
                
            default:
                print("Default")
            }
            
            self.sortBunchArray()
        }
    }
    var pageCount:Int
    var pageRange = [Range<Int>]()
    init(){
        for p in PickerStrings.allCases{
            self.selectionArray.append(p.rawValue)
        }
        
        self.actresses = ActressData.actresses
        self.actressesBunchArray = [[ActressViewModel]]()
        self.pageCount = ((ActressData.actresses.count-1)/100) + 1
        for i in 0..<self.pageCount{
            let firstIndex = i * 100
            var lastIndex = firstIndex + 100
            lastIndex = (lastIndex > self.actresses.count) ? self.actresses.count:lastIndex
            self.pageRange.append(firstIndex..<lastIndex)
        }
        self.actresses.sort{$0.ruby < $1.ruby}
        self.sortBunchArray()
    }
    func sortBunchArray(){
        self.actressesBunchArray.removeAll()
        for i in 0..<self.pageCount{
            var tempoActresses = [ActressViewModel]()
            for j in self.pageRange[i]{
                tempoActresses.append(self.actresses[j])
            }
            self.actressesBunchArray.append(tempoActresses)
        }
    }
}

struct ActressListView:View{
    var actressArray:[ActressViewModel]
    init(actressArray:[ActressViewModel]){
        self.actressArray = actressArray
    }
    var body:some View{
        NavigationView{
            List(0..<self.actressArray.count){num in
                HStack{
                    LargeImageView(urlString: self.actressArray[num].largeImageURLString)
                    self.actressArray[num]
                }
            }
        }
    }
}
