import React, { useState } from 'react';
import useInterval from 'react-useinterval';

function TypeWritter({ typingSpeed, cursorSpeed, children }) {

  const [cursorVisible, setCursorVisible] = useState(true);
  const [display, setDisplay] = useState(0);

  useInterval(function() {
    if (display >= children.length)
      return;
    setDisplay(display + 1);
  }, typingSpeed);

  useInterval(function() {
    setCursorVisible(!cursorVisible);
  }, cursorSpeed);

  return (
    <>
      {children[display - 1] === " " 
        ? (<>{children.substring(0, display - 1)}<span>&nbsp;</span></>)
        : children.substring(0, display)
      }
      <span style={{
        backgroundColor: cursorVisible ? '#35BF5C' : 'transparent',
        textDecoration: 'none',
        display: 'inline-block'
      }}>
        &nbsp;
      </span>
    </>
  )
}

export default TypeWritter;
