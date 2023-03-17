//
//  ViewModel.swift
//  ChatGPT
//
//  Created by AKIN on 17.03.2023.
//

import UIKit
import OpenAISwift
import CoreData

protocol ViewModelDelegate: AnyObject {
    func responseSuccess()
}

protocol ViewModelProtocol {
    var delegate: ViewModelDelegate? { get set }
    func numberofRows() -> Int
    func chatForRow(at indexPath: Int) -> Chat
    func getResponse(input: String, completion: @escaping(Result<String, Error>) -> Void)
    func saveChat(chat: [Chat])
}

class ChatViewModel: ViewModelProtocol {
    func saveChat(chat: [Chat]) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let chat = NSEntityDescription.insertNewObject(forEntityName: "chat", into: context)
    }
    
    var delegate: ViewModelDelegate?
    private var client = OpenAISwift(authToken: "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")
    var messages = [Chat]() {
        didSet {
            self.delegate?.responseSuccess()
        }
    }
    
    func getResponse(input: String, completion: @escaping(Result<String, Error>) -> Void) {
        let sender = Chat(isSender: true, date: Date().timeIntervalSince1970, message: input)
        self.messages.append(sender)
        client.sendCompletion(with: input, maxTokens: 100, temperature: 1, completionHandler: { result in
            switch result {
            case .success(let model):
                print(String(describing: model.choices))
                let output = model.choices.first?.text ?? ""
                let newOutput = output.trimmingCharacters(in: .whitespacesAndNewlines)
                let chat = Chat(isSender: false, date: Date().timeIntervalSince1970, message: newOutput)
                self.messages.append(chat)
                completion(.success(output))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func numberofRows() -> Int {
        return messages.count
    }
    
    func chatForRow(at indexPath: Int) -> Chat {
        messages[indexPath]
    }
}
