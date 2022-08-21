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

  return {
    dir: {
      input: "src",
      output: "public"
    }
  }
}
