import Head from 'next/head'
import Center from '../utils/center'
import BottomCenter from '../utils/bottomCenter'
import Banner from '../utils/banner'
import { Github, Twitter, Linkedin } from '../utils/icons'

export default function Home() {
  return (
    <>
      <Header />
      <Center>
        <Banner />
      </Center>
      <BottomCenter>
        <Github />
        <Twitter />
        <Linkedin />
      </BottomCenter>
    </>
  );
}

function Header() {
  return (
    <Head>
      <title>Emiliano Ruiz Carletti</title>
      <meta name="description" content="Software developer" />
      <link rel="icon" href="/favicon.ico" />
      <link href="/fonts/CostaRica/CostaRica-Regular.woff" as="font" rel="preload" crossOrigin="" />
      <link href="/fonts/Montserrat/Montserrat-Regular.woff" as="font" rel="preload" crossOrigin="" />
    </Head>
  );
}
