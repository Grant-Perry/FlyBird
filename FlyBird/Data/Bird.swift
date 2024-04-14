//   Bird.swift
//   FlyBird
//
//   Created by: Grant Perry on 4/14/24 at 10:46 AM
//     Modified: 
//
//  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
//

import Foundation

struct Bird: Decodable, Identifiable {
   let id: String?
   let speciesCode: String
   let comName: String
   let sciName: String
   let locId: String
   let locName: String
   let obsDt: Date
   let latitude: Double?
   let longitude: Double?

   enum CodingKeys: String, CodingKey {
	  case speciesCode, comName, sciName, locId, locName, obsDt, latitude, longitude
	  case id = "obsId"
   }

   init(from decoder: Decoder) throws {
	  let container = try decoder.container(keyedBy: CodingKeys.self)
	  id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
	  speciesCode = try container.decode(String.self, forKey: .speciesCode)
	  comName = try container.decode(String.self, forKey: .comName)
	  sciName = try container.decode(String.self, forKey: .sciName)
	  locId = try container.decode(String.self, forKey: .locId)
	  locName = try container.decode(String.self, forKey: .locName)
	  obsDt = try container.decode(Date.self, forKey: .obsDt)
	  // Decode latitude and longitude if they are present in the JSON response.
	  latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
	  longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
   }
}

