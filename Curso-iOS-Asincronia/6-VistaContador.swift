//
//  VistaContador.swift
//  Curso-iOS-Asincronia
//
//  Created by Equipo 2 on 10/2/26.
//

import SwiftUI

@MainActor
@Observable
class ContadorViewModel {
    var valor = 0
    var estaContando = false
    
    func iniciarConteo() async {
        valor = 0 // Reiniciamos el contador
        estaContando = true
        
        for cuenta in 1...10 {
            try? await Task.sleep(for: .seconds(1))
            
            valor = cuenta
        }
        
        estaContando = false
    }
}


struct VistaContador: View {
    @State private var viewModel = ContadorViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Contador")
                .font(.largeTitle)
            
            Text("\(viewModel.valor)")
                .font(.system(size: 80))
                .bold()
                .foregroundStyle(viewModel.estaContando ? .blue : .gray)
            
            if viewModel.estaContando {
                ProgressView("Contando hasta 10")
                    .controlSize(.large)
            } else {
                Button("Empezar cuenta") {
                    Task { await viewModel.iniciarConteo() }
                }
                .buttonStyle(.bordered)
            }
        } // Con .task empieza al abrir la vista
        .task { await viewModel.iniciarConteo() }
    }
}

#Preview {
    VistaContador()
}
