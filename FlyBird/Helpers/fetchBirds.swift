//   fetchBirds.swift
//   FlyBird
//
//   Created by: Grant Perry on 4/11/24 at 3:41 PM
//     Modified: 
//
//  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
//

import Foundation

func fetchBirds(regionCode: String) async throws -> [Bird] {
   let apiKey = APIConstants.eBirdAPIKey

   var urlComponents = URLComponents(string: "https://api.ebird.org/v2/data/obs/\(regionCode)/recent")!
   urlComponents.queryItems = [/* Additional query items if needed */]
   guard let url = urlComponents.url else {
	  throw URLError(.badURL)
   }

   var request = URLRequest(url: url)
   request.addValue(apiKey, forHTTPHeaderField: "X-eBirdApiToken")

   let dateFormatter = DateFormatter()
   dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

   let (data, response) = try await URLSession.shared.data(for: request) // Correctly use the request with the header

   guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
	  throw URLError(.badServerResponse)
   }

   let decoder = JSONDecoder()
   decoder.dateDecodingStrategy = .formatted(dateFormatter)
   let birds = try decoder.decode([Bird].self, from: data)
   return birds
}
