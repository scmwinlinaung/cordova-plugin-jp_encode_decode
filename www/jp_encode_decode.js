var exec = require('cordova/exec');

var PLUGIN_NAME = "jp_encode_decode"; // This is just for code completion uses.

var jp_encode_decode = function() {}; // This just makes it easier for
 // us to export all of the functions at once.
// All of your plugin functions go below this. 
// Note: We are not passing any options in the [] block for this, so make sure you include the empty [] block.
jp_encode_decode.EncodeWithSJIS = function(EncodeDecodeData, onSuccess, onError) {
   EncodeDecodeData = EncodeDecodeData || {};
   EncodeDecodeData.text =  EncodeDecodeData.text || "販売名不明のインスリン製剤ブランク(空文字)"
   EncodeDecodeData.csvEncodedData = EncodeDecodeData.csvEncodedData || ""
   console.log("EncodeDecodeData = ", EncodeDecodeData)
   exec(onSuccess, onError, PLUGIN_NAME, "EncodeWithSJIS", [EncodeDecodeData.text, EncodeDecodeData.csvEncodedData]);
};


module.exports = jp_encode_decode;