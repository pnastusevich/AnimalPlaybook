import Foundation
import OSLog

enum LogLevel: String {
    case debug = "🔍 DEBUG"
    case info = "ℹ️ INFO"
    case warning = "⚠️ WARNING"
    case error = "❌ ERROR"
    case success = "✅ SUCCESS"
}

class LoggerService {
    static let shared = LoggerService()
    
    private let logger: Logger
    private let dateFormatter: DateFormatter
    
    private init() {
        let subsystem = Bundle.main.bundleIdentifier ?? "com.animalplaybook"
        logger = Logger(subsystem: subsystem, category: "AnimalPlaybook")
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    }
    
    private func logInternal(_ message: String, level: LogLevel, category: String, file: String, function: String, line: Int) {
        let fileName = (file as NSString).lastPathComponent
        let timestamp = dateFormatter.string(from: Date())
        let logMessage = "[\(timestamp)] \(level.rawValue) [\(category)] \(fileName):\(line) \(function) - \(message)"
        
        print(logMessage)
        
        switch level {
        case .debug:
            logger.debug("\(logMessage)")
        case .info:
            logger.info("\(logMessage)")
        case .warning:
            logger.warning("\(logMessage)")
        case .error:
            logger.error("\(logMessage)")
        case .success:
            logger.info("\(logMessage)")
        }
    }
    
    func debug(_ message: String, category: String, file: String = #file, function: String = #function, line: Int = #line) {
        logInternal(message, level: .debug, category: category, file: file, function: function, line: line)
    }
    
    func info(_ message: String, category: String, file: String = #file, function: String = #function, line: Int = #line) {
        logInternal(message, level: .info, category: category, file: file, function: function, line: line)
    }
    
    func warning(_ message: String, category: String, file: String = #file, function: String = #function, line: Int = #line) {
        logInternal(message, level: .warning, category: category, file: file, function: function, line: line)
    }
    
    func error(_ message: String, category: String, file: String = #file, function: String = #function, line: Int = #line) {
        logInternal(message, level: .error, category: category, file: file, function: function, line: line)
    }
    
    func success(_ message: String, category: String, file: String = #file, function: String = #function, line: Int = #line) {
        logInternal(message, level: .success, category: category, file: file, function: function, line: line)
    }
}


