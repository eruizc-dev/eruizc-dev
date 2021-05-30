import React from 'react';
import Typed from '../utils/typed';
import Header from '../components/header';
import Center from '../utils/center';
import FooterIconBar from '../components/footerIconBar';
import useSiteMetadata from '../utils/useSiteMetadata';

import '../styles/global.css';

function Background({ style, children }) {
  return (
    <main className='background' style={{
      height: '100vh',
      width: '100vw',
      backgroundColor: '#212121',
      ...style
    }}>
      {children}
    </main>
  );
}

function Banner() {

  const {
    name,
    title
  } = useSiteMetadata();

  return (
    <div>
      <h1 className="title">
        <Typed>{name.toUpperCase()}</Typed>
      </h1>
      <h2 className="subtitle">
        {title.toUpperCase()}
      </h2>
    </div>
  );
}

export default function HomePage() {
  return (
    <>
      <Header />
      <Background>
        <Center>
          <Banner />
        </Center>
        <FooterIconBar />
      </Background>
    </>
  );
}
