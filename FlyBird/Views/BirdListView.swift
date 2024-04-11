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

struct Bird: Decodable, Identifiable {
   let id = UUID()
   let comName: String
   let sciName: String
   let locName: String
   let obsDt: Date // Using Date type
}


//
//// SwiftUI View
struct BirdListView: View {
   @State private var birds: [Bird] = []
   @State private var regionCode = "US-VA"

   var body: some View {
	  VStack {
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

			   HStack {
				  Text(bird.locName)
					 .font(.caption)
					 .foregroundColor(.green)
				  Spacer()
				  Text(bird.obsDt, style: .date)
					 .font(.caption)
			   }
			}
		 }
		 .navigationTitle("Birds Today")
	  }
	  .padding(.bottom)
	  .task {
		 fetchBirds(regionCode: regionCode) { result in
			switch result {
			   case .success(let birds):
				  self.birds = birds
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





