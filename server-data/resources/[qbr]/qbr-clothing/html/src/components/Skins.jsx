import React, {useEffect, useState} from 'react'
import SkinItem from './SkinItem.jsx'

export default function Skins({data}) {
  const handleSkinChange = (e) => {
    data.find((o, i) => {
      if(o.name === e.name) {
        data[i].currentValue = e.currentValue
        return
      }
    })

    fetch('https://qbr-clothing/applySkin', {method: 'POST', body: JSON.stringify({
      values: data
    })})
  }

  return (
    <div className="clothingMenu">
      <div className="clothingMenu_options">
        {data.map((i, k) => <SkinItem data={i} key={k} onSkinChange={handleSkinChange} />)}
      </div>
    </div>
  )
}