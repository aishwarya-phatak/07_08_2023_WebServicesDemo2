//
//  APIResponse.swift
//  07_08_2023_WebServicesDemo2
//
//  Created by Vishal Jagtap on 16/10/23.
//

import Foundation

struct APIResponse{
    var products : [Product]
    var total : Int
    var skip : Int
    var limit : Int
}

struct Product{
    var id : Int
    var title : String
//    var description : String
//    var price : Int
//    var discountPercentage : Float
//    var rating : Float
//    var stock : Int
//    var brand : String
//    var category : String
//    var prImage : String
    var images : [String]
}
