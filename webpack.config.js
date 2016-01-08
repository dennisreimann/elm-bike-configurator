// most of this setup is from the elm-webpack-loader example:
// https://github.com/rtfeldman/elm-webpack-loader
var webpack = require('webpack');
var merge = require('webpack-merge');
var ExtractTextPlugin = require('extract-text-webpack-plugin');

// detemine build env
var TARGET_ENV = process.env.npm_lifecycle_event === 'build' ? 'prod' : 'dev';

// common webpack config
var commonConfig = {
  entry: './src/index.js',

  output: {
    path:     './dist',
    filename: './scripts/main.js'
  },

  resolve: {
    modulesDirectories: ['node_modules'],
    extensions:  ['', '.js', '.elm']
  },

  module: {
    loaders: [
      {
        test:    /\.(html|png)$/,
        exclude: /node_modules/,
        loader:  'file?name=[name].[ext]'
      },
      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader:  'elm-webpack'
      }
    ],

    noParse: /\.elm$/
  }
}

// additional webpack settings for local env (when invoked by 'npm start')
if (TARGET_ENV === 'dev') {
  module.exports = merge(commonConfig, {
    devServer: {
      inline: true,
      stats: 'errors-only'
    },

    module: {
      loaders: [
        {
          test: /\.(css|styl)$/,
          loaders: [
            'style-loader',
            'css-loader',
            'autoprefixer-loader?browsers=last 2 versions',
            'stylus-loader'
          ]
        }
      ]
    }
  });
}

// additional webpack settings for prod env (when invoked via 'npm run build')
if (TARGET_ENV === 'prod') {
  module.exports = merge(commonConfig, {
    module: {
      loaders: [
        {
          test: /\.(css|styl)$/,
          loader: ExtractTextPlugin.extract('style-loader', [
            'css-loader',
            'autoprefixer-loader?browsers=last 2 versions',
            'stylus-loader'
          ])
        }
      ]
    },

    plugins: [
      new ExtractTextPlugin('./styles/main.css', { allChunks: true } ),

      // minify & mangle JS/CSS
      new webpack.optimize.UglifyJsPlugin({
        compressor: { warnings: false },
        minimize: true,
        mangle: true
      })
    ]
  });
}
