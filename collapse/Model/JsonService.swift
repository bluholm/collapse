//
//  JsonService.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-08.
//

import Foundation

final class JsonService {
    
    static func parse(file: String, callback: @escaping(Result<[TopicElement], Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: file, withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return  }
        let decoder = JSONDecoder()
           do {
             let result = try decoder.decode([TopicElement].self, from: data)
               callback(.success(result))
           } catch {
               callback(.failure(error))
           }
    }
}
