//
//  ImagesStyles.swift
//  TestOpenB
//
//  Created by Mario Andres Heberthardt Marchant on 6/12/21.
//

import Foundation

enum ImagesStyles: String, Codable {
    
    //Extension
    case jpg = ".jpg"
    case png = ".png"
    
    //Portrait aspect ratio
    case portrait_small = "/portrait_small"                //50x75px
    case portrait_medium = "/portrait_medium"        //100x150px
    case portrait_xlarge = "/portrait_xlarge"             //150x225px
    case portrait_fantastic = "/portrait_fantastic"      //168x252px
    case portrait_uncanny = "/portrait_uncanny"      //300x450px
    case portrait_incredible = "/portrait_incredible"   //216x324px
    
    
    //Standard (square) aspect ratio
    case standard_small = "/standard_small"             //65x45px
    case standard_medium = "/standard_medium"     //100x100px
    case standard_large = "/standard_large"              //140x140px
    case standard_xlarge = "/standard_xlarge"          //200x200px
    case standard_fantastic = "/standard_fantastic"   //250x250px
    case standard_amazing = "/standard_amazing"    //180x180px
    
    
    //Landscape aspect ratio
    case landscape_small = "/landscape_small"                 //120x90px
    case landscape_medium = "/landscape_medium"         //175x130px
    case landscape_large = "/landscape_large"                  //190x140px
    case landscape_xlarge = "/landscape_xlarge"              //270x200px
    case landscape_amazing = "/landscape_amazing"        //250x156px
    case landscape_incredible = "/landscape_incredible"    //464x261px
    
    case detail = "/detail"                                               //550x835px
}
