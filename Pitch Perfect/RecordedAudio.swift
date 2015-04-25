//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Darling Vinavong on 4/18/15.
//  Copyright (c) 2015 Mattika Vinavong. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePath: NSURL, title: String) {
        self.filePathUrl = filePath
        self.title = title
    }

}