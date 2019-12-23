import UIKit

@objc(jp_encode_decode) class jp_encode_decode : CDVPlugin {
  @objc(EncodeWithSJIS:) // Declare your function name.
  func EncodeWithSJIS(command: CDVInvokedUrlCommand) { // write the function code.
            let encoder = JSONEncoder()

        if command.argument(at: 1) {
            print("Command 1 = ", command.argument(at: 1))
        }
        if  command.argument(at: 0) {
             print("Command 0 = ", command.argument(at: 0))
        }
        do {
            let m = "Command".data(using: .shiftJIS)
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
