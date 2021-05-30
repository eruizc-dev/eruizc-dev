import React from 'react';

type ExtLinkPropsType = {
  href: string;
  children: any;
}

export default function ExtLink({ href, children }: ExtLinkPropsType) {
  return (
    <a href={href} target="_blank" rel="noopener noreferrer">
      {children}
    </a>
  );
}

