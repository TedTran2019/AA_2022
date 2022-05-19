const View = require('./ttt-view');
const Game = require('./game');

  $(() => {
    const game = new Game();
    const view = new View(game, $('.ttt'));
  });
