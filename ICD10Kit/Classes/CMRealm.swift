//
//  CMRealm.swift
//  ICD10Kit
//
//  Created by Francis Li on 11/29/21.
//

import Foundation
import RealmSwift

open class CMRealm {
    public static var main: Realm!
    public static var mainURL: URL?
    public static var mainMemoryIdentifier: String? = "main.realm"
    public static var isMainReadOnly = false
    
    public static func configure(url: URL?, isReadOnly: Bool) {
        CMRealm.main = nil
        CMRealm.mainURL = url
        CMRealm.isMainReadOnly = isReadOnly
        CMRealm.mainMemoryIdentifier = url != nil ? nil : "main.realm"
    }

    public static func open() -> Realm {
        if Thread.current.isMainThread && CMRealm.main != nil {
            if !CMRealm.main.configuration.readOnly {
                CMRealm.main.refresh()
            }
            return CMRealm.main
        }
        let config = Realm.Configuration(fileURL: mainURL,
                                         inMemoryIdentifier: CMRealm.mainMemoryIdentifier,
                                         readOnly: CMRealm.isMainReadOnly,
                                         objectTypes: [CMChapter.self, CMSection.self, CMCode.self])
        let realm = try! Realm(configuration: config)
        if Thread.current.isMainThread {
            CMRealm.main = realm
        }
        return realm
    }
}
