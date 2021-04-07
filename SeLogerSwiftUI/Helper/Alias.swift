import Foundation
import Combine

typealias AppStore = Store<AppState, AppAction>
typealias Reducer<State, Action> = (inout State, Action) -> Void
typealias Middleware<State, Action> = (State, Action) -> AnyPublisher<Action, Error>?
typealias Dispatcher = (AppAction) -> Void
