//
//  MusicView.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 11/18/23.
//

import SwiftUI
import AVFoundation


struct MusicView: View {
    @ObservedObject var countManager: CountManager
    @StateObject private var musicViewModel = MusicViewModel()
    
    
    let questionText = "What is the name of this song?"
    @State private var player: AVPlayer?
    @State private var songTitle = "N/A"
    @State private var songURL = "N/A"
    @State private var songArtist = ""
    @State private var userInput: String = ""
    
    @State private var isPlaying = false
    
    var titleMatch: Bool {
        if userInput.lowercased() == songTitle.lowercased(){
            print("Correct")
            return true
        }
        print("Incorrect")
        return false
    }
    
    
    var body: some View {
        
        VStack {
            
            Text(questionText)
                .font(Font.custom("Inter", size: 15))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(.top, 20)
            
            //fill in the action once we have logic to generate the music sample
            Button(action: {
                if isPlaying {
                    player?.pause()
                } else {
                    if let url = musicViewModel.songURL {
                        player = AVPlayer(url: url)
                        player?.play()
                    }
                }
                // Toggle the play state
                isPlaying.toggle()
            })  {
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
            }
            .onDisappear {
                // Stop the player when the view disappears
                player?.pause()
                isPlaying = false
           }
            
            //created in Dog ImageView
            TextInputView(userInput: $userInput)

            
        }
        .onAppear {
//            print("Selected Artist: \(musicViewModel.selectedArtist)")
            songArtist = musicViewModel.selectedArtist
            musicViewModel.fetchMusicData{}
        }
        .onReceive(musicViewModel.$title) { newTitle in
            songTitle = newTitle ?? "N/A"
            print("Song title: \(songTitle)")
        }
        .onChange(of: userInput) {
            countManager.answer = titleMatch
            countManager.loseMessage = "What I'M hearing now is that you're not a human."
        }
        
    }
    
}


#Preview {
    MusicView(countManager: CountManager())
}
