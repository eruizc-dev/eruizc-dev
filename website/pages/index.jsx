import Head from 'next/head';
import Center from '../utils/center';
import Banner from '../utils/banner';

export default function Home() {
  return (
    <>
      <Header />
      <Center>
        <Banner />
      </Center>
    </>
  );
}

function Header() {
  return (
    <Head>
      <title>Emiliano Ruiz Carletti</title>
      <meta name="description" content="Software developer" />
      <link rel="icon" href="/favicon.ico" />
    </Head>
  );
}
