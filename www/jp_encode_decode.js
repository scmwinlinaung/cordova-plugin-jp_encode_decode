var exec = require('cordova/exec');

var PLUGIN_NAME = "jp_encode_decode"; // This is just for code completion uses.

var jp_encode_decode = function() {}; // This just makes it easier for
 // us to export all of the functions at once.
// All of your plugin functions go below this. 
// Note: We are not passing any options in the [] block for this, so make sure you include the empty [] block.
jp_encode_decode.EncodeWithSJIS = function(onSuccess, onError, Data) {
   Data = Data;
   Data.text = Data.text
   Data.csvFileName = Data.csvFileName

   exec(onSuccess, onError, PLUGIN_NAME, "EncodeWithSJIS", [Data]);
};
jp_encode_decode.DecodeWithSJISAndEncodeWithUTF8 = function(onSuccess, onError, Data) {
   console.log("Data from DecodeWithSJISAndEncodeWithUTF8 = ", Data[0])
   exec(onSuccess, onError, PLUGIN_NAME, "DecodeWithSJISAndEncodeWithUTF8", [Data]);
};
jp_encode_decode.createCSVWithSJIS = function(onSuccess, onError, Data) {
   console.log("Data  = ", Data[0])
   console.log("Data.text = ", Data.text)
   console.log("Data.csvFileName = ",Data.csvFileName)
   exec(onSuccess, onError, PLUGIN_NAME, "DecodeWithSJISAndEncodeWithUTF8", [Data.text, Data.csvFileName]);
};
module.exports = jp_encode_decode;