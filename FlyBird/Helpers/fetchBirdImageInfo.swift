////   fetchBirdImageInfo.swift
////   FlyBird
////
////   Created by: Grant Perry on 4/19/24 at 6:29 PM
////     Modified: 
////
////  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
////
//
//import SwiftUI
//
//func wikiFormattedCommonName(commonName: String) -> String {
//   return commonName.prefix(1) + commonName.suffix(commonName.count - 1).lowercased()
//}
//
//private func fetchBirdImageInfo(for birdSighting: Bird, fetchImage: Bool) async -> String? {
//   let baseURL = "https://en.wikipedia.org/w/api.php"
//   var urlComponents = URLComponents(string: baseURL)
//   let commonName = wikiFormattedCommonName()
//
//   urlComponents?.queryItems = [
//	  URLQueryItem(name: "action", value: "query"),
//	  URLQueryItem(name: "format", value: "json"),
//	  URLQueryItem(name: "prop", value: "pageimages"),
//	  URLQueryItem(name: "titles", value: commo0.n Name),
//	  URLQueryItem(name: "pithumbsize", value: "200")
//   ]
//
//   guard let url = urlComponents?.url else {
//	  print("Invalid URL")
//	  return nil
//   }
//
//   do {
//	  let (data, _) = try await URLSession.shared.data(from: url)
//
//	  if let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any],
//		 let query = jsonObject["query"] as? [String: Any],
//		 let pages = query["pages"] as? [String: Any],
//		 let page = pages.values.first as? [String: Any],
//		 let thumbnail = page["thumbnail"] as? [String: Any],
//		 let imageURL = thumbnail["source"] as? String {
//
//		 return imageURL
//	  } else {
//		 print("Failed to extract image URL from the response.")
//		 return nil
//	  }
//   } catch {
//	  print("Error fetching data or decoding JSON: \(error)")
//	  return nil
//   }
//}
