import Foundation

extension MConnected
{
    //MARK: internal
    
    func start(vitaLink:MVitaLink)
    {
        self.vitaLink = vitaLink
        vitaLink.delegate = self
    }
    
    func cancelAndClean()
    {
        vitaLink?.cancel()
        vitaLink = nil
    }
    
    func foundError(errorMessage:String)
    {
        cancelAndClean()
        statusError(errorMessage:errorMessage)
        view?.updateStatus()
    }
}