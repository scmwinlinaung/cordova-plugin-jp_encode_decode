import UIKit

@objc(jp_encode_decode) class jp_encode_decode : CDVPlugin {
    @objc(readCsvAndEncodeWithUTF8:)
    func readCsvAndEncodeWithUTF8(command: CDVInvokedUrlCommand) {
        if  (UserDefaults.standard.string(forKey: "csv_data") != "" && UserDefaults.standard.string(forKey: "csv_data") != nil) {
            let csv_data = UserDefaults.standard.string(forKey: "csv_data")!
            let text_utf8 = csv_data.data(using: .utf8)
            let str_utf8: String = String(data: text_utf8!, encoding: .utf8)!

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
        let text: String = command.argument(at: 0) as! String
        let csvFileName: String = command.argument(at: 1) as! String
        let text_sjis = text.data(using: .shiftJIS)
        let str_sjis: String = String(data: text_sjis!, encoding: .shiftJIS)!
        do {
            let path = try FileManager.default.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil , create: false )
            let fileURL = path.appendingPathComponent("/AE report/" + csvFileName)
            try str_sjis.write(to: fileURL, atomically: true , encoding: .shiftJIS)
        } catch {
            print("error creating file")
        }
        
        var pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "The Plugin Failed");
        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: str_sjis);
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
    }
}
