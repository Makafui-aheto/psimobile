//
// Created by Makafui Aheto on 07/02/2023.
//

import Foundation
import SwiftUI

class CourseModel: ObservableObject{

    @Published var courses : [CourseDTO] = []

    private func fetchData<T:Encodable>(for apiURL: String,
                                         completion: @escaping (Result<[CourseDTO], Error>) -> Void,
                                         parameters: Dictionary<String, T> = [:]) async -> [CourseDTO]{

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
                    self?.courses = courses
                    completion(.success(courses))

                }catch let decoderError{
                    completion(.failure(decoderError))
                }
            }
        }

        task.resume()

        return courses
    }



    func postData<T: Codable>(for apiURL: String,
                                        completion: @escaping (Result<Any, Error>)->Void , parameters: Dictionary<String, T>? = [:],
                                        object: [Any] = [],
                                        images: Dictionary<String, UIImage> = [:]) async throws -> Any{

        guard let apiURL = URL(string: apiURL)else{return "failed"}
        var components = URLComponents(url: apiURL, resolvingAgainstBaseURL: false)!

        let boundary = UUID().uuidString

        let session = URLSession.shared

        var data = Data()

        var queryItems:[URLQueryItem] = []

       Array(parameters!.keys).map{ element in
           queryItems.append(URLQueryItem(name: element, value: parameters![element] as? String))
       }

        components.queryItems = queryItems

        var urlRequest = URLRequest(url: components.url!)

        urlRequest.httpMethod = "Post"

        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        let paramName = "file"

        object.map{data.append(try! JSONSerialization.data(withJSONObject: $0, options: []))}

        for (key, value) in images{
            data.append(value.pngData()!)
            data.append("""
                        Content-Disposition: form-data; name=\"\(paramName)\"; 
                        filename=\"\(key)\"\r\n
                        """.data(using: .utf8)!)
        }

        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)


//        let uploadtask = session.uploadTask(with: urlRequest,
//                from: data, completionHandler: <#T##@escaping @Sendable (Data?, URLResponse?, Error?) -> Void##@escaping @Sendable (Foundation.Data?, Foundation.URLResponse?, Swift.Error?) -> Swift.Void#>){ (data, response, error) in
//
//            if let error = error{completion(.failure(error))}
//
//            let encoder = JSONEncoder
//
//
//        }


        return "Success"

    }


    func getCoursesByUploadDate(uploadDate: Date, apiURL: String) async -> [CourseDTO]{

        await self.fetchData(for: apiURL, completion: { (result) in
            switch result {
            case .success:
                    print("done")
            case .failure:
                    print("errors")
            }
        },parameters: ["uploadDate": uploadDate])
    }

    func getCoursesByAuthor(author: String,apiURL:String) async -> [CourseDTO]{
        await self.fetchData(for: apiURL,completion: { (result) in
            switch result {
            case .success:
                print("done")
            case .failure:
                print("errors")
            }
        },parameters: ["author": author])

    }

    func getCoursesByTopic(topic: String, apiURL:String) async -> [CourseDTO]{
        await self.fetchData(for:apiURL,completion: { (result) in
            switch result {
            case .success:
                print("done")
            case .failure:
                print("errors")
            }
        }, parameters: ["topic": topic])
    }



}


