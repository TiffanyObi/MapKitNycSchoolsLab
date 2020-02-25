//
//  NycSchools.swift
//  MapKitNycSchoolsLab
//
//  Created by Tiffany Obi on 2/25/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import Foundation


struct NYCSchools: Codable & Equatable{
    let schoolName:String
    let overview: String
    let latitude: String
    let longitude: String
    let schoolEmail: String
    let website: String
    let bus : String
    let subway: String
    let finalgrades: String
    let neighborhood: String
    let address: String
    let city: String
    let state: String
    let zip: String
    let borough: String
}

extension NYCSchools {
    
    enum CodingKeys: String,CodingKey {
        case schoolName = "school_name"
        case overview = "overview_paragraph"
        case latitude
        case longitude
        case schoolEmail = "school_email"
        case website
        case bus
        case subway
        case finalgrades
        case neighborhood
        case address = "primary_address_line_1"
        case city
        case state = "state_code"
        case zip
        case borough
    }
    
}
