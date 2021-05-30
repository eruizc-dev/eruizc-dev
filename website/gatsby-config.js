module.exports = {
  siteMetadata: {
    siteUrl: "https://eruizc.dev",
    siteName: "eruizc-dev",
    name: "Emiliano Ruiz Carletti",
    title: "Software Developer",
    description: "Professional software developer experienced in React and .NET",
    githubProfile: "https://github.com/eruizc-dev",
    githubUsername: "eruizc-dev",
    linkedinProfile: "https://www.linkedin.com/in/eruizc",
    linkedinUsername: "eruizc",
    twitterProfile: "https://twitter.com/eruizc_dev",
    twitterUsername: "@eruizc_dev",
    compilationDate: new Date().getTime()
  },
  plugins: [
    "gatsby-plugin-styled-components",
    "gatsby-plugin-react-helmet",
    "gatsby-plugin-offline",
    "gatsby-plugin-sharp",
    "gatsby-transformer-sharp",
    "gatsby-plugin-preload-fonts",
    {
      resolve: "gatsby-plugin-manifest",
      options: {
        icon: "./static/favicon-32.png",
      },
    },
    "gatsby-transformer-remark",
    {
      resolve: "gatsby-source-filesystem",
      options: {
        name: "pages",
        path: "./src/pages/",
      },
      __key: "pages",
    },
    {
      resolve: "gatsby-plugin-react-svg",
      options: {
        rule: {
          include: /resources/
        }
      }
    },
  ],
};
