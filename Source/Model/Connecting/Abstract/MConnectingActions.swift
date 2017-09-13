import Foundation

extension MConnecting
{
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
    
    func cancelTimer()
    {
        modelTimer.timer?.invalidate()
    }
}
