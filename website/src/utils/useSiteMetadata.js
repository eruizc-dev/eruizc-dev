import { useStaticQuery, graphql } from 'gatsby';

export default function useSiteMetadata() {

  const data = useStaticQuery(graphql`
    query {
      site {
        siteMetadata {
          siteUrl,
          siteName,
          name,
          title,
          description,
          githubProfile,
          githubUsername,
          linkedinProfile,
          linkedinUsername,
          twitterProfile,
          twitterUsername,
          compilationDate
        }
      }
    }
  `);

  return data?.site?.siteMetadata;
}
