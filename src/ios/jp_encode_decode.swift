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
    @objc(DecodeWithSJISAndEncodeWithUTF8:)
    func DecodeWithSJISAndEncodeWithUTF8(command: CDVInvokedUrlCommand) {
        let text: String = command.argument(at: 0) as! String
        var text_utf8 = text.data(using: .utf8)
        var str_utf8: String = String(data: text_utf8!, encoding: .utf8)!
        var pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "The Plugin Failed");
        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: str_utf8);
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
    }
}
