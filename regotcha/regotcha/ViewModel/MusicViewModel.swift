//
//  MusicViewModel.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 11/19/23.
//

import Foundation
//import MusicKit

// this will control the logic of how we generate random songs and will play the audio for
// ussers to guess. we may use the following imports along with musickit to help us do this
//import AVFoundation
//import MediaPlayer

class MusicViewModel: ObservableObject {
    @Published var selectedArtist: String = ["Michael Jackson", "Deftones", "Johnny Goth", "Daniel Caesar", "Bad Bunny" ].randomElement() ?? "Nirvana" // including nirvana as option
    
    @Published var title: String?
    @Published var songURL: URL?

    
    func fetchMusicData(completion: @escaping () -> Void) {
        
        let headers = [
            "X-RapidAPI-Key": "45afc605e3mshc946fb02dd19860p16ce9djsn5f7d3c11c2c6",
            "X-RapidAPI-Host": "deezerdevs-deezer.p.rapidapi.com"
        ]
        
//        print("URLLL: https://deezerdevs-deezer.p.rapidapi.com/search?q=\(selectedArtist)")
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://deezerdevs-deezer.p.rapidapi.com/search?q=\(selectedArtist)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            
            // ensure there is data returned from this HTTP response
            guard let jsonData = data else {
                print("No data")
                return
            }
            
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                print("JSON Data:\n\(jsonString)")
//            } 
//            
            
            do{
                let musicData = try JSONDecoder().decode(MusicData.self, from: jsonData)
                
                // Update UI on the main thread
                DispatchQueue.main.async {
                    
                    if let firstSong = musicData.data.first{
                        self.songURL = URL(string: firstSong.preview)
                        self.title = firstSong.title
                    }
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
            }
            
            
            
        })
        
        dataTask.resume()
    }
}
