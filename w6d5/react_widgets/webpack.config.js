const path = require('path');
const Dotenv = require('dotenv-webpack');

module.exports = {
  context: __dirname,
  entry: "./src/widgets.jsx",
  output: {
    path: path.resolve(__dirname),
    filename: "./dist/bundle.js"
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        exclude: /(node_modules)/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/env', '@babel/react']
          }
        },
      }
    ]
  },
  devtool: 'source-map',
  resolve: {
    extensions: [".js", ".jsx", "*"]
  },
  plugins: [
    new Dotenv()
  ]
};