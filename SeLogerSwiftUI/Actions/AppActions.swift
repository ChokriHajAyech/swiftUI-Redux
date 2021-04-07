import Foundation

enum AppAction {
	case housingAction(action: HousingAction)
	case settingInfos(action: SettingAction)
}

enum HousingAction {
	case fetchListHousing
	case displayDetails(_ housingDetails: HousingDetails)
	case display(_ housingList: [HousingList])
}

enum  SettingAction {
	case display(_ settingInfos: SettingInfos)
}
