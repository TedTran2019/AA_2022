const path    = require("path")
const webpack = require("webpack")

module.exports = {
  module: {
    rules: [
      {
        test: /\.(js|jsx|ts|tsx|)$/,
        exclude: /node_modules/,
        use: ['babel-loader'],
      },
    ],
  },
  mode: "production",
  devtool: "source-map",
  entry: {
    application: "./app/javascript/frontend/todo_redux"
  },
  output: {
    filename: "[name].js",
    sourceMapFilename: "[file].map",
    path: path.resolve(__dirname, "app/assets/builds"),
  },
  plugins: [
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1
    })
  ],
  resolve: {
    extensions: [".js", ".jsx", "*"]
  }
}
