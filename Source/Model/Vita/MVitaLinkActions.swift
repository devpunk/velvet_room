import Foundation

extension MVitaLink
{
    //MARK: internal
    
    func cancel()
    {
        linkCommand.cancel()
        linkEvent.cancel()
    }
}
