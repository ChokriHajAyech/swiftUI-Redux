import Foundation
import Combine

class APIClient {
	func send<T: Decodable>(apiRequest: APIRequest)
	-> AnyPublisher<ApiResult<T, ApiErrorModel>, Error> {
		let request = apiRequest.request(with: Constants.baseUrl)
		return URLSession.shared.dataTaskPublisher(for: request)
			.receive(on: DispatchQueue.main)
			.tryMap { result -> ApiResult<T, ApiErrorModel> in
				let value = try JSONDecoder().decode(T.self, from: result.data)
				return ApiResult.success(value)
			}
			.eraseToAnyPublisher()
	}
}
