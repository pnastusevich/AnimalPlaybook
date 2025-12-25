

import Foundation

struct SoundsAnimal: Identifiable {
    let id = UUID()
    let fileName: String
    let displayName: String
    let fileExtension: String
    
    var fullFileName: String {
        "\(fileName).\(fileExtension)"
    }
    
    var emoji: String {
        getEmoji(for: fileName.lowercased())
    }
    
    private func getEmoji(for name: String) -> String {
        switch name {
        case "ant": return "🐜"
        case "bear": return "🐻"
        case "bee": return "🐝"
        case "butterfly": return "🦋"
        case "cat": return "🐱"
        case "chicken": return "🐔"
        case "cow": return "🐄"
        case "crow": return "🐦‍⬛"
        case "dog": return "🐶"
        case "duck": return "🦆"
        case "eagle": return "🦅"
        case "elephant": return "🐘"
        case "fox": return "🦊"
        case "frog": return "🐸"
        case "goat": return "🐐"
        case "goose": return "🪿"
        case "grasshopper": return "🦗"
        case "hedgehog": return "🦔"
        case "horse": return "🐴"
        case "jaguar": return "🐆"
        case "ladybug": return "🐞"
        case "lion": return "🦁"
        case "owl": return "🦉"
        case "panda": return "🐼"
        case "parrot": return "🦜"
        case "peacock": return "🦚"
        case "penguin": return "🐧"
        case "pig": return "🐷"
        case "shark": return "🦈"
        case "spider": return "🕷️"
        case "tiger": return "🐅"
        case "wolf": return "🐺"
        default: return "🔊"
        }
    }
    
    static func loadAllSounds() -> [SoundsAnimal] {
        var soundFiles: [SoundsAnimal] = []
        
        let allKnownSounds: [(String, String)] = [
            ("ant", "mp3"),
            ("bear", "mp3"),
            ("bee", "mp3"),
            ("butterfly", "mp3"),
            ("cat", "m4a"),
            ("chicken", "mp3"),
            ("cow", "mp3"),
            ("crow", "m4a"),
            ("dog", "mp3"),
            ("duck", "mp3"),
            ("eagle", "mp3"),
            ("elephant", "mp3"),
            ("fox", "mp3"),
            ("frog", "mp3"),
            ("goat", "mp3"),
            ("goose", "m4a"),
            ("grasshopper", "mp3"),
            ("hedgehog", "m4a"),
            ("horse", "mp3"),
            ("jaguar", "mp3"),
            ("ladybug", "mp3"),
            ("lion", "m4a"),
            ("owl", "m4a"),
            ("panda", "mp3"),
            ("parrot", "mp3"),
            ("peacock", "mp3"),
            ("penguin", "mp3"),
            ("pig", "mp3"),
            ("shark", "mp3"),
            ("spider", "mp3"),
            ("tiger", "mp3"),
            ("wolf", "mp3")
        ]
        
        if let resourcePath = Bundle.main.resourcePath {
            let soundsPath = (resourcePath as NSString).appendingPathComponent("Sounds")
            let fileManager = FileManager.default
            
            if fileManager.fileExists(atPath: soundsPath),
               let files = try? fileManager.contentsOfDirectory(atPath: soundsPath) {
                let soundExtensions = ["mp3", "m4a", "wav", "aiff"]
                
                for file in files {
                    let components = file.split(separator: ".")
                    guard components.count == 2,
                          let fileName = components.first?.lowercased(),
                          let fileExtension = components.last?.lowercased(),
                          soundExtensions.contains(String(fileExtension)) else {
                        continue
                    }
                    
                    if soundFiles.contains(where: { $0.fileName == fileName && $0.fileExtension == fileExtension }) {
                        continue
                    }
                    
                    let displayName = formatDisplayName(String(fileName))
                    soundFiles.append(SoundsAnimal(
                        fileName: String(fileName),
                        displayName: displayName,
                        fileExtension: String(fileExtension)
                    ))
                }
            }
        }
        
        for (fileName, fileExtension) in allKnownSounds {
            if soundFiles.contains(where: { $0.fileName == fileName && $0.fileExtension == fileExtension }) {
                continue
            }
            
            if Bundle.main.url(forResource: fileName, withExtension: fileExtension, subdirectory: "Sounds") != nil {
                let displayName = formatDisplayName(fileName)
                soundFiles.append(SoundsAnimal(
                    fileName: fileName,
                    displayName: displayName,
                    fileExtension: fileExtension
                ))
            } else if Bundle.main.url(forResource: fileName, withExtension: fileExtension) != nil {
                let displayName = formatDisplayName(fileName)
                soundFiles.append(SoundsAnimal(
                    fileName: fileName,
                    displayName: displayName,
                    fileExtension: fileExtension
                ))
            } else {
                let displayName = formatDisplayName(fileName)
                soundFiles.append(SoundsAnimal(
                    fileName: fileName,
                    displayName: displayName,
                    fileExtension: fileExtension
                ))
            }
        }
        
        return soundFiles.sorted { $0.displayName < $1.displayName }
    }
    
    private static func formatDisplayName(_ name: String) -> String {
        let formatted = name.capitalized
        return formatted
    }
}
