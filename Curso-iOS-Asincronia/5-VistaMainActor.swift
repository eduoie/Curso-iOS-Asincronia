//
//  VistaMainActor.swift
//  Curso-iOS-Asincronia
//
//  Created by Equipo 2 on 10/2/26.
//

import SwiftUI


/* @MainActor asegura que las actualizaciones de la interfaz ocurran en el hilo principal.
 Se puede anotar:
 - La clase entera
 - Funciones específicas
 - Se puede usar la palabra clave 'nonisolated' para excluir métodos específicos de la ejecución en el hilo principal.
 */
@MainActor
@Observable
class UsuarioViewModel {
    var nombreUsuario = "Cargando..."
    
    func actualizarNombreUsuario() async {
        // Simulamos una descarga de internet
        try? await Task.sleep(for: .seconds(2))
        
        nombreUsuario = "Pepito pérez"
    }
}

struct VistaMainActor: View {
    @State private var viewModel = UsuarioViewModel()
    
    var body: some View {
        Text(viewModel.nombreUsuario)
            .task {
                await viewModel.actualizarNombreUsuario()
            }
    }
}

#Preview {
    VistaMainActor()
}
