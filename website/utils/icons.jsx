import GithubIcon from '../public/icons/brand-logos-1/svg/github-1288242.svg'
import TwitterIcon from '../public/icons/brand-logos-1/svg/twitter-1239448.svg'
import LinkedinIcon from '../public/icons/brand-logos-1/svg/linkedin-1239440.svg'

const defaultProps = {
  width: 'calc(70px + 4vw)',
  height: 'calc(70px + 4vw)',
  color: '#35BF5C'
}

Github.defaultProps = defaultProps;
export function Github({ width, height, color }) {
  return(
    <a href="https://github.com/eruizc-dev">
        <GithubIcon style={{height: height, width: width, fill: color}} />
    </a>
  )
}

Twitter.defaultProps = defaultProps;
export function Twitter({ width, height, color }) {
  return(
    <a href="https://twitter.com/eruizc_dev">
      <TwitterIcon width={width} height={height} style={{fill: color}} />
    </a>
  )
}

Linkedin.defaultProps = defaultProps;
export function Linkedin({ width, height, color }) {
  return(
    <a href="https://www.linkedin.com/in/eruizc/">
      <LinkedinIcon width={width} height={height} style={{fill: color}} />
    </a>
  )
}
