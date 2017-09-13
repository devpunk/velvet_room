import Foundation

final class MConnecting:Model<ArchConnecting>
{
    var status:MConnectingStatusProtocol?
    var modelPin:MConnectingPin?
    private(set) var modelTimer:MConnectingTimer
    
    required init()
    {
        modelTimer = MConnectingTimer()
        super.init()
        
        statusLoading()
        modelTimer.model = self
    }
    
    deinit
    {
        modelTimer.timer?.invalidate()
    }
}
