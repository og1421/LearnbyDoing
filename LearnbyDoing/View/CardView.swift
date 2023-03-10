//
//  CardView.swift
//  LearnbyDoing
//
//  Created by Orlando Moraes Martins on 23/02/23.
//

import SwiftUI

struct CardView: View {
    //MARK: - Properties
    var card: Card
    
    @State private var fadeIn = false
    @State private var moveDownward: Bool = false
    @State private var moveUpward = false
    @State private var showAlert = false
    
    var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    
    //MARK: - Body
    var body: some View {
        ZStack{
            Image(card.imageName)
                .opacity(fadeIn ? 1.0 : 0)
            
            VStack{
                Text(card.title)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text(card.headline)
                    .fontWeight(.light)
                    .foregroundColor(Color.white)
                    .italic()
            }//: Vstack
            .offset(y: moveDownward ?  -218 : -300)
            
            
            Button {
                //Action
                playSound(soundName: "sound-chime", type: "mp3")
                self.hapticImpact.impactOccurred()
                self.showAlert.toggle()
            } label: {
                HStack {
                    Text(card.callToAction.uppercased())
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                        .accentColor(.white)
                    
                    Image(systemName: "arrow.right.circle")
                        .font(Font.title.weight(.medium))
                        .accentColor(.white)
                }//: Hstack
                .padding(.vertical)
                .padding(.horizontal, 24)
                .background(LinearGradient(gradient: Gradient(colors: card.gradientColors), startPoint: .leading, endPoint: .trailing))
                .clipShape(Capsule())
                .shadow(color: Color("ColorShadow"), radius: 6, x: 0, y: 3)
            }
            .offset(y: moveUpward ? 210 : 300)
            
        }//: HSTACK
        .frame(width: 335, height: 545)
        .background(LinearGradient(gradient: Gradient(colors: card.gradientColors), startPoint: .top, endPoint: .bottom))
        .cornerRadius(16)
        .shadow(radius: 8)
        .onAppear(){
            withAnimation(.linear(duration: 1.2)) {
                self.fadeIn.toggle()
            }
            
            withAnimation(.linear(duration: 0.8)) {
                self.moveDownward.toggle()
                self.moveUpward.toggle()
            }
        }
        .alert(isPresented: $showAlert ) {
            Alert(
                title: Text(card.title),
                message: Text(card.message),
                dismissButton: .default(Text("Ok")))
            
        }
    }//:Zstack
}

//MARK: - Preview
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: cardData[3])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
