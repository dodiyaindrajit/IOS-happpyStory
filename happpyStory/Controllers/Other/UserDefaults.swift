//
//  UserDefaults.swift
//  happpyStory
//
//  Created by karmaln technology on 19/01/22.
//

import Foundation

class Configuration {

    static func value<T>(defaultValue: T, forKey key: String) -> T{
        let preferences = UserDefaults.standard
        return preferences.object(forKey: key) == nil ? defaultValue : preferences.object(forKey: key) as! T
    }

    static func value(value: Any, forKey key: String){
        UserDefaults.standard.set(value, forKey: key)
    }

}


//
////set
//Configuration.value(value: "my_value", forKey: "key_1")
//
////get
//let myValue = Configuration.value(defaultValue: "default_value", forKey: "key_1")
