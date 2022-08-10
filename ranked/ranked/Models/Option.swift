//
//  Options.swift
//  ranked
//
//  Created by Valentin Silvera on 10.08.22.
//

import Foundation

final class Option: NSObject, Codable, Identifiable {
    let id: Int
    let name: String
    var isRanked: Bool
    
    init(
        id: Int,
        name: String,
        isRanked: Bool
    ) {
        self.id = id
        self.name = name
        self.isRanked = isRanked
    }
}

extension Option: NSItemProviderWriting {
    static let typeIdentifier = "com.valentinsilvera.ranked.option"
    
    static var writableTypeIdentifiersForItemProvider: [String] {
        [typeIdentifier]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            completionHandler(try encoder.encode(self), nil)
        } catch {
            completionHandler(nil, error)
        }
        
        return nil
    }
}

extension Option: NSItemProviderReading {
    static var readableTypeIdentifiersForItemProvider: [String] {
        [typeIdentifier]
    }
    
    static func object(
        withItemProviderData data: Data,
        typeIdentifier: String
    ) throws -> Option {
        let decoder = JSONDecoder()
        return try decoder.decode(Option.self, from: data)
    }
}
