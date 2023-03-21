//
//  ViewModel.swift
//  ChatGPT
//
//  Created by AKIN on 17.03.2023.
//

import UIKit
import OpenAISwift
import CoreData
import RevenueCat

protocol ViewModelDelegate: AnyObject {
    func responseSuccess() /// For chat Screen success response after reload
}

protocol ViewModelProtocol {
    var delegate: ViewModelDelegate? { get set } ///ViewModel's delegate
    func numberofRows() -> Int  /// For CollectionView
    func chatForRow(at indexPath: Int) -> Chat /// For CollectionView
    func getResponse(input: String, completion: @escaping(Result<String, Error>) -> Void) ///For API Sender and Response
    func saveChat(chate: Chat) /// Core Data Save Func.
}

class ChatViewModel: ViewModelProtocol {
    
    var delegate: ViewModelDelegate?
    
    private var client = OpenAISwift(authToken: Constants.key)
    
    var messages = [Chat(data: ["isSender": false, "date": Date().timeIntervalSince1970 as Double, "message": "Hello my name is ChatGPT. How can I help you?"])] {
        didSet {
            self.delegate?.responseSuccess()
        }
    } /// Chat model first message
    // MARK: - Response
    func getResponse(input: String, completion: @escaping(Result<String, Error>) -> Void) {
        let sender = Chat(data: ["isSender": true, "date": Date().timeIntervalSince1970 as Double, "message": input])
        self.saveChat(chate: sender)///sender core data save
        self.messages.append(sender)///sender array append
        client.sendCompletion(with: input, maxTokens: 500, temperature: 1, completionHandler: { result in
            switch result {
            case .success(let model):
                print(String(describing: model.choices))
                let output = model.choices.first?.text ?? ""
                let newOutput = output.trimmingCharacters(in: .whitespacesAndNewlines) ///  arrange spaces
                let chat = Chat(data: ["isSender": false, "date": Date().timeIntervalSince1970 as Double, "message": newOutput]) /// user's text
                self.saveChat(chate: chat) ///  save coredata
                self.messages.append(chat) ///  array append
                completion(.success(output))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    // MARK: - For CollectionView
    func numberofRows() -> Int {
        return messages.count /// numberOfItemsInSection
    }
    func chatForRow(at indexPath: Int) -> Chat {
        messages[indexPath] ///cell for item at
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
    // MARK: - RevenueCat
    func setupUI() {
        Purchases.shared.getCustomerInfo { [weak self] info, error in /// control premium user
            guard let info = info, error == nil else { return }
            if info.entitlements.all["Premium"]?.isActive == true {
                
            } else {
                
            }
        }
    }
    func fetchPackage(completion: @escaping (RevenueCat.Package) -> Void, selected: String) { /// in app fetch packages
        Purchases.shared.getOfferings { offerings, error in
            guard let offerings = offerings, error == nil else { return }
            guard let package = offerings.all.first?.value.package(identifier: selected) else { return }
            completion(package)
        }
    }
    func purchase(package: RevenueCat.Package) {  /// in app package purchase
        Purchases.shared.purchase(package: package) { [weak self] transaction, info, error, userCancelled in
            guard let transaction = transaction,
                  let info = info,
                  error == nil, !userCancelled else {
                return
            }
            if info.entitlements.all["Premium"]?.isActive == true {
                
            } else {
                
            }
        }
    }
    func restorePurchases() {
        Purchases.shared.restorePurchases { [weak self] info, error in
            guard let info = info, error == nil else { return }
            if info.entitlements.all["Premium"]?.isActive == true {
                
            } else {
                
            }
        }
    }
}
