//
//  VistaProcesoBloqueante.swift
//  Curso-iOS-Asincronia
//
//  Created by Equipo 2 on 10/2/26.
//

import SwiftUI

struct VistaProcesoBloqueante: View {
    @State private var resultado = "__"
    @State private var estaCalculando = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Ventana de cálculos")
                .font(.title)
            
            if estaCalculando {
                ProgressView("Procesando...")
                    .controlSize(.large)
                    .tint(.blue)
            }
            
            Text(resultado)
                .font(.headline)
            
            Button("Calcular (bloqueando)") {
                estaCalculando = true
                
                // Ejecuta la función en el main thread y lo
                // va a bloquear
                let resultadoCalculo = calculoPesado()
                
                estaCalculando = false
                resultado = "Calculado: \(resultadoCalculo)"
            }
            .buttonStyle(.bordered)
            .tint(.red)
            
            Button("Calcular con Task") {
                Task {
                    estaCalculando = true

                    // como la función calculoPesado() no tiene async, tenemos
                    // que llamarla de otra forma.
                    let resultadoCalculo = await Task.detached {
                        calculoPesado()
                    }.value
                    
                    resultado = "Calculado: \(resultadoCalculo)"
                    estaCalculando = false
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(estaCalculando)
        }
    }
    
    // nonisolated hace que la función no este atada a la vista o main thread.
    nonisolated func calculoPesado() -> Int {
        var conteo = 0
        for _ in 0..<20_000_000 {
            conteo += 1
        }
        return conteo
    }
    
}

#Preview {
    VistaProcesoBloqueante()
}
