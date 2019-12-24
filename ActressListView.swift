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
                        HStack{
                            Text(self.actressListViewControl.actresses[self.actressListViewControl.pageRange[page].first!].name)
                            Spacer()
                            Text(self.actressListViewControl.actresses[self.actressListViewControl.pageRange[page].last!].name)
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
        case random = "ランダム"
    }
    
    
    @Published var actresses:[ActressViewModel]
    @Published var actressesBunchArray:[[ActressViewModel]]

    var selectionArray = [PickerStrings.RawValue]()
    
    var selectionIndex:Int = 0{
        didSet{
            switch self.selectionArray[self.selectionIndex]{
                
            case PickerStrings.hiraganaIncrement.rawValue:
                self.actresses.sort{$0.ruby < $1.ruby}
            case PickerStrings.hiraganaDecrement.rawValue:
                self.actresses.sort{$0.ruby > $1.ruby}
            case PickerStrings.random.rawValue:
                self.actresses.shuffle()
            case PickerStrings.ageIncrement.rawValue:
                self.actresses.sort{$0.birthday! > $1.birthday!}
            case PickerStrings.ageDecrement.rawValue:
                self.actresses.sort{$0.birthday! < $1.birthday!}
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
                self.actressArray[num]
            }
        }
    }
}
