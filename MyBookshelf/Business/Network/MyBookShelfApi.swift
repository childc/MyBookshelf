//
//  MyBookShelfApi.swift
//  MyBookshelf
//
//  Created by childc on 2021/11/03.
//

import Foundation

enum MyBookShelfApi: CustomStringConvertible {
    case search(query: String, page: Int?)
    case new
    case detail(isbn13: String)
    
    var description: String {
        switch self {
        case .search:
            return "search"
        case .new:
            return "new"
        case .detail:
            return "books"
        }
    }
}

extension MyBookShelfApi {
    var baseUrl: String {
        return "https://api.itbook.store/1.0"
    }
    
    var url: String {
        switch self {
        case .new:
            return [baseUrl, description].joined(separator: "/")
        case let .detail(isbn13):
            return [baseUrl, description, isbn13].joined(separator: "/")
        case let .search(query, page):
            let url = [baseUrl, description, query].joined(separator: "/")
            guard let page = page else {
                return url
            }
            
            return [url, String(page)].joined(separator: "/")
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
    
    func request(completion: ((Result<Data, Error>) -> Void)? = nil) {
        guard let url = URL(string: url) else {
            completion?(.failure(MyBookShelfApiError.unsupportedUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        print("request: \(request)")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("request: \(request), error: \(error)")
                completion?(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let data = data else {
                      print("response: \(response.debugDescription), error: \(MyBookShelfApiError.retrieveFailed)")
                      completion?(.failure(MyBookShelfApiError.retrieveFailed))
                      return
                  }
            
            print("retrieve data success")
            completion?(.success(data))
        }.resume()
    }
}
