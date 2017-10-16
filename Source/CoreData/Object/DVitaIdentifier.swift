import Foundation

extension DVitaIdentifier
{
    //MARK: internal
    
    func config(identifier:String)
    {
        self.identifier = identifier
        created = Date().timeIntervalSince1970
    }
}
