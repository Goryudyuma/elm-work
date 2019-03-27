const path = require("path");

module.exports = {
  entry: {
    worker: ["./src/worker.js"]
  },

  target: "node",

  output: {
    path: path.join(__dirname, "dist"),
    filename: "[name].js"
  },

  module: {
    rules: [
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: [
          {
            loader: "elm-webpack-loader",
            options: {
              optimize: true
            }
          }
        ]
      }
    ]
  }
};
