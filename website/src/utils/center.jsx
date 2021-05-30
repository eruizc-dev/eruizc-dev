import React from 'react';

export default function Center({ style, children }) {
  return (
    <div style={{
      display: 'flex',
      justifyContent: 'center',
      alignItems: 'center',
      textAlign: 'center',
      minHeight: '100%',
      minWidth: '100%',
      position: 'absolute',
      ...style
    }}
    >
      {children}
    </div>
  );
}

