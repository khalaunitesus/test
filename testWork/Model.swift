//
//  Model.swift
//  testWork
//
//  Created by yakuza on 04/09/2018.
//  Copyright © 2018 yakuza. All rights reserved.
//

import Foundation


struct StockStructure: Codable {
    let stock: [Stock]
    let asOf: Date
    
    enum CodingKeys: String, CodingKey {
        case stock = "stock"
        case asOf = "as_of"
    }
}

struct Stock: Codable {
    let name: String
    let price: Price
    let percentChange: Double
    let volume: Int
    let symbol: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case price = "price"
        case percentChange = "percent_change"
        case volume = "volume"
        case symbol = "symbol"
    }
}

struct Price: Codable {
    let currency: Currency
    let amount: Double
    
    enum CodingKeys: String, CodingKey {
        case currency = "currency"
        case amount = "amount"
    }
}

enum Currency: String, Codable {
    case php = "PHP"
}

// MARK: Convenience initializers and mutators

extension StockStructure {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StockStructure.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        stock: [Stock]? = nil,
        asOf: Date? = nil
        ) -> StockStructure {
        return StockStructure(
            stock: stock ?? self.stock,
            asOf: asOf ?? self.asOf
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Stock {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Stock.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        name: String? = nil,
        price: Price? = nil,
        percentChange: Double? = nil,
        volume: Int? = nil,
        symbol: String? = nil
        ) -> Stock {
        return Stock(
            name: name ?? self.name,
            price: price ?? self.price,
            percentChange: percentChange ?? self.percentChange,
            volume: volume ?? self.volume,
            symbol: symbol ?? self.symbol
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Price {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Price.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        currency: Currency? = nil,
        amount: Double? = nil
        ) -> Price {
        return Price(
            currency: currency ?? self.currency,
            amount: amount ?? self.amount
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
