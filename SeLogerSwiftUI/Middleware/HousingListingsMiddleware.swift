import Foundation
import Combine

func HousingListingsMiddleware(service: HousingApi) ->
	(AppState, AppAction) -> AnyPublisher<AppAction, Error>? {
	
	let mapper: HousingMapper = HousingMapper()
	let mapperListing = HousingDataCellMapper()
	
	return { state, action in
		switch action {
		case .housingAction(action: .fetchListHousing):
		 return service.housinglistings()
				.subscribe(on: DispatchQueue.main)
				.map { data -> AppAction in

					switch data {
					case .success(let list):
						let listDetails = list.items.compactMap {
							item -> HousingDetails in
								mapper.mapToEntity(type: item)!
							}
						let listHousing = listDetails.compactMap {
							item -> HousingList? in
							mapperListing.mapFromEntity(type: item)
						}
						return AppAction.housingAction(action: .display(listHousing))
					default:
						return AppAction.housingAction(action: .display([HousingList(propertyType: "", area: 9, price: 9, city: "", urlImage: "")]))
					}
				}
				.eraseToAnyPublisher()
		default:
			break
		}
		return Empty().eraseToAnyPublisher()
		
//		let obj =  AppAction.housingAction(action: .display([HousingList(identifier: 0, propertyType: "ayech", area: 0, price: 0, city: "ezez", urlImage: "ezez", isSelected: false)]))
//		return Just(obj)
//			.subscribe(on: DispatchQueue.main)
//			.setFailureType(to: Error.self)
//			.eraseToAnyPublisher()
	}
}

