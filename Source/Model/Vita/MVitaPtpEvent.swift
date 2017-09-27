enum MVitaPtpEvent:UInt16
{
    case unknown
    case requestItemStatus              = 49423
    case requestSettings                = 49426
    case sendStorageSize                = 49433
    case requestTreatItem               = 49442
    case terminate                      = 49446
}
