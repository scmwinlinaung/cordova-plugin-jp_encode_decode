import UIKit

@objc(jp_encode_decode) class jp_encode_decode : CDVPlugin {
    @objc(EncodeWithSJIS:)
    func EncodeWithSJIS(command: CDVInvokedUrlCommand) {
        let text: String = command.argument(at: 0) as! String
        
        var text_sjis = text.data(using: .shiftJIS)
        var str_sjis: String = String(data: text_sjis!, encoding: .shiftJIS)!
        print("str_sjis = ", str_sjis)
        
        var pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "The Plugin Failed");
        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: str_sjis);
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
    }
    @objc(DecodeWithSJISAndEncodeWithUTF8:)
    func DecodeWithSJISAndEncodeWithUTF8(command: CDVInvokedUrlCommand) {
        var url = UserDefaults.standard.url(forKey: "ios_url")
        var fileUrl: String = url!.absoluteString
        var csvLines = [String]()
        var str_utf8: String
        do {
            let csvString = try String(contentsOfFile: fileUrl, encoding: String.Encoding.shiftJIS)
            var text_utf8 = csvString.data(using: .utf8)
            str_utf8 = String(data: text_utf8!, encoding: .utf8)!
            
        } catch let error as NSError {
            print("err = \(error)")
            return
        }
        var pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "The Plugin Failed");
        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: str_utf8);
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
    }
    @objc(createCSVWithSJIS:)
    func createCSVWithSJIS(command: CDVInvokedUrlCommand) {
        var text: String = command.argument(at: 0) as! String
        var csvFileName: String = command.argument(at: 1) as! String
        var text_sjis = text.data(using: .shiftJIS)
        var str_sjis: String = String(data: text_sjis!, encoding: .shiftJIS)!
        print("str_sjis 1 = ", str_sjis)
        
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
}
