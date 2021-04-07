import Foundation
import Combine
import Foundation

final class Store<State, Action>: ObservableObject {
	
	// Read-only access to app state
	@Published private(set) var state: State
	
	private let middlewares: [(State, Action) -> AnyPublisher<Action, Error>?]
	private var middlewareCancellables: Set<AnyCancellable> = []
	private let reducer:(inout State, Action) -> Void
	
	init(initialState: State,
		 reducer: @escaping (inout State, Action) -> Void,
		 middlewares: [(State, Action) -> AnyPublisher<Action, Error>?] = []) {
		self.state = initialState
		self.reducer = reducer
		self.middlewares = middlewares
	}
	
	// The dispatch function.
	func dispatch(_ action: Action) {
		reducer(&state, action)
		
		// Dispatch all middleware functions
		middlewares.forEach { mw in
			if let middleware = mw(state, action) {
				middleware
					.receive(on: DispatchQueue.main)
					.sink(receiveCompletion: { data in
						print(data)
					}, receiveValue: dispatch)
					.store(in: &middlewareCancellables)
			}
		}
	}
}
