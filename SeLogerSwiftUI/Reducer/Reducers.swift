import Foundation

func reducer(state: inout AppState, action: AppAction) -> Void {
	switch action {
	case .housingAction(action: let action):
		housingReducer(state: &state.housingState, action: action)
	case .settingInfos(action: let action):
		settingReducer(state: &state.settingingState, action: action)
	}
}

func housingReducer(state: inout HousingState, action: HousingAction) {
	switch action {
	case .displayDetails(let housingDetails):
		state.housingDetails = housingDetails
	case .display(let housingList):
		state.housingList = housingList
	case .fetchListHousing:
		state.housingList = []
	}
}

func settingReducer(state: inout SettingingState, action:  SettingAction) {
	switch action {
	case .display(let settingInfos):
		state.settingInfos = settingInfos
	}
}
