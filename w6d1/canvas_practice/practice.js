document.addEventListener("DOMContentLoaded", function(){
  let canvas = document.getElementById('mycanvas');
  canvas.width = 500;
  canvas.height = 500;
  let ctx = canvas.getContext('2d');
  ctx.fillStyle = 'red';
  ctx.fillRect(0, 0, canvas.width, canvas.height);
  ctx.beginPath();
  ctx.arc(250, 250, 250, 0, 2 * Math.PI);
  ctx.strokeStyle = 'green';
  ctx.lineWidth = 10;
  ctx.stroke();
  ctx.fillStyle = 'orange';
  ctx.fill();
});
