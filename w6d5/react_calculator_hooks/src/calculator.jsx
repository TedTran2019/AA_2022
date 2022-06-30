import React, { useState } from 'react';

function Calculator(props) { 
  const [result, setResult] = useState(0);
  const [num1, setNum1] = useState("");
  const [num2, setNum2] = useState("");

  const add = (e) => {
    e.preventDefault();
    setResult(parseInt(num1) + parseInt(num2));
  }

  const subtract = (e) => {
    e.preventDefault();
    setResult(parseInt(num1) - parseInt(num2));
  }

  const multiply = (e) => {
    e.preventDefault();
    setResult(parseInt(num1) * parseInt(num2));
  }

  const divide = (e) => {
    e.preventDefault();
    setResult(parseInt(num1) / parseInt(num2));
  }

  const clear = (e) => {
    e.preventDefault();
    setResult(0);
    setNum1("");
    setNum2("");
  }

  const handleNum1Change = (e) => {
    const num = e.target.value ? parseInt(e.target.value) : "";
    setNum1(num);
  }

  const handleNum2Change = (e) => {
    const num = e.target.value ? parseInt(e.target.value) : "";
    setNum2(num);
  }

  return(
    <div>
      <h1>{result}</h1>
      <input onChange={handleNum1Change} type="text" value={num1} />
      <input onChange={handleNum2Change} type="text" value={num2} />
      <button onClick={add}>+</button>
      <button onClick={subtract}>-</button>
      <button onClick={multiply}>*</button>
      <button onClick={divide}>/</button>
      <button onClick={clear}>Clear</button>
    </div>
  )
}

export default Calculator;