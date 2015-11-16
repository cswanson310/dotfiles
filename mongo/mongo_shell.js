(function(mod) {
  if (typeof exports == "object" && typeof module == "object") // CommonJS
    return mod(require("../lib/infer"), require("../lib/tern"));
  if (typeof define == "function" && define.amd) // AMD
    return define(["../lib/infer", "../lib/tern"], mod);
  mod(tern, tern);
})(function(infer, tern) {
  "use strict";

  function flattenPath(path) {
    if (!/(^|\/)(\.\/|[^\/]+\/\.\.\/)/.test(path)) return path;
    var parts = path.split("/");
    for (var i = 0; i < parts.length; ++i) {
      if (parts[i] == ".") parts.splice(i--, 1);
      else if (i && parts[i] == "..") parts.splice(i-- - 1, 2);
    }
    return parts.join("/");
  }


  infer.registerFunction("loadFunc", function(_self, args, argNodes) {
    var server = infer.cx().parent;
    var data = server && server._requireJS;
    if (!data || !args.length) return infer.ANull;

    if (argNodes && args.length == 1) {
      var node = argNodes[0];
      if (node.type == "Literal" && typeof node.value == "string") {
        var file = flattenPath(node.value);
        if (!(file in data.loaded)) {
          data.loaded[file] = 1;
          data.server.addFile(file);
        }
      }
    }

    return infer.ANull;
  });

  // Parse simple ObjectExpression AST nodes to their corresponding JavaScript objects.
  function parseExprNode(node) {
    switch (node.type) {
    case "ArrayExpression":
      return node.elements.map(parseExprNode);
    case "Literal":
      return node.value;
    case "ObjectExpression":
      var obj = {};
      node.properties.forEach(function(prop) {
        var key = prop.key.name || prop.key.value;
        obj[key] = parseExprNode(prop.value);
      });
      return obj;
    }
  }

  infer.registerFunction("requireJSConfig", function(_self, _args, argNodes) {
    var server = infer.cx().parent, data = server && server._requireJS;
    if (data && argNodes && argNodes.length && argNodes[0].type == "ObjectExpression") {
      var config = parseExprNode(argNodes[0]);
      for (var key in config) if (config.hasOwnProperty(key)) {
        var value = config[key], exists = data.options[key];
        if (!exists) {
          data.options[key] = value;
        } else if (key == "paths") {
          for (var path in value) if (value.hasOwnProperty(path) && !data.options.paths[path])
            data.options.paths[path] = value[path];
        }
      }
    }
    return infer.ANull;
  });

  tern.registerPlugin("mongo_shell", function(server, options) {
    server._requireJS = {
      loaded: Object.create(null),
      options: options || {},
      currentFile: null,
      server: server
    };

    server.on("beforeLoad", function(file) {
      this._requireJS.currentFile = file.name;
    });
    server.on("reset", function() {
      this._requireJS.loaded = Object.create(null);
      this._requireJS.require = null;
    });
    return {defs: defs};
  });

  var defs = {
    "!name": "mongo_shell",
    "!define": {
      module: {
        id: "string",
        uri: "string",
        config: "fn() -> ?",
        exports: "?"
      },
    },
    load: "fn(moduleName: string) -> !custom:loadFunc",
    DBCollection: {
        prototype: {
          "<i>": "+DBCollection"
        },
    },
    DB: {
        prototype: {
          'zzz': 'string',
          '<i>' : "+DBCollection",
          'getMongo': 'fn() -> +Mongo',

        },
    },
    db: "+DB",
    dbasdf: "+DB",
    define: {
      "!type": "fn(deps: [string], callback: fn()) -> !custom:requireJS",
      amd: {
        jQuery: "bool"
      }
    }
  };
});
