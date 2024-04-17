//   BirdListView.swift
//   FlyBird
//
//   Created by: Grant Perry on 4/11/24 at 10:22 AM
//     Modified:
//
//  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
//

import SwiftUI
import Observation

//
//struct USState {
//   let name: String
//   let abbreviation: String
//}




struct BirdListView: View {
   @State private var birds: [Bird] = []
   @State private var regionCode = "US-VA"
   @State private var selectedState: USState?

   var body: some View {
	  VStack {
		 Spacer()
		 HStack {
			Spacer()
			HStack {
			   Spacer()
			   Text("Total Birds Today: ")
			}
			HStack {
			   Text("\(birds.count)")
				  .foregroundColor(.red)
			}
			.padding(.trailing)
		 }

		 List(birds) { bird in
			VStack(alignment: .leading) {
			   Text(bird.comName)
				  .font(.title3)
				  .foregroundColor(.cyan)
			}
			HStack {
			 Spacer()
			   VStack(spacing: 0) {

				  Text(bird.sciName)
					 .font(.caption)
					 .foregroundColor(.white)
			   }
//			   Spacer()
			   Text(bird.locName)
				  .font(.caption)
				  .foregroundColor(.green)
			}
//			Spacer()
		 }
	  }
	  .safeAreaInset(edge: .top, spacing: 0) {
		 Picker("Select State", selection: $selectedState) {
			ForEach(states, id: \.abbreviation) { state in
			   Text(state.name).tag(state as USState?)
			}
		 }
		 .pickerStyle(.menu)
	  }
	  .padding(.bottom)
	  .task {
		 await updateBirdsForSelectedState()
	  }
	  .onChange(of: selectedState) {
		 Task { await updateBirdsForSelectedState() }
	  }
	  .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
   }


   func updateBirdsForSelectedState() async {
	  guard let selectedState = selectedState else { return }

	  do {
		 print("State: US-\(selectedState.abbreviation)")
		 fetchBirds(regionCode: "US-\(selectedState.abbreviation)") { result in
			switch result {
			   case .success(let birds):

				  DispatchQueue.main.async {
					 self.birds = birds
//					 					 print(birds)
				  }

			   case .failure(let error):
				  print("Error fetching birds: \(error)")
			}
		 }

	  }
   }
}




#Preview {
   BirdListView()
}





