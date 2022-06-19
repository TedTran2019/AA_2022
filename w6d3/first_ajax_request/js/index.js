console.log("Hello from the JavaScript console!");

// Your AJAX request here
$.ajax({
  type: 'GET',
  url: "http://api.openweathermap.org/data/2.5/weather?q=new%20york,US&appid=bcb83c4b54aee8418983c2aff3073b3b",
  success(data) {
    console.log(data);
    console.log(data['weather']);
    console.log(data['weather'][0]['description']);
  },
  error() {
    console.error("An error occurred.");
  },
});
// Add another console log here, outside your AJAX request
console.log("This completes before the request!");

// Request gets sent once page is loaded
// Response comes back after request is sent and stack is empty
// Broken clouds
// The page did not refresh
// Change the ajax request type