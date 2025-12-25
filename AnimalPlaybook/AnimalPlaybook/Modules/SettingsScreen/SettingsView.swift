
import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Sound")) {
                    Toggle("Enable Sound", isOn: Binding(
                        get: { viewModel.isSoundEnabled },
                        set: { viewModel.setSoundEnabled($0) }
                    ))
                }
                
                Section(header: Text("Display")) {
                    Picker("Display Style", selection: Binding(
                        get: { viewModel.currentDisplayStyle },
                        set: { viewModel.setDisplayStyle($0) }
                    )) {
                        ForEach(DisplayStyle.allCases, id: \.self) { style in
                            Text(style.rawValue).tag(style)
                        }
                    }
                }
                
                Section(header: Text("Game")) {
                    HStack {
                        Text("Best Score")
                        Spacer()
                        Text("\(viewModel.bestScore)")
                            .foregroundColor(.accentColor)
                            .fontWeight(.semibold)
                    }
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Animals")
                        Spacer()
                        Text("\(viewModel.animalsWithSoundsCount)")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Facts")
                        Spacer()
                        Text("\(AnimalFact.sampleFacts.count)")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel())
}

