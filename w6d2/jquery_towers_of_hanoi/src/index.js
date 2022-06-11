const HanoiGame = require('./game.js');
const HanoiView = require('./hanoiView.js');
$(() => {
  const rootEl = $('.hanoi');
  const game = new HanoiGame();
  new HanoiView(game, rootEl);
  console.log("hello");
});
