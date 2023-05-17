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
