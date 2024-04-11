////   Bird.swift
////   FlyBird
////
////   Created by: Grant Perry on 4/11/24 at 11:35 AM
////     Modified: 
////
////  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
////
//
//import SwiftUI
//import Observation
//
//struct Bird: Decodable, Identifiable {
//   let id: String
//   let speciesCode: String
//   let comName: String
//   let sciName: String
//   let locId: String
//   let locName: String
//   let obsDt: Date
//   // Add other properties you might use from the JSON response here (e.g., howMany)
//
//   enum CodingKeys: String, CodingKey {
//	  case id = "obsId"
//	  case speciesCode
//	  case comName
//	  case sciName
//	  case locId
//	  case locName
//	  case obsDt
//	  // Add keys for other properties if needed
//   }
//
//   init(from decoder: Decoder) throws {
//	  let container = try decoder.container(keyedBy: CodingKeys.self)
//	  self.id = try container.decode(String.self, forKey: .id)
//	  self.speciesCode = try container.decode(String.self, forKey: .speciesCode)
//	  self.comName = try container.decode(String.self, forKey: .comName)
//	  self.sciName = try container.decode(String.self, forKey: .sciName)
//	  self.locId = try container.decode(String.self, forKey: .locId)
//	  self.locName = try container.decode(String.self, forKey: .locName)
//	  let dateString = try container.decode(String.self, forKey: .obsDt)
//	  let dateFormatter = DateFormatter()
//	  dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//	  self.obsDt = dateFormatter.date(from: dateString)! // Force unwrapping assuming valid format (handle potential errors if needed)
//   }
//}
