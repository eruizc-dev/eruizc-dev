import React from 'react';
import ExtLink from '../utils/extLink';
import Center from '../utils/center';
import GithubIcon from '../resources/brand-logos/svg/github-1288242.svg';
import LinkedinIcon from '../resources/brand-logos/svg/linkedin-1239440.svg';
import TwitterIcon from '../resources/brand-logos/svg/twitter-1239448.svg';
import useSiteMetadata from '../utils/useSiteMetadata';

export default function FooterIconBar() {

  const {
    githubProfile,
    linkedinProfile,
    twitterProfile
  } = useSiteMetadata();

  const style = {
    fill: '#35BF5C',
    width: '5.2vw',
    height: '5.2vw'
  };

  return (
    <Center>
      <div style={{ paddingTop: '20%' }}>
        <ExtLink href={githubProfile} >
          <GithubIcon {...style} />
        </ExtLink>
        <ExtLink href={linkedinProfile} >
          <LinkedinIcon {...style} />
        </ExtLink>
        <ExtLink href={twitterProfile} >
          <TwitterIcon {...style} />
        </ExtLink>
      </div>
    </Center>
  );
}
