import Foundation
import Combine

public final class HousingApi {
	var apiClient: APIClient
	init(apiClient: APIClient) {
		self.apiClient = apiClient
	}
	func housinglistings()
	-> AnyPublisher<ApiResult<HomeModel, ApiErrorModel>, Error> {
		return apiClient.send(apiRequest: HomeRequest())
	}
	func housingItem(identifier: Int)
	-> AnyPublisher<ApiResult<HousingModel, ApiErrorModel>, Error> {
		return apiClient.send(apiRequest: HousingRequest(identifier: identifier))
	}
}
