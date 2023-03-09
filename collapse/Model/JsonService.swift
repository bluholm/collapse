//
//  JsonService.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-08.
//

import Foundation

/// This class provides methods for parsing JSON data and retrieving data from a JSON file.
final class JsonService {
    
    /// Parses a JSON file and returns an array of TopicElement objects.
    ///
    /// The function attempts to retrieve the URL of the specified JSON file from the app's main bundle.
    /// If successful, it then decodes the JSON data using a JSONDecoder object and returns an array of TopicElement objects through the completion handler.
    /// If an error occurs during parsing, the function returns the error through the completion handler.
    ///
    /// - Parameters:
    ///   - file: The name of the JSON file to be parsed, without the ".json" extension.
    ///   - callback: A completion handler that takes a Result object containing an array of TopicElement objects or an error.
    static func parse(file: String, callback: @escaping(Result<[TopicElement], Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else { return }
            
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let result = try decoder.decode([TopicElement].self, from: data)
            callback(.success(result))
        } catch {
            callback(.failure(error))
        }
    }

}
