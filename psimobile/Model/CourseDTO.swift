//
// Created by Makafui Aheto on 07/02/2023.
//

import Foundation

struct CourseDTO: Hashable, Decodable, Encodable, Identifiable{

    let videoTitle: String
    let thumbNailPath: String
    let author: String
    let videoDescription: String
    let videoURL: [String]
    let subjectName: String
    let practiceArea: String

    private enum CodingKeys: String, CodingKey{
        case videoTitle, thumbNailPath, author, videoDescription, videoURL
    }

}
