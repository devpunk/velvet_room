import Foundation

struct MVitaItem
{
    let treat:MVitaItemTreat
    var elements:[MVitaItem]?
    var format:MVitaItemFormat?
    var dateModified:Date?
    var name:String?
}
