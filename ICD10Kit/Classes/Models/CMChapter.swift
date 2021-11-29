//
//  CMChapter.swift
//  ICD10Kit
//
//  Created by Francis Li on 11/29/21.
//

import Foundation
import RealmSwift

class CMChapter: Object {
    @Persisted(primaryKey: true) var name: String?
    @Persisted var desc: String?
    @Persisted(originProperty: "chapter") var sections: LinkingObjects<CMSection>
}
