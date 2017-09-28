enum MVitaPtpCommand:UInt16
{
    case unknown
    case openSession                    = 4098
    case closeSession                   = 4099
    case success                        = 8193
    case error                          = 8194
    case requestVitaInfo                = 38161
    case sendResult                     = 38168
    case sendLocalInfo                  = 38172
    case requestSettings                = 38180
    case requestItemStatus              = 38184
    case sendLocalStatus                = 38186
    case sendStorageSize                = 38195
    case requestItemTreat               = 38196
    case requestVitaCapabilities        = 38203
    case sendLocalCapabilities          = 38204
    case requestItemPropertyValue       = 38915
}
