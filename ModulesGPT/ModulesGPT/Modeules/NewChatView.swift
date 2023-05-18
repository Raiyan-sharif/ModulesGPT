//
//  NewChatView.swift
//  ModulesGPT
//
//  Created by BJIT on 18/5/23.
//

import SwiftUI

struct NewChatView: View {
    @EnvironmentObject private var _model: AppModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            VStack(spacing: 32) {
                VStack{
                    HStack {
                        TextField("Required",text: $_model.newChatEntryText, axis: .vertical)
                            .padding(8)
                            .background(Color(.secondarySystemFill).cornerRadius(10))
                            .padding(.leading, 24)
                        if _model.newChatEntryText.isEmpty{
                            Button("Paste"){
                                _model.newChatEntryText = UIPasteboard.general.string ?? ""
                            }

                        }
                    }
                    .padding(.trailing, 24)
                    Text("Provide text")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 34)
                }
                if _model.isEmptyNewChatScreen, !_model.newChatEntryText.isEmpty{
                    Text("Tap 'Send' in the top right corner of your screen")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                }

                if _model.hasResultNewChatScreen{
                    Text(_model.generatedNewChat)
                }

            }
            .navigationTitle("New Chat")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Send"){
                        _model.makeNewChat()
                    }
                }
            }

        }
    }
}
