const prismjs = require("@11ty/eleventy-plugin-syntaxhighlight");

function setupStaticFile(dir, cfg) {
  cfg.addPassthroughCopy(dir);
}

function setupStaticDirectory(dir, cfg) {
  cfg.addPassthroughCopy(dir);
  cfg.addWatchTarget(dir);
}

module.exports = function(config) {
  setupStaticDirectory('./src/resources', config);
  setupStaticDirectory('./src/styles', config);
  setupStaticFile('./src/favicon.png', config);
  setupStaticFile('./src/humans.txt', config);

  config.addPlugin(prismjs);

  return {
    dir: {
      input: "src",
      output: "public"
    }
  }
}
