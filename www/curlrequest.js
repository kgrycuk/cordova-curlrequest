var exec = require('cordova/exec');

exports.curl = function (arg0, success, error) {
    exec(success, error, 'curlrequest', 'curl', [arg0]);
};
