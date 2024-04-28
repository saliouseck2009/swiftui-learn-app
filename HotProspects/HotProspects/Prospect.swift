//
//  Prospect.swift
//  HotProspects
//
//  Created by saliou seck on 26/04/2024.
//

import SwiftData

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
    
    static var sampleProspect = Prospect(name: "Saliou seck", emailAddress: "saliouseck@ldb.sn", isContacted: false)
}
