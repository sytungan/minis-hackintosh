// You need to change ACPI path to drive your i225 Ethernet 

DefinitionBlock ("", "SSDT", 2, "MacAbe", "I225-V", 0x00000000)
{
    External (_SB_.PCI0.RP02.D066, DeviceObj)

    Method (DTGP, 5, NotSerialized)
    {
        If ((Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b") /* Unknown UUID */))
        {
            If ((Arg1 == One))
            {
                If ((Arg2 == Zero))
                {
                    Arg4 = Buffer (One)
                        {
                             0x03                                             // .
                        }
                    Return (One)
                }

                If ((Arg2 == One))
                {
                    Return (One)
                }
            }
        }

        Arg4 = Buffer (One)
            {
                 0x00                                             // .
            }
        Return (Zero)
    }

    Scope (_SB.PCI0.RP02.D066)
    {
        If (_OSI ("Darwin"))
        {
            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If ((Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b") /* Unknown UUID */))
                {
                    Local0 = Package (0x14)
                        {
                            "AAPL,slot-name", 
                            Buffer (0x09)
                            {
                                "Built In"
                            }, 

                            "built-in", 
                            Buffer (One)
                            {
                                 0x00                                             // .
                            }, 

                            "model", 
                            Buffer (0x14)
                            {
                                "Intel I225-V 2.5GbE"
                            }, 

                            "name", 
                            Buffer (0x09)
                            {
                                "Ethernet"
                            }, 

                            "vendor-id", 
                            Buffer (0x04)
                            {
                                 0x86, 0x80, 0x00, 0x00                           // ....
                            }, 

                            "device-id", 
                            Buffer (0x04)
                            {
                                 0xF3, 0x15, 0x00, 0x00                           // ....
                            }, 

                            "subsystem-vendor-id", 
                            Buffer (0x04)
                            {
                                 0x43, 0x10, 0x00, 0x00                           // C...
                            }, 

                            "subsystem-id", 
                            Buffer (0x04)
                            {
                                 0xD2, 0x87, 0x00, 0x00                           // ....
                            }, 

                            "revision-id", 
                            Buffer (0x04)
                            {
                                 0x03, 0x00, 0x00, 0x00                           // ....
                            }, 

                            "IOName", 
                            "pci8086,15f3"
                        }
                    DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                    Return (Local0)
                }

                Return (Zero)
            }
        }
    }
}

