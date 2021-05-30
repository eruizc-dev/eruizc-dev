import React from 'react';
import useSiteMetadata from '../utils/useSiteMetadata';
import { Helmet } from 'react-helmet'

export default function Header() {

  const {
    siteUrl,
    siteName,
    name,
    title,
    description,
    compilationDate,
    twitterUsername,
  } = useSiteMetadata();

  const siteTitle = `${name} - ${title}`;
  const metaimg = `${siteUrl}/metaimg.png`;

  return (
    <Helmet>
      <title>{siteTitle}</title>
      <meta name="title" content={siteTitle} />
      <meta name="description" content={description}/>

      <meta property="og:title" content={`${name} - ${title}`} />
      <meta property="og:description" content={description} />
      <meta property="og:image" itemProp="image" content={metaimg} />
      <meta property="og:image:type" content="image/png" />
      <meta property="og:site_name" content={siteName} />
      <meta property="og:type" content="website" />
      <meta property="og:url" content={siteUrl} />
      <meta property="og:updated_time" content={compilationDate} />

      <meta name="twitter:title" content={siteTitle} />
      <meta name="twitter:url" content={siteUrl} />
      <meta name="twitter:description" content={description} />
      <meta name="twitter:image" content={metaimg} />
      <meta name="twitter:card" content="summary_large_image" />
      <meta name="twitter:site" content={twitterUsername} />
      <meta name="twitter:creator" content={twitterUsername} />
    </Helmet>
  );
}
