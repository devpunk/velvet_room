import Foundation

final class MConnectingTimer
{
    weak var model:MConnecting?
    private weak var timer:Timer?
    private let kTimeout:TimeInterval = 20
    
    init()
    {
        timer = Timer.scheduledTimer(
            timeInterval:kTimeout,
            target:self,
            selector:#selector(selectorTimeout(sender:)),
            userInfo:nil,
            repeats:false)
    }
    
    deinit
    {
        timer?.invalidate()
    }
    
    //MARK: selectors
    
    @objc
    private func selectorTimeout(sender timer:Timer)
    {
        timedOut()
    }
    
    //MARK: private
    
    private func timedOut()
    {
        timer?.invalidate()
        model?.connectionTimedout()
    }
    
    //MARK: internal
    
    func cancel()
    {
        timer?.invalidate()
    }
}
