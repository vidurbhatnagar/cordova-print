# cordova-print

This is a Cordova plugin that allows you to print to Zebra bluetooth printers using your iOS device.

Installation:
`cordova plugin add https://github.com/LiamBateman/cordova-print.git`

**Get printer serial numbers: (Will return all connected zebra printers)**  
`window.plugins.print.getPrinters(successCallback(serialNumbers),failCallback(error))`  

Example return for 2 printers 'XXXXXXXX1,XXXXXXXX2'

**Print a zpl-formatted block of text (need serial number!):**
`window.plugins.print.print(successCallback(ok),failCallback(error),serial, label)`

Example:

```JavaScript
var label = '^XA' +
    '^F030,30^FDTest Label^FS' +
    '^XZ';
var errorCallback = function(err) { console.error(err) }

window.plugins.print.getPrinters(function(serialNumbers) { // Get the connect printer serial numbers
  //Now split the serial numbers
  var serialArray = serialNumbers.split(',');
  serialArray = serialArray.filter(function(n){ return n != undefined && n != '' });

  serialArray.forEach(function(curSerial) {
    window.plugins.print.print(function(success) {   // Call the print method
      console.log('Successfully printed label');
    }, errorCallback(err), curSerial, label);           // Include the serial number and your ZPL format label

  });

}, errorCallback);                            // Log any errors


```

If you have a problem where your printer is printing several labels, you need to calibrate it. In my case, I was using the black-line marked labels, so I simply printed the following ZPL code to calibrate it:

```JavaScript
var calibrate = '~JC' +
    '^XA' +
    '^JUS' +
    'XZ';
```
