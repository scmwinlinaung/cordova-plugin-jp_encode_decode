var exec = require('cordova/exec');

var PLUGIN_NAME = "jp_encode_decode"; // This is just for code completion uses.

var jp_encode_decode = function() {}; // This just makes it easier for
 // us to export all of the functions at once.
// All of your plugin functions go below this. 
// Note: We are not passing any options in the [] block for this, so make sure you include the empty [] block.
jp_encode_decode.EncodeWithSJIS = function(Data, onSuccess, onError) {
   Data = Data;
   Data.then(
      data => {
         console.log('data = ', data)
      }
   )
   console.log("Data = ", Data)

   exec(onSuccess, onError, PLUGIN_NAME, "EncodeWithSJIS", [Data]);
};


module.exports = jp_encode_decode;