# cordova-print

This is a cordova plugin that allows you to print to Zebra bluetooth printers using your iOS device.

**Get printer serial number:**  
`window.plugins.print.getPrinter(successCallback(serial),failCallback(error))`  

**Print a zpl-formatted block of text (need serial number!):**
`window.plugins.print.print(successCallback(ok),failCallback(error),serial, label)`

Example:

    var label = '^XA' +
    '^F030,30^FDTest Label^FS' +
    '^XZ';
    var errorCallback = function(err) { console.error(err) }
    
    window.plugins.print.getPrinter(function(serial) { // Get the serial number
      window.plugins.print.print(function(success) {   // Call the print method
        console.log('Successfully printed label');
      }, errorCallback(err), serial, label);           // Include the serial number and your ZPL format label
    }, errorCallback(err));                            // Log any errors
  
