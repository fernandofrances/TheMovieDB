//
//  Store.swift
//  TMDB
//
//  Created by Fernando Frances  on 26/3/22.
//

import Foundation
import Combine

typealias Middleware<State, Action> = (State, Action) -> AnyPublisher<Action, Never>?
typealias Reducer<State, Action> = (inout State, Action) -> Void
typealias AppStore = Store<AppState, AppAction>

final class Store<State, Action> : ObservableObject {
    @Published var state: State
    private let reducer: Reducer<State, Action>
    let middlewares: [Middleware<State, Action>]
    private var subscriptions: Set<AnyCancellable> = []
    private let queue = DispatchQueue(label: "TMDB.store", qos: .userInitiated)
    
    init(initial: State,
         reducer: @escaping Reducer<State, Action>,
         middlewares: [Middleware<State, Action>] = []) {
        self.state = initial
        self.reducer = reducer
        self.middlewares = middlewares
    }
    
    func dispatch(_ action: Action) {
      queue.sync {
          self.dispatch(state: &state, action)
      }
    }
    
    private func dispatch(state: inout State,_ action: Action) {
        reducer(&state, action)
        for mw in middlewares {
            guard let middleware = mw(state, action) else {
                break
            }
            middleware
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: dispatch)
                .store(in: &subscriptions)
        }
    
    }

}
