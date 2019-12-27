var exec = require('cordova/exec');

var PLUGIN_NAME = "jp_encode_decode";

var jp_encode_decode = function() {};
jp_encode_decode.readCsvAndEncodeWithUTF8 = function(onSuccess, onError) {
   exec(onSuccess, onError, PLUGIN_NAME, "readCsvAndEncodeWithUTF8", []);
};
jp_encode_decode.createCSVWithSJIS = function(onSuccess, onError, Data) {
   exec(onSuccess, onError, PLUGIN_NAME, "createCSVWithSJIS", [Data.text, Data.csvFileName]);
};
module.exports = jp_encode_decode;