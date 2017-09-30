import Foundation

protocol DVitaItemExportProtocol
{
    var hasheableItem:Any? { get }
    
    func export(completion:@escaping((Data?) -> ()))
}
