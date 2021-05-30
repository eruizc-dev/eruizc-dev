import React, { useState } from 'react';
import useInterval from 'react-useinterval';

type TypedType = {
  interval: number;
  children: string;
}

export default function Typed({ interval, children }: TypedType) {

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

type CursorType = {
  interval: number;
}

export function Cursor({ interval }: CursorType) {

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
