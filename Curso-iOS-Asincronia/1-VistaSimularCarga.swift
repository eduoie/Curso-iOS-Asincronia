//
//  ContentView.swift
//  Curso-iOS-Asincronia
//
//  Created by Equipo 2 on 10/2/26.
//

import SwiftUI

struct VistaSimularCarga: View {
    @State private var mensaje = "Presiona el botón"
    @State private var cargando = false
    
    var body: some View {
        VStack(spacing: 20) {
            if cargando {
                ProgressView()
                    .controlSize(.large)
            }
            
            Text(mensaje)
                .font(.title2)
            
            Button("Simular descarga") {
                Task {
                    await procesarDescarga()
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(cargando)
            
            Button("Simular descarga bloqueante") {
                cargando = true
                mensaje = "Conectando con el servidor..."
                Thread.sleep(forTimeInterval: 2)
                cargando = false
                mensaje = "Datos cargados!"
            }
            .buttonStyle(.borderedProminent)
            
        }
    }
    
    func procesarDescarga() async {
        cargando = true
        mensaje = "Conectando al servidor..."
        
        // simular la carga con una espera
        try? await Task.sleep(for: .seconds(3))
        
        mensaje = "¡Datos recibidos! 📦"
        cargando = false
    }
}

#Preview {
    VistaSimularCarga()
}
