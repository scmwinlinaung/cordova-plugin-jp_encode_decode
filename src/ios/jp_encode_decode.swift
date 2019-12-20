import UIKit

@objc(jp_encode_decode) class jp_encode_decode : CDVPlugin {
  @objc(EncodeWithSJIS:) // Declare your function name.
  func EncodeWithSJIS(command: CDVInvokedUrlCommand) { // write the function code.
            let encoder = JSONEncoder()
            print("command.arguments![0] = ", command.arguments![0])
        do {
            let m = "販売名不明のインスリン製剤ブランク(空文字)".data(using: .shiftJIS)
            let SJISEncoded_json = try! JSONEncoder().encode(m)
            let SJISEncoded_jsonString = String(data: SJISEncoded_json, encoding: .shiftJIS)!
            print("SJISEncoded_jsonString = ", SJISEncoded_jsonString)
            // let base64SJISEncoded = SJISEncoded_jsonString.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range: nil)
            var pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "The Plugin Failed");
            // Set the plugin result to succeed.
                pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: base64SJISEncoded);
            // Send the function result back to Cordova.
            self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
        }
    

  }
}
