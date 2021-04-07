import SwiftUI

struct ContentView: View {
	@EnvironmentObject var store: Store<AppState, AppAction>
	@State private var selection = 0
	var body: some View {
		let  housing = map(state: store.state, dispatch: store.dispatch)
		NavigationView {
			TabView(selection: $selection) {
				List(housing.housingList, id: \.identifier) { housing in
					ZStack {
						HousingCell(housing: housing)
						NavigationLink(destination: Text(housing.city ?? "")) {
							EmptyView()
						}.buttonStyle(PlainButtonStyle())
					}
				}
				.onAppear() {
					self.loadHousingAction()
				}
				.navigationBarTitle("Accueil", displayMode: .inline)
				.tabItem {
					Image(systemName: "house.fill")
					Text("Home")
				}
				.tag(0)
				
				Text("Favoris")
					.font(.system(size: 30, weight: .bold, design: .rounded))
					.tabItem {
						Image(systemName: "heart.circle")
						Text("Favoris")
					}
					.tag(1)
				
				Text("Paramètres")
					.font(.system(size: 30, weight: .bold, design: .rounded))
					.tabItem {
						Image(systemName: "wrench")
						Text("Paramètres")
					}
					.tag(2)
			}
			.accentColor(.red)
			.onAppear() {
				UITabBar.appearance().barTintColor = .white
			}
			.navigationBarTitle("SeLoger", displayMode: .inline)
		}
		.navigationViewStyle(StackNavigationViewStyle())
	}
}

extension ContentView {
	struct Housing {
		let housingList: [HousingList]
		let onHousingsFetch: () -> Void
	}
	
	func map(state: AppState, dispatch: @escaping (AppAction) -> Void) -> Housing {
		Housing(housingList: state.housingState.housingList ?? [], onHousingsFetch: {
			dispatch(AppAction.housingAction(action: .fetchListHousing))
		})
	}
	
	func loadHousingAction() {
		self.store.dispatch(.housingAction(action: .fetchListHousing))
	}
}
