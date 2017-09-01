import UIKit

class MConnect:Model<ArchConnect>
{
    var broadcastConnection: UDPBroadcastConnection?
    let requestPort:UInt16 = 9309

    func startWireless()
    {
        let hostName:String = getHostName()
        var reply:String = "HTTP/1.1 200 OK\r\n"
        reply.append("host-id:123456789012345678901234567890123456\r\n")
        reply.append("host-type:win\r\n")
        reply.append("host-name:vaux\r\n")
        reply.append("host-mtp-protocol-version:01500010\r\n")
        reply.append("host-request-port:9309\r\n")
        reply.append("host-wireless-protocol-version:01000000\r\n")
        reply.append("host-supported-device:PS Vita, PS Vita TV\r\n")
        reply.append("\0")
        
        guard
        
            let ip:String = getWiFiAddress()
        
        else
        {
            return
        }
        
        print(ip)
        
        print(hostName)
        
        if broadcastConnection != nil
        {
            print("connection working")
            
            broadcastConnection?.sendBroadcast(reply)
            
            return
        }
        
        broadcastConnection = UDPBroadcastConnection(port:requestPort)
        { (ipAddress:String, port:Int, response:[UInt8]) in
         
            print("Received from \(ipAddress):\(port):\n\n\(response)")
        }
    }
    
    func getHostName() -> String
    {
        return UIDevice.current.name
    }
    
    func getWiFiAddress() -> String? {
        var address : String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if  name == "en0" {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        
        return address
    }
}

class connection
{
    var response_source:DispatchSource?
    
    deinit
    {
        response_source?.cancel()
    }
}
