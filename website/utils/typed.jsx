import { useState } from 'react';
import useInterval from 'react-useinterval';

export default function Typed({ interval, children }) {

  const [display, setDisplay] = useState(0);

  useInterval(function() {
    if (display >= children.length)
      return;
    setDisplay(display + 1);
  }, interval);

  return display === 0 || children[display - 1] === " "
    ? (<>{children.substring(0, display - 1)}<span>&nbsp;</span></>)
    : children.substring(0, display);
}

Typed.defaultProps = {
  interval: 140,
  children: '',
}

export function Cursor({ interval }) {

  const [cursorVisible, setCursorVisible] = useState(true);

  const cursorBlockStyle = {
    backgroundColor: cursorVisible ? '#35BF5C' : 'transparent',
    textDecoration: 'none',
    display: 'inline-block'
  }

  useInterval(function() {
    setCursorVisible(!cursorVisible);
  }, interval);

  return (
    <span style={cursorBlockStyle}>
      &nbsp;
    </span>
  );
}

Cursor.defaultProps = {
  interval: 755
}
