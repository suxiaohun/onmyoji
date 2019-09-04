# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( nicEdit.js )

#
Rails.application.config.assets.precompile += %w( common.css cable.js sojson.js  xiuxian.js vue/vue.js vue/click.js vue/timer.js
bigNumber/bignumber.min.js xiuxian/level.js xiuxian/stand.js xiuxian/skill.js
xiuxian/item.js xiuxian/nameMaker.js LZstring/lz-string.min.js layui/layui.css layui/layui.js sojson/index.json.min.js sojson/sojson.js Clipboard.js sojson/require.js sojson/sojson.core.js layui/book.scss tag.scss)
