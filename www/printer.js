function print() {
}

print.prototype.getPrinter = function(successCallback, errorCallback) {
  cordova.exec(successCallback,
            errorCallback,
            'CordovaPrinter',
            'cordovaGetPrinters');
};

print.prototype.print = function(successCallback, errorCallback, serialNumber, labelData) {
  cordova.exec(successCallback,
             errorCallback,
             'CordovaPrinter',
             'cordovaPrint', [labelData, serialNumber]);
};

print.install = function() {
  if (!window.plugins) {
    window.plugins = {};
  }

  window.plugins.print = new print();
  return window.plugins.print;
};

cordova.addConstructor(print.install);
