import { useStaticQuery, graphql } from 'gatsby';

export default function useStaticImage(img: string) {

  const query = useStaticQuery(graphql`
  {
    allFile(filter: {sourceInstanceName: {eq: "images"}}) {
      edges {
        node {
          relativePath
          childImageSharp {
            fixed {
              base64
            }
          }
        }
      }
    }
  }`);

  return query.allFile.edges
    .find((e: any) => e.node.relativePath === img)
    ?.node?.childImageSharp?.fixed?.base64;
}
