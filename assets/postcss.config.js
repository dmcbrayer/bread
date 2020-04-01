const purgecss = require("@fullhuman/postcss-purgecss")({
  content: [
    "../lib/bread_web/templates/**/*.html.eex",
    "../lib/bread_web/templates/**/*.html.leex",
    "./js/**/*.js"
  ],
  defaultExtractor: content => content.match(/[\w-/:]+(?<!:)/g) || []
});

module.exports = {
  plugins: [
    require('tailwindcss'),
    require('autoprefixer'),
    ...process.env.NODE_ENV === "production"
      ? [purgecss]
      : []
  ]
}

