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

// Networking
func fetchBirds(regionCode: String, completion: @escaping (Result<[Bird], Error>) -> Void) {
   let apiKey = APIConstants.eBirdAPIKey

   var urlComponents = URLComponents(string: "https://api.ebird.org/v2/data/obs/\(regionCode)/recent")!
   urlComponents.queryItems = [
	  // Add additional query items if needed
   ]

   var request = URLRequest(url: urlComponents.url!)
   request.addValue(apiKey, forHTTPHeaderField: "X-eBirdApiToken")

   let dateFormatter = DateFormatter()
   dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // Match eBird's date/time format

   let decoder = JSONDecoder()
   decoder.dateDecodingStrategy = .formatted(dateFormatter)

   URLSession.shared.dataTask(with: request) { (data, response, error) in
	  if let error = error {
		 completion(.failure(error))
	  } else if let data = data {
		 do {
			let birds = try decoder.decode([Bird].self, from: data)
			completion(.success(birds))
		 } catch {
			completion(.failure(error))
		 }
	  }
   }.resume()
}

// SwiftUI View
struct BirdListView: View {
   @State private var birds: [Bird] = []
   @State private var regionCode = "US-VA"

   var body: some View {
	  List(birds) { bird in
		 VStack(alignment: .leading) {
			Text(bird.comName)

			HStack {
			   Text(bird.locName)
				  .font(.caption)

			   Text(bird.obsDt, style: .date)
				  .font(.caption)
			}
		 }
	  }
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
