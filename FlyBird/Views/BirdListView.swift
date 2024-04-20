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

struct BirdListView: View {
   @State private var birds: [Bird] = [/*  Empty  */]
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
			HStack {
			   if let imageUrl = bird.imageUrl {
				  AsyncImage(url: imageUrl) { image in
					 image.resizable().scaledToFit()
						.clipShape(Circle())

				  } placeholder: {
					 Image("defaultBirdImage").resizable().scaledToFit()
						.clipShape(Circle())


				  }
				  .frame(width: 125, height: 125)
			   } else {
				  Image("defaultBirdImage").resizable().scaledToFit()
					 .frame(width: 50, height: 50)
					 .clipShape(Circle())
			   }
			}
			VStack(alignment: .leading) {
			   Text(bird.commonName)
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

	  let dateFormatter = DateFormatter()
	  dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // Match eBird's date/time format

	  do {
		 let birdData = try await fetchBirds(regionCode: "US-\(selectedState.abbreviation)")
		 birds = birdData // update the birds with the decoded ebird data

//		 print("BIRDS: \(birds)")

		 try await withThrowingTaskGroup(of: Void.self) { taskGroup in
			for index in birds.indices {
			   taskGroup.addTask {
				  print("Fetching: \( birds[index].commonName)")
				  if let imageUrl = try await fetchImageUrl(forCommonName: wikiFormatBirdName(birds[index].commonName)) {
					 DispatchQueue.main.async {
						self.birds[index].imageUrl = imageUrl // Update the specific bird's imageUrl
					 }
				  }
			   }
			}
			try await taskGroup.waitForAll()
			DispatchQueue.main.async {
			   self.birds = birds // Update the birds array with potentially populated image URLs
			}
		 }
	  } catch {
		 print("Error decoding birds or fetching images: \(error)\nBIRDS: \(birds)")
	  }
   }

}




#Preview {
   BirdListView()
}





