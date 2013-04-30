// Generated by CoffeeScript 1.4.0
(function() {
  var Creator, Fs, Path;

  Fs = require('fs');

  Path = require('path');

  Creator = (function() {

    function Creator(path) {
      this.path = path;
      this.templateDir = "" + __dirname + "/templates";
      this.scriptsDir = "" + __dirname + "/scripts";
    }

    Creator.prototype.mkdirDashP = function(path) {
      return Fs.exists(path, function(exists) {
        if (!exists) {
          return Fs.mkdir(path, 0x1ed, function(err) {
            if (err) {
              throw err;
            }
          });
        }
      });
    };

    Creator.prototype.copy = function(from, to) {
      return Fs.readFile(from, "utf8", function(err, data) {
        console.log("Copying " + (Path.resolve(from)) + " -> " + (Path.resolve(to)));
        return Fs.writeFileSync(to, data, "utf8");
      });
    };

    Creator.prototype.copyDefaultScripts = function(path) {
      var file, _i, _len, _ref, _results;
      _ref = Fs.readdirSync(this.scriptsDir);
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        file = _ref[_i];
        _results.push(this.copy("" + this.scriptsDir + "/" + file, "" + path + "/" + file));
      }
      return _results;
    };

    Creator.prototype.run = function() {
      var file, files, _i, _len, _results;
      console.log("Creating a hubot install at " + this.path);
      this.mkdirDashP(this.path);
      this.mkdirDashP("" + this.path + "/bin");
      this.mkdirDashP("" + this.path + "/scripts");
      this.copyDefaultScripts("" + this.path + "/scripts");
      files = ["Procfile", "package.json", "README.md", ".gitignore", "bin/hubot", "hubot-scripts.json", "external-scripts.json"];
      _results = [];
      for (_i = 0, _len = files.length; _i < _len; _i++) {
        file = files[_i];
        _results.push(this.copy("" + this.templateDir + "/" + file, "" + this.path + "/" + file));
      }
      return _results;
    };

    return Creator;

  })();

  module.exports = Creator;

}).call(this);
