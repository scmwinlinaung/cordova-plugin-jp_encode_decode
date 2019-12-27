import UIKit

@objc(jp_encode_decode) class jp_encode_decode : CDVPlugin {

    @objc(createCSVWithSJIS:)
    func createCSVWithSJIS(command: CDVInvokedUrlCommand) { 
        var returnMessage = "";

        let text: String = command.argument(at: 0) as! String
        let csvFolderName: String = command.argument(at: 1) as! String
        let csvFileName: String = command.argument(at: 2) as! String

        do {
            let text_sjis = text.data(using: .shiftJIS)
            let str_sjis: String = String(data: text_sjis!, encoding: .shiftJIS)!
            let path = try FileManager.default.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil , create: false )
            let fileURL = path.appendingPathComponent(csvFolderName + csvFileName)
            try str_sjis.write(to: fileURL, atomically: true , encoding: .shiftJIS)
        } catch {
            print("createCSVWithSJIS error ", error)
        }
        
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: returnMessage);
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
    }

    @objc(readCsvAndEncodeWithUTF8:)
    func readCsvAndEncodeWithUTF8(command: CDVInvokedUrlCommand) {
        var returnMessage = "";

        if  (UserDefaults.standard.string(forKey: "csv_data") != "" && UserDefaults.standard.string(forKey: "csv_data") != nil) {
            let csv_data = UserDefaults.standard.string(forKey: "csv_data")!
            let text_utf8 = csv_data.data(using: .utf8)
            returnMessage = String(data: text_utf8!, encoding: .utf8)!
        }

        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: returnMessage);
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
    }

}
