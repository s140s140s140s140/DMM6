//
//  SafariService.swift
//  DMM6
//
//  Created by 佐藤一成 on 2019/12/26.
//  Copyright © 2019 s140. All rights reserved.
//

import Foundation
import SafariServices
import SwiftUI

struct safari:UIViewControllerRepresentable{
    
    var url:URL
    init(urlString:String){
        self.url = URL(string: urlString)!
    }
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<safari>) -> SFSafariViewController {
        let controller = SFSafariViewController(url:self.url)
        return controller
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<safari>) {
        
    }
    
    
}
