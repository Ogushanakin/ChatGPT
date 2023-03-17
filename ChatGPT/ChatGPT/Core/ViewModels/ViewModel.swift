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
    func saveChat(chate: Chat)
}

class ChatViewModel: ViewModelProtocol {
    
    var delegate: ViewModelDelegate?
    
    private var client = OpenAISwift(authToken: "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")
    
    var messages = [Chat]() {
        didSet {
            self.delegate?.responseSuccess()
        }
    }
    // MARK: - CoreData Save
    func saveChat(chate: Chat) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ChatEntity> = ChatEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "message == %@", chate.message)
        do {
            let existingChats = try context.fetch(fetchRequest)
            if let existingChat = existingChats.first {
                print("Chat already.. \(existingChat.message ?? "")")
                return
            }
            let chat = NSEntityDescription.insertNewObject(forEntityName: "ChatEntity", into: context) as! ChatEntity
            chat.message = chate.message
            chat.isSender = chate.isSender
            
            try context.save()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    // MARK: - CoreData Fetch
    func fetchChat() {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ChatEntity")
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                var chat : Chat!
                var dict : [String : Any]!
                
                
                for result in results as! [NSManagedObject] {
                    let message = result.value(forKey: "message") as? String ?? ""
                    let isSender =  result.value(forKey: "isSender") as? Bool ?? false
            
                    dict = ["message":message,"date": Date().timeIntervalSince1970,"isSender":isSender]
                    chat = Chat(data: dict)
                    self.messages.append(chat)
                }
                
            } catch  {
                print(error.localizedDescription)
            }
        }
    
    func getResponse(input: String, completion: @escaping(Result<String, Error>) -> Void) {
        let sender = Chat(data: ["isSender": true, "date": Date().timeIntervalSince1970 as Double, "message": input])
        self.saveChat(chate: sender)
        self.messages.append(sender)
        client.sendCompletion(with: input, maxTokens: 100, temperature: 1, completionHandler: { result in
            switch result {
            case .success(let model):
                print(String(describing: model.choices))
                let output = model.choices.first?.text ?? ""
                let newOutput = output.trimmingCharacters(in: .whitespacesAndNewlines)
                let chat = Chat(data: ["isSender": false, "date": Date().timeIntervalSince1970 as Double, "message": newOutput])
                self.saveChat(chate: chat)
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
