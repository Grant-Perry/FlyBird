//   fetchBirds.swift
//   FlyBird
//
//   Created by: Grant Perry on 4/11/24 at 3:41 PM
//     Modified:
//
//  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
//

import Foundation

//// Networking
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
//			print(birds)
			completion(.success(birds))
		 } catch {
			completion(.failure(error))
		 }
	  }
   }.resume()
}

func fetchBirdss(regionCode: String, completion: @escaping (Result<[Bird], Error>) -> Void) {
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
		 print("URLSession error: \(error)")
	  } else if let data = data {
		 do {
			// Handle potential decoding issues using `try?`
			let birds = try? decoder.decode([Bird].self, from: data)
			if let birds = birds {
			   completion(.success(birds))
			} else {
			   // Handle potential decoding failures with a default value or error
			   completion(.failure(NSError(domain: "BirdDecodingError", code: 1, userInfo: ["message": "Failed to decode birds data"])))
			}
		 }
	  }
   }.resume()
}
