//
//  AppModel.swift
//  ModulesGPT
//
//  Created by BJIT on 16/5/23.
//

import SwiftUI
import OpenAISwift

final class AppModel: ObservableObject{

    @Published var isThinking: Bool = false
    @Published var selectedModule: Modules?
    @Published var newChatEntryText: String = ""
    @Published var generatedNewChat: String = ""
    var isEmptyNewChatScreen: Bool{ !isThinking && generatedNewChat.isEmpty}
    var hasResultNewChatScreen: Bool{
        !isThinking && !generatedNewChat.isEmpty
    }
    private var client: OpenAISwift?

    func setup(){
        client = OpenAISwift(authToken: "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")
    }

    func send(text: String, completion: @escaping (String) -> Void){
        isThinking = true
        client?.sendCompletion(with: text, maxTokens: 500, completionHandler: { result in
            switch result{
            case .success(let model):
                let output = model.choices?.first?.text ?? ""
                completion(output)
            case .failure(_):
                let output = "Error Occured"
                completion(output)

            }
        })
    }

    func makeNewChat(){
        send(text: "\(newChatEntryText)") { output in
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else{
                    return
                }
                self.generatedNewChat = output.trimmingCharacters(in: .whitespacesAndNewlines)
                self.isThinking = false
            }
        }
    }
}

enum Modules: CaseIterable, Identifiable{
    case newChat

    var id: String{return title}
    var title: String{
        switch self{
        case .newChat: return "New Chat"
        }
    }

    var sfSymbol: String{
        switch self{
        case .newChat: return "text.bubble"
        }
    }
}
