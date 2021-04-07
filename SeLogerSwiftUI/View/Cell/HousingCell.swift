
import SwiftUI

struct HousingCell: View {
	let housing: HousingList!
	let imgPlaceHolder = "imagePlaceholder"
	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			if let housing = housing {
				URLImage(url: housing.urlImage ?? "",
						 placeholder: imgPlaceHolder)
				Text(housing.propertyType ?? "")
				Text("\(housing.area ?? 0)")
				Text("\(housing.price ?? 0)")
				Text(housing.city ?? "")
			}
		}
	}
}

struct HousingCell_Previews: PreviewProvider {
	static var previews: some View {
		HousingCell(
			housing: HousingList(
				identifier: 0, propertyType: "propertyType",
				area: 300.9, price: 600000.89, city: "Paris", urlImage: "imagePlaceholder",
				isSelected: true)
		)
	}
}
