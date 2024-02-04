
import SwiftUI

struct PreguntaView2: View {
    @State private var contadorActivo = true
    @State private var tiempoRestante: TimeInterval = 3600
    @State private var respuestaSeleccionada: String = ""
    @State private var mostrarModal = false
    @State private var mensajeModal = ""
    @State private var codigoPremio = ["7K9p3RfG5A", "a2BcD3eFgH", "f3j2hdjdf2", "2fd4ou23"]
    @State private var respuestaSeleccionadaValida = false // Variable para realizar un seguimiento de si se ha seleccionado una respuesta válida
    @State private var numeroPregunta = 0
    @State private var pregunta = [

        "En mi jardín: \n\nTodas las flores menos dos son rosas. \nTodas las flores menos dos son tulipanes.\nTodas las flores menos dos son lirios. \n\n¿Cuántas flores tengo en mi jardín?",
        "Cual es tu color favorito",
        "Si tuvieras que viajar a un pais, cual seria?",
        "El auto de tus sueños?",
        "Te quieres casar conmigo??"
    ]

    @State private var respuestaCorrecta = ["3", "Rosa", "Monaco", "Ford Raptor", "Si"]
    @State private var respuestas = [
        ["4", "3", "6"],
        ["Rosa", "Amarillo", "Negro"],
        ["Francia", "Italia", "Monaco"],
        ["Nissan Sentra", "Ford Raptor", "Kia Rio"],
        ["Si", "No"]
    ]
    @State private var resultadoTotal = false
    
    
    struct FechaDesbloqueo {
        var year: Int
        var month: Int
        var day: Int
        var hour: Int
    }

    var fechasDesbloqueo: [FechaDesbloqueo] = [
        FechaDesbloqueo(year: 2023, month: 10, day: 21, hour: 19),
        FechaDesbloqueo(year: 2023, month: 10, day: 21, hour: 21),
        FechaDesbloqueo(year: 2023, month: 10, day: 21, hour: 21),
        FechaDesbloqueo(year: 2023, month: 10, day: 21, hour: 21)
        
    ]

    var fechaFinal: Date {
        let fecha = Calendar.current.date(from: DateComponents(year: fechasDesbloqueo[numeroPregunta].year, month: fechasDesbloqueo[numeroPregunta].month, day: fechasDesbloqueo[numeroPregunta].day, hour: fechasDesbloqueo[numeroPregunta].hour, minute: 0, second: 0))
        return fecha ?? Date()
    }

    var fechaIni: Date {
        return Date()
    }

    var tiempoTemp: Double {
        return fechaFinal.timeIntervalSince(fechaIni)
    }
    
    init() {
        _tiempoRestante = State(initialValue: Double(tiempoTemp))
    }
    
    var body: some View {
        VStack {
            if tiempoRestante > 0 {
                Text("Tiempo restante: \(Int(tiempoRestante)) segundos")
                    .font(.headline)
                    .padding()
            } else {
                if !resultadoTotal{
                    Text("Pregunta \(numeroPregunta + 1):")
                        .font(.custom("Chalkduster", size: 24))
                        .padding()
                        .foregroundColor(.pink)
                    Text(pregunta[numeroPregunta])
                        .padding()

                    Spacer()

                    ForEach(respuestas[numeroPregunta], id: \.self) { respuesta in
                        Button(action: {
                            respuestaSeleccionada = respuesta
                            respuestaSeleccionadaValida = true

                            if respuesta == respuestaCorrecta[numeroPregunta]{
                                mensajeModal = "¡Respuesta correcta! Aquí tienes tu código:"
                            }
                            else {
                                mensajeModal = "Respuesta incorrecta. Vuelve a intentarlo."
                            }
                        }) {
                            Text(respuesta)
                                .font(.headline)
                                .foregroundColor(respuestaSeleccionada == respuesta ? .white : .black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(respuestaSeleccionada == respuesta ? Color.pink : Color.gray)
                                .cornerRadius(10)
                        }
                        .padding(.vertical, 5)
                    }


                    Spacer()

                    if numeroPregunta < pregunta.count - 1{
                        Button(action: {
                            mostrarModal = true
                        }) {
                            Text("Siguiente Pregunta")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(respuestaSeleccionadaValida ? Color.pink : Color.gray) // Cambia el color del botón cuando está deshabilitado
                                .cornerRadius(10)
                        }
                        .disabled(!respuestaSeleccionadaValida)
                    } else {
                        Button(action: {
                            mostrarModal = true
                        }) {
                            Text("Finalizar")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(respuestaSeleccionadaValida ? Color.pink : Color.gray) // Cambiar el color
                                .cornerRadius(10)
                        }
                        .disabled(!respuestaSeleccionadaValida)
                    }

                } else {
                    Text("Codigos con regalos de cumpleaños:")
                        .font(.custom("Chalkduster", size: 24))
                        .padding()
                        .foregroundColor(.pink)

                    ScrollView {
                       ForEach(codigoPremio, id: \.self) { item in
                           HStack {
                               Text(item)
                               Spacer()
                               Button(action: {
//                                           copiarAlPortapapeles(texto: item)
                               }) {
                                   Image(systemName: "doc.on.doc.fill") // Ícono de copia
                               }
                           }
                           .padding()
                           .background(Color(UIColor.systemBackground))
                           .cornerRadius(5)
                           .shadow(radius: 2)
                       }
                   }

                }
            }
        }
        
        .onAppear {
            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if self.tiempoRestante > 0 {
                    self.tiempoRestante -= 1
                } else {
                    // Cuando el tiempo termina, detenemos el contador
                    timer.invalidate()
                    self.contadorActivo = false
                }
            }
            
            // Asegúrate de que el temporizador se ejecute incluso cuando el usuario navegue lejos de la vista actual
            RunLoop.current.add(timer, forMode: .common)
        }
        
        .alert(isPresented: $mostrarModal) {
            Alert(
                title: Text(mensajeModal),
                message: respuestaSeleccionada == respuestaCorrecta[numeroPregunta] ? Text(codigoPremio[numeroPregunta]): nil,
                dismissButton: respuestaSeleccionada == respuestaCorrecta[numeroPregunta] ? .default(Text("Copiar Codigo")){
                    UIPasteboard.general.string = codigoPremio[numeroPregunta]

                    if numeroPregunta < pregunta.count - 1{
                        numeroPregunta += 1
                        
                        var fechaFinal: Date {
                            let fecha = Calendar.current.date(from: DateComponents(year: fechasDesbloqueo[numeroPregunta].year, month: fechasDesbloqueo[numeroPregunta].month, day: fechasDesbloqueo[numeroPregunta].day, hour: fechasDesbloqueo[numeroPregunta].hour, minute: 0, second: 0))
                            return fecha ?? Date()
                        }
                        
                        var fechaIni: Date {
                            return Date()
                        }

                        var tiempoTemp: Double {
                            return fechaFinal.timeIntervalSince(fechaIni)
                        }
                        
                        self.tiempoRestante = tiempoTemp
                 
                        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                            if self.tiempoRestante > 0 {
                                self.tiempoRestante -= 1
                            } else {
                                // Cuando el tiempo termina, detenemos el contador
                                timer.invalidate()
                                self.contadorActivo = false
                            }
                        }
                        
                        respuestaSeleccionadaValida = false
                    } else if numeroPregunta == pregunta.count - 1{
                        resultadoTotal = true
                    }
                }: .default(Text("OK")){
                    // Realiza acciones adicionales en caso de que se seleccione "Salir"
                }
            )
        }
        .padding()
    }
}

struct ContentView_Previews2: PreviewProvider {
    static var previews: some View {
        PreguntaView2()
    }
}
