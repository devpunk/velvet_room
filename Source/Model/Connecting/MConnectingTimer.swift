import Foundation

final class MConnectingTimer
{
    weak var timer:Timer?
    weak var model:MConnecting?
    private let kTimeout:TimeInterval = 31
    
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
        model?.stopConnection()
    }
}
