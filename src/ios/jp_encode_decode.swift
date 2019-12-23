import UIKit

@objc(jp_encode_decode) class jp_encode_decode : CDVPlugin {
    @objc(EncodeWithSJIS:) // Declare your function name.
    func EncodeWithSJIS(command: CDVInvokedUrlCommand) { // write the function code.
        let encoder = JSONEncoder()
        let text: String
        if (command.argument(at: 1) != nil) {
            print("Command 1 = ", command.argument(at: 1))
        }
        if  (command.argument(at: 0) != nil) {
            print("Command 0 = ", command.argument(at: 0) as! String)
            text = command.argument(at: 0) as! String
            do {
                let m = text.data(using: .shiftJIS)
                let SJISEncoded_json = try! JSONEncoder().encode(m)
                let SJISEncoded_jsonString = String(data: SJISEncoded_json, encoding: .shiftJIS)!
                print("SJISEncoded_jsonString = ", SJISEncoded_jsonString)
                // let base64SJISEncoded = SJISEncoded_jsonString.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range: nil)
                var pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "The Plugin Failed");
                // Set the plugin result to succeed.
                pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: SJISEncoded_jsonString);
                // Send the function result back to Cordova.
                self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
            }
        }
        
    }
    @objc(DecodeWithSJISAndEncodeWithUTF8:) // Declare your function name.
    func DecodeWithSJISAndEncodeWithUTF8(command: CDVInvokedUrlCommand) {
        if  (command.argument(at: 0) != nil) {
            
            do {
                let base64SJISEncoded = command.argument(at: 0) as! String
                let SJISDecodedData = Data(base64Encoded: base64SJISEncoded.data(using: .shiftJIS)!)
                let SJISDecodedString = String(data: SJISDecodedData!, encoding: .shiftJIS)!
                print("SJISDecodedString = ",SJISDecodedString)
                let s1 = "\"\(SJISDecodedString)\""
                let s2 = s1.data(using: .utf8)
                
                
                let UTF8Encode_json = try! JSONEncoder().encode(s2)
                let UTF8Encode_jsonString = String(data: UTF8Encode_json, encoding: .utf8)
                print("UTF8Encode_jsonString = ", UTF8Encode_jsonString)
                
                let base64UTF8Encoded =  UTF8Encode_jsonString!.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range: nil)
                let UTF8DecodedData = Data(base64Encoded: base64UTF8Encoded)
                let UTF8DecodedString = String(data: UTF8DecodedData!, encoding: .utf8)!
                print("UTF8DecodedString = ", UTF8DecodedString)
                
                var pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "The Plugin Failed");
                // Set the plugin result to succeed.
                pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: UTF8DecodedString);
                // Send the function result back to Cordova.
                self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
            }
            
        }
    }
    
}
