//   Bird.swift
//   FlyBird
//
//   Created by: Grant Perry on 4/14/24 at 10:46 AM
//     Modified: 
//
//  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
//

import Foundation

// MARK: - Bird Structure
struct Bird: Decodable, Identifiable {
	let id: String?
	let speciesCode: String
	let comName: String
	let sciName: String
	let locId: String
	let locName: String
	let obsDt: Date  // Note: obsDt is not optional
	let latitude: Double?
	let longitude: Double?

	enum CodingKeys: String, CodingKey {
		case speciesCode, comName, sciName, locId, locName, obsDt, latitude, longitude
		case id = "obsId"
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		// Decode all properties:
		id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
		speciesCode = try container.decode(String.self, forKey: .speciesCode)
		comName = try container.decode(String.self, forKey: .comName)
		sciName = try container.decode(String.self, forKey: .sciName)
		locId = try container.decode(String.self, forKey: .locId)
		locName = try container.decode(String.self, forKey: .locName)
		latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
		longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)

		// Robust obsDt decoding:
		let dateString = try container.decode(String.self, forKey: .obsDt)
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z" // Your primary format

		if let date = dateFormatter.date(from: dateString) {
			obsDt = date
//			print(obsDt)
		} else {
			// Handle invalid obsDt:
			obsDt = Date() // Assign the current date (modify this as needed)
//			print("Invalid obsDt format for bird with id: \(id ?? "unknown")") // Optional error logging
		}
	}
}

//struct Bird: Decodable, Identifiable {
//   let id: String?
//   let speciesCode: String
//   let comName: String
//   let sciName: String
//   let locId: String
//   let locName: String
//   let obsDt: Date?
//   let latitude: Double?
//   let longitude: Double?
//
//   enum CodingKeys: String, CodingKey {
//	  case speciesCode, 
//		   comName,
//		   sciName,
//		   locId,
//		   locName,
//		   obsDt,
//		   latitude,
//		   longitude
//	  case id = "obsId"
//   }
//
//   init(from decoder: Decoder) throws {
//	  let container = try decoder.container(keyedBy: CodingKeys.self)
//	  id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
//	  speciesCode = try container.decode(String.self, forKey: .speciesCode)
//	  comName = try container.decode(String.self, forKey: .comName)
//	  sciName = try container.decode(String.self, forKey: .sciName)
//	  locId = try container.decode(String.self, forKey: .locId)
//	  locName = try container.decode(String.self, forKey: .locName)
//	  obsDt = try container.decode(Date.self, forKey: .obsDt)
//	  // Decode latitude and longitude if they are present in the JSON response.
//	  latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
//	  longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
//   }
//}

