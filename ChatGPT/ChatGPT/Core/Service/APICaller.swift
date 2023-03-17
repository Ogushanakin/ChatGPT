//
//  APICaller.swift
//  ChatGPT
//
//  Created by AKIN on 16.03.2023.
//

import OpenAISwift
import Foundation

final class APICaller {
    static let shared = APICaller()
    
    @frozen enum Constants {
        static let key = "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"
    }
    
    private var client: OpenAISwift?
    
    private init() {}
    
    public func setup() {
        self.client = OpenAISwift(authToken: Constants.key)
    }
    
    public func getResponse(input: String, completion: @escaping(Result<String, Error>) -> Void) {
    }
}
