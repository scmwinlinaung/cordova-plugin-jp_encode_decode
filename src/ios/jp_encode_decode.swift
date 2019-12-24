import UIKit

@objc(jp_encode_decode) class jp_encode_decode : CDVPlugin {
    @objc(EncodeWithSJIS:)
    func EncodeWithSJIS(command: CDVInvokedUrlCommand) {
        let text: String = command.argument(at: 0) as! String
        
        var text_sjis = text.data(using: .shiftJIS)
        var str_sjis: String = String(data: text_sjis!, encoding: .shiftJIS)!
        var pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "The Plugin Failed");
        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: str_sjis);
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
    }
    @objc(readCsvAndEncodeWithUTF8:)
    func readCsvAndEncodeWithUTF8(command: CDVInvokedUrlCommand) {
        if  (UserDefaults.standard.string(forKey: "csv_data") != "" && UserDefaults.standard.string(forKey: "csv_data") != nil) {
            var csv_data = UserDefaults.standard.string(forKey: "csv_data")!
            var text_utf8 = csv_data.data(using: .utf8)
            var str_utf8: String = String(data: text_utf8!, encoding: .utf8)!

            var pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "The Plugin Failed");
            pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: str_utf8);
            self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
        } else{
            var pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "The Plugin Failed");
            pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "");
            self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
        }
    }
    
    
    @objc(createCSVWithSJIS:)
    func createCSVWithSJIS(command: CDVInvokedUrlCommand) {
        var text: String = command.argument(at: 0) as! String
        var csvFileName: String = command.argument(at: 1) as! String
        var text_sjis = text.data(using: .shiftJIS)
        var str_sjis: String = String(data: text_sjis!, encoding: .shiftJIS)!
        do {
            var path = try FileManager.default.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil , create: false )
            var fileURL = path.appendingPathComponent("/AE report/" + csvFileName)
            try str_sjis.write(to: fileURL, atomically: true , encoding: .shiftJIS)
        } catch {
            print("error creating file")
        }
        
        var pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "The Plugin Failed");
        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: str_sjis);
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
    }
    
    @objc(getFileUrl:)
    func getFileUrl(command: CDVInvokedUrlCommand) {
        var fileUrl: URL
        fileUrl = UserDefaults.standard.url(forKey: "ios_url")!
        if fileUrl != nil {
            var pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "The Plugin Failed");
            pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: fileUrl.absoluteString)
            self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
        } else {
            var pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "The Plugin Failed");
            pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "")
            self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
        }
    }
}
