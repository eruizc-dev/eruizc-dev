function Primary() {
  return (
    <>
      <meta name="title" content="Emiliano Ruiz Carletti - Software Developer" />
      <meta name="description" content="If it involves code, you can count on me!" />
    </>
  );
}

function OpenGraph() {
  return (
    <>
      <meta property="og:type" content="website" />
      <meta property="og:url" content="https://eruizc.dev" />
      <meta property="og:title" content="Emiliano Ruiz Carletti - Software Developer" />
      <meta property="og:description" content="If it involves code, you can count on me!" />
      <meta property="og:image" content="https://eruizc.dev/banner.png" />
    </>
  );
}

function Twitter() {
  return (
    <>
      <meta property="twitter:card" content="summary_large_image" />
      <meta property="twitter:url" content="https://eruizc.dev" />
      <meta property="twitter:title" content="Emiliano Ruiz Carletti - Software Developer" />
      <meta property="twitter:description" content="If it involves code, you can count on me!" />
      <meta property="twitter:image" content="https://eruizc.dev/banner.png" />
    </>
  )
}

const Metatags = {
  Primary: Primary,
  OpenGraph: OpenGraph,
  Twitter: Twitter,
}

export default Metatags;
