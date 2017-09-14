import Foundation

final class MConnecting:Model<ArchConnecting>
{
    var status:MConnectingStatusProtocol?
    var modelPin:MConnectingPin?
    var socket:MConnectingSocket?
    private(set) var modelTimer:MConnectingTimer
    
    required init()
    {
        modelTimer = MConnectingTimer()
        super.init()
        
        statusLoading()
        socket = MConnectingSocket(model:self)
        modelTimer.model = self
    }
    
    deinit
    {
        cancelAndClean()
    }
}
