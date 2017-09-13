import Foundation

final class MConnecting:Model<ArchConnecting>
{
    var status:MConnectingStatusProtocol?
    private(set) var modelPin:MConnectingPin?
    private(set) var modelTimer:MConnectingTimer?
    
    required init()
    {
        super.init()
        statusLoading()
        
        modelTimer = MConnectingTimer(model:self)
    }
    
    deinit
    {
        modelTimer?.timer?.invalidate()
    }
    
    //MARK: internal
    
    func createPin()
    {
        modelPin = MConnectingPin()
        statusPin()
        view?.updateStatus()
    }
    
    func stopConnection()
    {
        statusTimeout()
        view?.updateStatus()
    }
}
