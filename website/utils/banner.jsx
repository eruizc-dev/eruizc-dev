import Typed from '../utils/typed';
import styled from 'styled-components';

const BannerTitle = styled.h1`
  font-family: CostaRica;
  color: #35BF5C;
  margin: 0;
  padding: 0px 33px;
  font-size: calc(45px + 4.5vw);
`

const BannerSubtitle = styled.h2`
  font-family: Montserrat;
  color: #FFF;
  margin: 0;
  padding: 0px 33px;
  font-size: calc(10px + 1.5vw);
`

export default function Banner() {
  const name = "Emiliano Ruiz Carletti".toUpperCase();
  const subtitle = "Software Developer".toUpperCase();

  return (
    <div>
      <BannerTitle>
        <Typed>
          {name}
        </Typed>
      </BannerTitle>
      <BannerSubtitle>
        {subtitle}
      </BannerSubtitle>
    </div>
  );
}

