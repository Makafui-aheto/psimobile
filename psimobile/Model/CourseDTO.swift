//
// Created by Makafui Aheto on 07/02/2023.
//

import Foundation

struct CourseDTO: Hashable, Decodable,Encodable, Identifiable{

    let id = UUID().uuidString
    var videoTitle: String
    var thumbNailPath: String
    var author: String
    var videoDescription: String
    var videoURL: [String]
    var subjectName: String
    var practiceArea: String

    init(videoTitle: String, thumbNailPath: String,
         author: String, videoDescription: String, videoURL: [String],
         subjectName: String, practiceArea: String) {

        self.videoTitle = videoTitle
        self.thumbNailPath = thumbNailPath
        self.author = author
        self.videoDescription = videoDescription
        self.videoURL = videoURL
        self.subjectName = subjectName
        self.practiceArea = practiceArea
    }

    private enum CodingKeys: String, CodingKey{
        case videoTitle, thumbNailPath, author, videoDescription, videoURL, subjectName,practiceArea
    }

}
