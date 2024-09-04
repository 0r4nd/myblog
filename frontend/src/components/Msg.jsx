
import React from 'react'

export default function Msg({msg}) {
  return (
    <div>
      <>
        {Object.values(msg["info"]).map((value, index) => (
          <div className="info-msg" key={msg["key"] + index}>{value}</div>
        ))}
      </>
      <>
        {Object.values(msg["success"]).map((value, index) => (
          <div className="success-msg" key={msg["key"] + index}>{value}</div>
        ))}
      </>
      <>
        {Object.values(msg["warning"]).map((value, index) => (
          <div className="warning-msg" key={msg["key"] + index}>{value}</div>
        ))}
      </>
      <>
        {Object.values(msg["error"]).map((value, index) => (
          <div className="error-msg" key={msg["key"] + index}>{value}</div>
        ))}
      </>
    </div>
  )
}
