//
//  CMCode.swift
//  ICD10Kit
//
//  Created by Francis Li on 11/29/21.
//

import Foundation
import RealmSwift

class CMCode: Object {
    @Persisted(primaryKey: true) var name: String?
    @Persisted var desc: String?
    @Persisted var parent: CMCode?
    @Persisted(originProperty: "parent") var children: LinkingObjects<CMCode>
    @Persisted var depth: Int?
    @Persisted var lft: Int?
    @Persisted var rgt: Int?
}
