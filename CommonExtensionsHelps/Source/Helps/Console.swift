//
//  Console.swift
//  CommonExtensionsHelps
//
//  Created by 胡毅 on 2020/4/28.
//  Copyright © 2020 Hy. All rights reserved.
//
import Foundation

final public class Console {
    
    public static let log = Console()

    public func verbose<T>(_ msg: T, file : String = #file, lineNumber : Int = #line, function: String = #function) {
        self.printf(msg, .verbose, file, lineNumber, function)
    }
    
    public func debug<T>(_ msg: T, file : String = #file, lineNumber : Int = #line, function: String = #function) {
        self.printf(msg, .debug, file, lineNumber, function)
    }
    
    public func info<T>(_ msg: T, file : String = #file, lineNumber : Int = #line, function: String = #function) {
        self.printf(msg, .info, file, lineNumber, function)
    }
    
    public func warning<T>(_ msg: T, file : String = #file, lineNumber : Int = #line, function: String = #function) {
        self.printf(msg, .warning, file, lineNumber, function)
    }
    
    public func error<T>(_ msg: T, file : String = #file, lineNumber : Int = #line, function: String = #function) {
        self.printf(msg, .error, file, lineNumber, function)
    }
    
    public static func verbose<T>(_ msg: T, file : String = #file, lineNumber : Int = #line, function: String = #function) {
        log.printf(msg, .verbose, file, lineNumber, function)
    }
    
    public static func debug<T>(_ msg: T, file : String = #file, lineNumber : Int = #line, function: String = #function) {
        log.self.printf(msg, .debug, file, lineNumber, function)
    }
    
    public static func info<T>(_ msg: T, file : String = #file, lineNumber : Int = #line, function: String = #function) {
        log.self.printf(msg, .info, file, lineNumber, function)
    }
    
    public static func warning<T>(_ msg: T, file : String = #file, lineNumber : Int = #line, function: String = #function) {
        log.self.printf(msg, .warning, file, lineNumber, function)
    }
    
    public static func error<T>(_ msg: T, file : String = #file, lineNumber : Int = #line, function: String = #function) {
        log.self.printf(msg, .error, file, lineNumber, function)
    }
    
    public func printf<T>(_ msg: T,
                          _ level: Console.Level = .verbose,
                          _ file : String = #file,
                          _ lineNumber : Int = #line,
                          _ function: String = #function) {
        #if DEBUG
        let name = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String ?? String(describing: Console.self)
        let fileName = (file as NSString).lastPathComponent
        let file_suffixs = [".swift", ".h", ".m"]
        var _file = ""
        file_suffixs.forEach{
            if fileName.hasSuffix($0) {
                _file = fileName.replacingOccurrences(of: $0, with: "")
            }
        }
        print("[\(name)] \(level.mapMark())【\(level.mapDes())】[\(_file).\(function):\(lineNumber)] -> \(msg)")
        #endif
    }
    
    private init() { }
    
}

public extension Console {
    enum Level: Int {
        case verbose = 1
        case debug = 2
        case info = 3
        case warning = 4
        case error = 5
        
       fileprivate func mapMark() -> String {
            switch self {
            case .verbose: return "💜"
            case .debug: return "💚"
            case .info: return "💙"
            case .warning: return "💛"
            case .error: return "♥️"
            }
        }
        fileprivate func mapDes() -> String {
            switch self {
            case .verbose: return "VERBOSE"
            case .debug: return "DEBUG"
            case .info: return "INFO"
            case .warning: return "WARNING"
            case .error: return "ERROR"
            }
        }
    }
}
