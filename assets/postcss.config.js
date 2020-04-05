const purgecss = require("@fullhuman/postcss-purgecss")({
  content: [
    "../lib/bread_web/templates/**/*.html.eex",
    "../lib/bread_web/templates/**/*.html.leex",
    "./js/**/*.js"
  ],
  defaultExtractor: content => content.match(/[\w-/:]+(?<!:)/g) || []
});

module.exports = (ctx) => ({
  plugins: [
    require('tailwindcss'),
    require('precss'),
    require('autoprefixer'),
    ...ctx.webpack.mode === 'production' ? [purgecss] : []
  ]
})

