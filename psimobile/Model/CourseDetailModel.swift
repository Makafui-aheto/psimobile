//
//  CourseDetailModel.swift
//  Psi
//
//  Created by Makafui Aheto on 06/09/2021.
//

import Foundation
import SwiftUI


class CourseDetailModel:ObservableObject{
    @Published var showCourseDetails = false
    
    @Published var selectedCourse: courseProfile!
    
}
