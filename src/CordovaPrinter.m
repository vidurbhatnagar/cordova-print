//
//  CordovaPrinter.m
//  HelloCordova
//
//  Created by Liam Bateman on 24/03/2015.
//
//

#import "CordovaPrinter.h"
#import <ExternalAccessory/ExternalAccessory.h>
#import "MfiBtPrinterConnection.h"
#import "ZebraPrinterConnection.h"
#import "MFiBtPrinterConnection.h"
#import "ZebraPrinterFactory.h"

@implementation CordovaPrinter
    - (BOOL) cordovaPrint:(NSString *)labelData{
  
        NSString *serial;
        
        //First find the printer
        EAAccessoryManager *sam = [EAAccessoryManager sharedAccessoryManager];
        NSArray * connectedAccessories = [sam connectedAccessories];
        
        for (EAAccessory *accessory in connectedAccessories) {
            if ([accessory.protocolStrings indexOfObject:@"com.zebra.rawport"] != NSNotFound){
                serial = accessory.serialNumber;
                break;
                //Note: This will find the first printer connected! If you have multiple Zebra printers connected, you should display a list to the user and have him select the one they wish to use
            }
        }

        id<ZebraPrinterConnection, NSObject> connection = nil;
        connection = [[MfiBtPrinterConnection alloc] initWithSerialNumber:serial];
    
        BOOL didOpen = [connection open];
        BOOL returnVal = NO;
    
        if(didOpen == YES) {
        
            NSError *error = nil;
            id<ZebraPrinter,NSObject> printer = [ZebraPrinterFactory getInstance:connection error:&error];
        
            if(printer != nil) {
                PrinterLanguage language = [printer getPrinterControlLanguage];
            
                BOOL sentOK = [self printTestLabel:language onConnection:connection withError:&error];
                if (sentOK == YES) {
                    returnVal = YES;
                } else {
                
                }
            } else {
            
            }
        }else {
        
        }   
    
    [connection close];
    return returnVal;
}

-(BOOL)printTestLabel:(PrinterLanguage) language onConnection:(id<ZebraPrinterConnection, NSObject>)connection withError:(NSError**)error {
    NSString *testLabel;
    if (language == PRINTER_LANGUAGE_ZPL) {
        testLabel = @"^XA^FO17,16^GB379,371,8^FS^FT65,255^A0N,135,134^FDTEST^FS^XZ";
        NSData *data = [NSData dataWithBytes:[testLabel UTF8String] length:[testLabel length]];
        [connection write:data error:error];
    } else if (language == PRINTER_LANGUAGE_CPCL) {
        testLabel = @"! 0 200 200 406 1\r\nON-FEED IGNORE\r\nBOX 20 20 380 380 8\r\nT 0 6 137 177 TEST\r\nPRINT\r\n";
        NSData *data = [NSData dataWithBytes:[testLabel UTF8String] length:[testLabel length]];
        [connection write:data error:error];
    }
    if(*error == nil){
        return YES;
    } else {
        return NO;
    }
}

-(NSString*) getLanguageName :(PrinterLanguage)language {
    if(language == PRINTER_LANGUAGE_ZPL){
        return @"ZPL";
    } else {
        return @"CPCL";
    }
}


@end
