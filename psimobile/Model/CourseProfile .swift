//
//  CourseProfile .swift
//  Psi
//
//  Created by Makafui Aheto on 06/09/2021.
//

import Foundation
import SwiftUI


struct courseProfile: Identifiable{
    
    let id = UUID().uuidString
    var courseProfilePic: String
    var uploadTime: UIDatePicker.Mode
    var courseTitle: String
    var courseAuthor: String
    var courseDescription: String
    var videoURL: String
    
}

let initializers = [

    courseProfile(courseProfilePic: "studying", uploadTime: UIDatePicker.Mode.date, courseTitle: "Life Insurance Mathematics", courseAuthor: "Makafui Aheto", courseDescription: "Learn the rudiments of Life Insurance Mathematics, and how the practice is in the UK", videoURL: "Movie"),
    
    courseProfile(courseProfilePic: "students", uploadTime: UIDatePicker.Mode.date, courseTitle: "Risk Theory", courseAuthor: "Edna Okoth", courseDescription: "Learn the Power of Excel in Exploring the Profitability of Life Insurance companies. ", videoURL: "RiskTheory"),
    
    courseProfile(courseProfilePic: "horizon", uploadTime: UIDatePicker.Mode.date, courseTitle: "General Insurance", courseAuthor: "Matthew Chomba", courseDescription: "Learn the rudiments of General Insurance, and how the practice is in the UK", videoURL: "General"),


]

