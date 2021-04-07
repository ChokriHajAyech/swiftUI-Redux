import Foundation

struct AppState {
	var housingState: HousingState
	var settingingState: SettingingState
}

struct HousingState {
	var housingList: [HousingList]?
	var housingDetails: HousingDetails?
}

struct SettingingState {
	var  settingInfos: SettingInfos?
}
