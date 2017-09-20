import Foundation

final class MVitaLinkEvent:MVitaLinkSocket
{
    //MARK: internal
    
    func request(requestCommand:MVitaPtpMessageInRequestCommand)
    {
        let message:MVitaPtpMessageOutRequestEvent = MVitaPtpMessageOutRequestEvent(
            requestCommand:requestCommand)
        writeMessage(message:message)
    }
}
