//
//  CMSection.swift
//  ICD10Kit
//
//  Created by Francis Li on 11/29/21.
//

import Foundation
import RealmSwift

class CMSection: Object {
    @Persisted(primaryKey: true) var id: String?
    @Persisted var desc: String?
    @Persisted var first: String?
    @Persisted var last: String?
    @Persisted var chapter: CMChapter?
}
