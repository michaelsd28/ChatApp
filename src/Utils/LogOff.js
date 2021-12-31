import React from 'react'

function LogOff() {
    return (
        <div>
         
            <button onClick={() => {
                localStorage.removeItem("jwt");
                window.location.reload();
            }}
            className='btn btn-outline-danger'>
               <img 
            style={{
             
                width: "2vw",
                padding:"5px"
            }}
            src='images/logoff.png' alt='logoff'/> Log Off</button>
            
            
        </div>
    )
}

export default LogOff
