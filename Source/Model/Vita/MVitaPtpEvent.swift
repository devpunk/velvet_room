enum MVitaPtpEvent:UInt16
{
    case unknown
    case sendItemsCount                 = 49412
    case sendItemsMetaData              = 49413
    case requestItemStatus              = 49423
    case sendItemThumb                  = 49424
    case requestSettings                = 49426
    case sendStorageSize                = 49433
    case requestItemTreat               = 49442
    case terminate                      = 49446
    case itemPropertyChanged            = 51201
}
