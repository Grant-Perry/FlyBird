//   fetchImageUrl.swift
//   FlyBird
//
//   Created by: Grant Perry on 4/19/24 at 2:13 PM
//     Modified: 
//
//  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
//

import SwiftUI

func wikiFormatBirdName(_ birdNameToFormat: String) -> String {
   return birdNameToFormat.prefix(1) + birdNameToFormat.suffix(birdNameToFormat.count - 1).lowercased()
}

// MARK: - MediaWiki API Image Fetching
func fetchImageUrl(forCommonName birdName: String) async throws -> URL? {
   // Ensure the birdName name is URL-encoded

   guard let encodedBirdName = birdName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
	  throw FetchError.encodingFailed
   }

   // Construct the full API request URL
   let apiBaseURL = "https://en.wikipedia.org/w/api.php"
   let query = "?action=query&generator=images&titles=\(encodedBirdName)&prop=imageinfo&iiprop=url&format=json"
   guard let apiRequestURL = URL(string: apiBaseURL + query) else {
	  throw FetchError.encodingFailed
   }
   print("apiRequestURL: \(apiRequestURL)")

   // Perform the network request
   let (data, response) = try await URLSession.shared.data(from: apiRequestURL)

   // Check if the HTTP response status code is successful
   guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
	  throw FetchError.jsonParsingFailed
   }

   // Parse the JSON data
   do {
	  let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
	  if let query = json?["query"] as? [String: Any],
		 let pages = query["pages"] as? [String: Any],
		 let firstPage = pages.values.first as? [String: Any],
		 let imageInfoArray = firstPage["imageinfo"] as? [[String: Any]],
		 let imageInfo = imageInfoArray.first,
		 let imageUrlString = imageInfo["url"] as? String {
		 return URL(string: imageUrlString)
	  } else {
		 return nil
	  }
   } catch {
	  throw FetchError.jsonParsingFailed
   }
}

enum FetchError: Error {
   case encodingFailed
   case jsonParsingFailed
}

