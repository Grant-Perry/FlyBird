//   fetchBirds.swift
//   FlyBird
//
//   Created by: Grant Perry on 4/11/24 at 3:41 PM
//     Modified: 
//
//  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
//

import Foundation

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
			 print("Error decoding birds: \(error)")
			 if let decodingError = error as? DecodingError {
				 print("Decoding Error Context:", decodingError.localizedDescription)
			 }
			completion(.failure(error))
		 }
	  }
   }.resume()
}
