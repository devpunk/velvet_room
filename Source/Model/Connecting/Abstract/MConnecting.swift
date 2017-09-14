import Foundation

final class MConnecting:Model<ArchConnecting>
{
    var status:MConnectingStatusProtocol?
    var modelPin:MConnectingPin?
    let socket:MConnectingSocket
    private(set) var modelTimer:MConnectingTimer
    
    required init()
    {
        socket = MConnectingSocket()
        modelTimer = MConnectingTimer()
        super.init()
        
        statusLoading()
        modelTimer.model = self
        socket.model = self
    }
    
    deinit
    {
        cancelAndClean()
    }
}
