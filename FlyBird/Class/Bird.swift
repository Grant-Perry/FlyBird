//   Bird.swift
//   FlyBird
//
//   Created by: Grant Perry on 4/11/24 at 11:35 AM
//     Modified: 
//
//  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
//

import SwiftUI
import Observation

//@Observable
//class Bird: Decodable, Identifiable {
//   let id: String?
//   let speciesCode: String?
//   let comName: String
//   let sciName: String
//   let locId: String?
//   let locName: String
//   let obsDt: Date
//
//   enum CodingKeys: String, CodingKey {
//	  case id = "obsId"
//	  case speciesCode
//	  case comName
//	  case sciName
//	  case locId
//	  case locName
//	  case obsDt
//   }
//
//   required init(from decoder: Decoder) throws {
//	  let container = try decoder.container(keyedBy: CodingKeys.self)
//	  self.id = try container.decode(String.self, forKey: .id)
//	  self.speciesCode = try container.decode(String.self, forKey: .speciesCode)
//	  self.comName = try container.decode(String.self, forKey: .comName)
//	  self.sciName = try container.decode(String.self, forKey: .sciName)
//	  self.locId = try container.decode(String.self, forKey: .locId)
//	  self.locName = try container.decode(String.self, forKey: .locName)
//	  self.obsDt = try container.decode(Date.self, forKey: .obsDt)
//   }
//
////   init(comName: String, sciName: String, locName: String, obsDt: Date) {
////	  self.comName = comName
////	  self.sciName = sciName
////	  self.locName = locName
////	  self.obsDt = obsDt
////   }
//}
//
//@Observable
//class BirdData {
//   var birds: [Bird] = []
//
//   init(birds: [Bird]) {
//	  self.birds = birds
//   }
//
//   init() { } // Add an empty initializer
//}
