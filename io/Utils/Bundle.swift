//
//  Bundle.swift
//  io
//
//  Created by gv on 21/08/2023.
//

import Foundation

extension Bundle {
    var resource: Bundle {
        // static framework
        if let resourceURL = resourceURL,
           let resourceBundle = Bundle(url: resourceURL.appendingPathComponent(ModuleName.name + ".bundle")) {
            return resourceBundle
        } else {
            // dynamic framework
            return self
        }
    }
}

private struct ModuleName {
    static var name: String = {
        String(reflecting: ModuleName.self).components(separatedBy: ".").first ?? ""
    }()
}

func printD(_ string : Any) {
    #if DEBUG
    print(string)
    #endif
}
