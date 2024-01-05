//
//  RotationGameView.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 12/1/23.
//
//
import SwiftUI
import SpriteKit

struct RotationGameView: View {
    @ObservedObject var countManager: CountManager
    @State private var rotationAngle: Double = [0, 45, 90, 135, 180, 225, 270, 315].randomElement() ?? 0 // randomly generate initialial angle
    let questionText = "Orient the frog."
    
    var anglesMatch: Bool {
        return rotationAngle == 0
    }

    var body: some View {
        VStack {
            
            Text(questionText)
                .font(Font.custom("Inter", size: 15))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(.top, 40)
                .padding(.bottom, -70)
            
            Spacer()
            
            
            SpriteKitView(rotationAngle: $rotationAngle)
                .frame(width: 200, height: 200)

            Button("Rotate") {
                rotateShape()
            }
            .font(
                Font.custom("Inter", size: 18)
                    .weight(.bold)
            )
            .foregroundColor(.white)
            .frame(width: 141, height: 50)
            .background(Color(red: 0.22, green: 0.35, blue: 0.47))
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.25, green: 0.47, blue: 0.22), lineWidth: 1)
            )
            .padding()
            .onChange(of: rotationAngle) {
                // Check the lose condition when the rotation angle changes
                countManager.answer = anglesMatch
                if rotationAngle != 0 {
                    countManager.loseMessage = "Only robots can't tell how to frog wants to sit. Do better."
                }
            }
        }
 
        
    }

    private func rotateShape() {
        rotationAngle += 45
        // to keep the angle between [0,360)
        rotationAngle = rotationAngle.truncatingRemainder(dividingBy: 360)
        
        print("ROTATION \(rotationAngle)")
    }
}
  

struct SpriteKitView: UIViewRepresentable {
    @Binding var rotationAngle: Double

    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        let scene = SKScene(size: CGSize(width: 1500, height: 1500))
        scene.backgroundColor = .white

        
        let imageNode = SKSpriteNode(imageNamed: "frog")
        imageNode.name = "ImageNode"
        imageNode.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2) //place it in the center
        scene.addChild(imageNode)

        skView.presentScene(scene)

        return skView
    }

    func updateUIView(_ uiView: SKView, context: Context) {
        uiView.scene?.childNode(withName: "//ImageNode")?.zRotation = CGFloat(rotationAngle * .pi / 180.0)
    }
}


struct RotationGameView_Previews: PreviewProvider {
    static var previews: some View {
        RotationGameView(countManager: CountManager())
    }
}
