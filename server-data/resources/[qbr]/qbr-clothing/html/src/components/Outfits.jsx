import React, {useEffect, useState} from 'react'
import OutfitItem from './OutfitItem.jsx'

export default function Outfits({data}) {
  return (
    <div className="clothingMenu">
      <div className="clothingMenu_options">
        {data.map((i, k) => <OutfitItem data={i} key={k} />)}
      </div>
    </div>
  )
}