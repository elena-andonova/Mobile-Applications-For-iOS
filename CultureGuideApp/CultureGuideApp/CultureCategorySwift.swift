//
//  CultureCategorySwift.swift
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/8/16.
//  Copyright © 2016 EA. All rights reserved.
//

import UIKit;

@objc class CultureCategorySwift: EVObject {
    let name: NSString;
    let image:NSString;
    
    init(withName name:NSString, andImage image:NSString){
        self.name = name;
        self.image = image;
    };
    

    override var description : String {
        return "CultureCategory";
    }
}
