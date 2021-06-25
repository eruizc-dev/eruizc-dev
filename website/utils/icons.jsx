import GithubIcon from '../public/icons/brand-logos-1/svg/github-1288242.svg'
import TwitterIcon from '../public/icons/brand-logos-1/svg/twitter-1239448.svg'
import LinkedinIcon from '../public/icons/brand-logos-1/svg/linkedin-1239440.svg'
import PropTypes from 'prop-types'

const defaultProps = {
  width: 128,
  height: 128,
  color: "#35BF5C"
}


Github.defaultProps = defaultProps;
export function Github({ width, height, color }) {
  return(
    <a href="https://github.com/eruizc-dev">
      <GithubIcon width={width} height={height} color={{fill: color}} />
    </a>
  )
}

Twitter.defaultProps = defaultProps;
export function Twitter({ width, height, color }) {
  return(
    <a href="https://twitter.com/eruizc_dev">
      <TwitterIcon width={width} height={height} color={{fill: color}} />
    </a>
  )
}

Linkedin.defaultProps = defaultProps;
export function Linkedin({ width, height, color }) {
  return(
    <a href="https://www.linkedin.com/in/eruizc/">
      <LinkedinIcon width={width} height={height} color={{fill: color}} />
    </a>
  )
}
