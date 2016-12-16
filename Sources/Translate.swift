//
//  Translate.swift
//  Translate
//
//  Created by Muh Rusdi on 12/17/16.
//
//

import Foundation

public struct Translate {
    public var from = "id"
    public var to = "en"
    public var text = "Swift Google Translate API"
    
    public init() { }
    
    public init(from: String, to: String, text: String) {
        self.from = from
        self.to = to
        self.text = text
    }
}
