// most of this setup is from the elm-webpack-starter example:
// https://github.com/moarwick/elm-webpack-starter/
var path              = require('path');
var webpack           = require('webpack');
var merge             = require('webpack-merge');
var HtmlWebpackPlugin = require('html-webpack-plugin');
var autoprefixer      = require('autoprefixer');
var ExtractTextPlugin = require('extract-text-webpack-plugin');
var CopyWebpackPlugin = require('copy-webpack-plugin');

// detemine build env
var TARGET_ENV = process.env.npm_lifecycle_event === 'build' ? 'production' : 'development';

// common webpack config
var commonConfig = {
  output: {
    path: path.resolve( __dirname, 'dist/'),
    filename: 'scripts/[hash].js',
  },

  resolve: {
    modulesDirectories: ['node_modules'],
    extensions: ['', '.js', '.elm'],
  },

  module: {
    noParse: /\.elm$/,
    loaders: [
      {
        test: /\.(woff|woff2|svg)$/,
        loader: 'file-loader',
      },
    ],
  },

  plugins: [
    new HtmlWebpackPlugin({
      template: 'src/index.html',
      inject:   'body',
      filename: 'index.html',
    }),
  ],

  postcss: [
    autoprefixer({ browsers: ['last 2 versions'] }),
  ],
};

// additional webpack settings for local env (when invoked by 'npm start')
if (TARGET_ENV === 'development') {
  module.exports = merge(commonConfig, {
    entry: [
      'webpack-dev-server/client?http://localhost:8080',
      path.join( __dirname, 'src/scripts/index.js' ),
    ],

    devServer: {
      inline: true,
      progress: true,
    },

    module: {
      loaders: [
        {
          test:    /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          loader:  'elm-hot!elm-webpack?verbose=true&warn=true&debug=true',
        },
        {
          test: /\.(css|styl)$/,
          loaders: [
            'style-loader',
            'css-loader',
            'postcss-loader',
            'stylus-loader',
          ],
        },
      ],
    },
  });
}

// additional webpack settings for prod env (when invoked via 'npm run build')
if (TARGET_ENV === 'production') {
  module.exports = merge(commonConfig, {
    entry: path.join( __dirname, 'src/scripts/index.js'),

    module: {
      loaders: [
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          loader: 'elm-webpack',
        },
        {
          test: /\.(css|styl)$/,
          loader: ExtractTextPlugin.extract('style-loader', [
            'css-loader',
            'postcss-loader',
            'stylus-loader',
          ]),
        },
      ],
    },

    plugins: [
      new CopyWebpackPlugin([
        {
          from: 'src/images/',
          to: 'images'
        },
        {
          from: 'src/components.json',
        },
      ]),

      new webpack.optimize.OccurenceOrderPlugin(),

      new ExtractTextPlugin('styles/[hash].css', { allChunks: true } ),

      new webpack.optimize.UglifyJsPlugin({
        minimize: true,
        mangle: true,
        compressor: { warnings: false },
      }),
    ]
  });
}
