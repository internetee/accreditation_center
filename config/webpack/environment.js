// const { environment } = require('@rails/webpacker')

// const webpack = require('webpack');
// environment.plugins.append('Provide', new webpack.ProvidePlugin({
// 	$: 'jquery',
// 	jQuery: 'jquery',
// 	Popper: ['popper.js', 'default']
// }))

// module.exports = environment

const { environment } = require('@rails/webpacker')

const customConfig = {
  resolve: {
    fallback: {
      dgram: false,
      fs: false,
      net: false,
      tls: false,
      child_process: false
    }
  }
};

environment.config.delete('node.dgram')
environment.config.delete('node.fs')
environment.config.delete('node.net')
environment.config.delete('node.tls')
environment.config.delete('node.child_process')

environment.loaders.append('sass', {
    test: /\.scss$/,
    use: [
      'style-loader',
      'css-loader',
      {
        loader: 'sass-loader',
        options: {
          sassOptions: {
            includePaths: ['app/assets/stylesheets'],
          },
        },
      },
    ],
  });

environment.config.merge(customConfig);

module.exports = environment

