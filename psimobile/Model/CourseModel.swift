//
// Created by Makafui Aheto on 07/02/2023.
//

import Foundation
import SwiftUI

class CourseModel: ObservableObject{

    @Published var courses : [CourseDTO] = []

    private func fetchData<T:Encodable>(for apiURL: String,
                                         completion: @escaping (Result<[CourseDTO], Error>) -> Void,
                                         parameters: Dictionary<String, T>)-> [CourseDTO]{

        guard let apiURL = URL(string: apiURL)else{return courses}

        var components = URLComponents(url: apiURL , resolvingAgainstBaseURL: false)!

        var queryItems: [URLQueryItem] = []

        for (key, value) in parameters{
            queryItems.append(URLQueryItem(name: key, value: value as? String))
        }

        components.queryItems = queryItems

        var urlRequest = URLRequest(url: components.url!)
        let session = URLSession.shared

        urlRequest.httpMethod = "GET"

        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = session.dataTask(with: urlRequest){[weak self] (data, response, error) in

            if let error = error {completion(.failure(error))}

            let decoder = JSONDecoder()
            if let data = data{
                do{
                    let courses = try decoder.decode([CourseDTO].self, from: data)
                    DispatchQueue.main.async{self?.courses = courses}
                    completion(.success(courses))
                }catch let decoderError{
                    completion(.failure(decoderError))
                }
            }
        }

        task.resume()

        return courses
    }



//    private func postData<T: Decodable>(for apiURL: String,
//                                        completion: @escaping ()->Void , parameters: [T],
//                                        image: [UIImage]?){
//
//        guard let apiURL = URL(string: apiURL)else{return}
//        var urlRequest = URLRequest(url: apiURL)
//        let session = URLSession.shared
//
//        urlRequest.httpMethod = "Post"
//
//        forEach(object){ object in
//
//        }
//
//    }


    func getCoursesByUploadDate(uploadDate: Date, apiURL: String) -> [CourseDTO]{

        self.fetchData(for: apiURL, completion: { (result) in
            switch result {
            case .success:
                    print("done")
            case .failure:
                    print("errors")
            }
        },parameters: ["uploadDate": uploadDate])
    }

    func getCoursesByAuthor(author: String,apiURL:String) -> [CourseDTO]{
        self.fetchData(for: apiURL,completion: { (result) in
            switch result {
            case .success:
                print("done")
            case .failure:
                print("errors")
            }
        },parameters: ["author": author])

    }

    func getCoursesByTopic(topic: String, apiURL:String)-> [CourseDTO]{
        self.fetchData(for:apiURL,completion: { (result) in
            switch result {
            case .success:
                print("done")
            case .failure:
                print("errors")
            }
        }, parameters: ["topic": topic])
    }



}


