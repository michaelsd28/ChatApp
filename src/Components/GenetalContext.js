import React, { createContext, useState } from "react";

export const DataContext = createContext();

export const DataProvider = ({ children }) => {
  const [state, setState] = useState("0");

  return (
    <DataContext.Provider
      value={{
        state, 
        setState
      }}
    >
      {children}
    </DataContext.Provider>
  );
};
