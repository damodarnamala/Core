//
//  File.swift
//  
//
//  Created by Damodar, Namala (623-Extern) on 08/02/21.
//

import Foundation
public extension KeyedDecodingContainer where Key: CodingKey {
    /// Try to decode a Bool as Int then String before decoding as Bool.
    ///
    /// - Parameter key: Key.
    /// - Returns: Decoded Bool value.
    /// - Throws: Decoding error.
    func decodeBoolAsIntOrString(forKey key: K) throws -> Bool {
        if let bool = try? decode(Bool.self, forKey: key) {
            return bool
        }
        if let bool = try? decode(String.self, forKey: key) {
            return bool == "1"
        }
        let int = try decode(Int.self, forKey: key)
        return int == 1
    }

    /// Try to decode a Bool as Int then String before decoding as Bool if present.
    ///
    /// - Parameter key: Key.
    /// - Returns: Decoded Bool value.
    /// - Throws: Decoding error.
    func decodeBoolAsIntOrStringIfPresent(forKey key: K) throws -> Bool? {
        if let bool = try? decodeIfPresent(Bool.self, forKey: key) {
            return bool
        }
        if let bool = try? decodeIfPresent(String.self, forKey: key) {
            return bool == "1"
        }
        if let int = try? decodeIfPresent(Int.self, forKey: key) {
            return int == 1
        }
        return nil
    }
}

public extension KeyedDecodingContainer where Key: CodingKey {
    /// Decode a URL path with appending an optional base URL.
    ///
    /// - Parameters:
    ///   - baseUrl: Base URL
    ///   - key: Key
    /// - Returns: Decoded URL.
    /// - Throws: Decoding error.
    func decodeURL(baseUrl: URL?, forKey key: K) throws -> URL? {
        let path = try decode(String.self, forKey: key)
        return baseUrl?.appendingPathComponent(path)
    }

    /// Decode a URL path with appending an optional base URL (if URL present).
    ///
    /// - Parameters:
    ///   - baseUrl: Base URL
    ///   - key: Key
    /// - Returns: Decoded URL.
    /// - Throws: Decoding error.
    func decodeURLIfPresent(baseUrl: URL?, forKey key: K) throws -> URL? {
        guard let path = try decodeIfPresent(String.self, forKey: key) else { return nil }
        return baseUrl?.appendingPathComponent(path)
    }
}

public extension KeyedEncodingContainer where Key: CodingKey {
    /// Encode URL if present and move the Base URL from it.
    ///
    /// - Parameters:
    ///   - url: Optional URL.
    ///   - baseUrl: Base URL.
    ///   - key: Key.
    /// - Throws: Encoding error.
    mutating func encodeURLIfPresent(_ url: URL?, baseUrl: URL?, forKey key: K) throws {
        guard var string = url?.absoluteString else { return }
        guard let baseString = baseUrl?.absoluteString else { return }
        string.removeFirst(baseString.count)
        try encodeIfPresent(string, forKey: key)
    }
}

public extension UserDefaults {
    /// Retrieves a Codable object from UserDefaults.
    ///
    /// - Parameters:
    ///   - type: Class that conforms to the Codable protocol.
    ///   - key: Identifier of the object.
    ///   - decoder: Custom JSONDecoder instance. Defaults to `JSONDecoder()`.
    /// - Returns: Codable object for key (if exists).
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }

    /// Allows storing of Codable objects to UserDefaults.
    ///
    /// - Parameters:
    ///   - object: Codable object to store.
    ///   - key: Identifier of the object.
    ///   - encoder: Custom JSONEncoder instance. Defaults to `JSONEncoder()`.
    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        set(data, forKey: key)
    }
}

/*
{
    "id": "test",
    "url": "test.png",
    "is_gif": 0
}
struct Image: Codable {
    let id: String
    let url: URL?
    let isGif: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case url
        case is_gif
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)

        let baseUrl = URL(string: "your base url")!
        url = try container.decodeURL(baseUrl: baseUrl, forKey: .url)
        isGif = try container.decodeBoolAsIntOrString(forKey: .is_gif)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        let baseUrl = URL(string: "your base url")!
        try container.encodeURLIfPresent(url, baseUrl: baseUrl, forKey: .url)
        try container.encode(isGif, forKey: .is_gif)
    }

    static func save(_ image: Image) {
        UserDefaults.standard.set(object: self, forKey: image.id)
    }

    static func image(for id: String) -> Image? {
        return UserDefaults.standard.object(Image.self, with: id)
    }
}
*/
