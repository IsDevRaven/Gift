//
//  ContentView.swift
//  Gift
//
//  Created by Wylder Quiceno on 21/10/23.
//

import SwiftUI

struct ContentView: View {
    @State private var nombreUsuario = "Margy"
    @State private var edadUsuario = "21"
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text(edadUsuario)
                    .font(.custom("HelveticaNeue-Bold", size: 50)) // Fuente personalizada y tamaño grande
                    .foregroundColor(.pink)
                    .padding(.top, 20) // Espacio entre "21" y el pastel
                
                Image("pastel-de-cumpleanos") // Reemplaza "tu_logo" con el nombre de tu imagen de logotipo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                //                    .padding(.top, 20) // Agrega espacio en la parte superior
                
                Spacer() // Agrega espacio entre las respuestas y el botón "Siguiente Pregunta"
                
                HStack {
                    Spacer()
                    Text("¡Feliz Cumpleaños, \(nombreUsuario)! ❤️")
                        .font(.custom("Chalkduster", size: 28))
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(.pink)
                    Spacer()
                }
                Text("Completa el cuestionario para ganar premios")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 20) // Agrega espacio en la parte inferior
                
                Spacer() // Agrega espacio entre las respuestas y el botón "Siguiente Pregunta"
                
                NavigationLink(destination: PreguntaView()) {
                    Text("Comenzar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.pink)
                        .cornerRadius(10)
                
                }.padding()
                
//                Button(action: {
//
//                }) {
//                    Text("Comenzar")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.pink)
//                        .cornerRadius(10)
//                }
            }
            .padding()
        }
    }
}

struct InicioView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//struct ContentView: View {
//    @State private var nombreUsuario = "Margy"
//        
//        var body: some View {
//            VStack {
//                Text("¡Feliz Cumpleaños, \(nombreUsuario)!").font(.largeTitle).fontWeight(.bold).multilineTextAlignment(.center)
//                TextField("Ingresa tu nombre", text: $nombreUsuario)
//                    .padding()
//                    .textFieldStyle(RoundedBorderTextFieldStyle())M
//                    .autocapitalization(.words)
//                    .disableAutocorrection(true)
//                    .font(.title)
//                
//                Button(action: {
//                    // Aquí puedes navegar a la siguiente vista donde se encuentra el cuestionario
//                    // Por ejemplo, usando NavigationLink o NavigationView
//                }) {
//                    Text("Comenzar")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                }
//            }
//            .padding()
//        }
//}
//
//struct InicioView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//#Preview {
//    ContentView()
//}
