//
//  GameViewModel.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 11/9/23.
//

import Foundation

/// This is the viewmodel for GameView  -- this is only a template for now until we make the actual API calls
class GameViewModel: ObservableObject {
    
//    @Published var gameInfo: [GameData] = []
    
    @MainActor
    func getGameData(completion: @escaping () -> Void) {
                
        //boiler plate API code
        let headers = [
            "X-RapidAPI-Key": "",
            "X-RapidAPI-Host": ""
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print("Error: \(error)")
            }
            
            // DECODE THE DATA ONCE WE HAVE STRUCTS AND API CALLS DEFINED
            
//            else if let data = data {
//                do {
//                    let decoder = JSONDecoder()
//                    let gameDataArray = try decoder.decode([GameData].self, from: data)
//                    DispatchQueue.main.async {
//                        self.gameInfo = gameDataArray
//                        completion()
//                    }
//                } catch {
//                    print("Error decoding JSON: \(error)")
//                }
//            }
            
        })
        
        dataTask.resume()
        
    }
}

