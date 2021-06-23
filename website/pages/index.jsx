import Head from 'next/head';
import styled from 'styled-components';
import Center from '../utils/center';

const BannerTitle = styled.h1`
  font-family: CostaRica;
  color: #35BF5C;
  margin: 0 0 0 0;
  padding: 0 0 0 0;
  font-size: 6vw;
`

const BannerSubtitle = styled.h2`
  font-family: Montserrat;
  color: #FFF;
  margin: 0 0 0 0;
  padding: 0 0 0 0;
  font-size: 2vw;
`

export default function Home() {
  return (
    <>
      <Header />
      <Main />
    </>
  );
}

function Main() {
  return (
    <Center>
      <Banner />
    </Center>
  );
}
function Banner() {
  const name = "Emiliano Ruiz Carletti".toUpperCase();
  const subtitle = "Software Developer".toUpperCase();

  return (
    <div>
      <BannerTitle>
        {name}
      </BannerTitle>
      <BannerSubtitle>
        {subtitle}
      </BannerSubtitle>
    </div>
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
