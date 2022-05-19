class View {
  constructor(game, $el) {
    this.game = game;
    this.el = $el;
    this.setupBoard();
    this.bindEvents();
  }

  bindEvents() {
    $('ul').on('click', 'li', (e) => {
      let $square = $(e.currentTarget);
      try {
        this.makeMove($square);
      } catch (error) {
        alert(JSON.stringify(error['msg']));
      }
      if (this.game.isOver()) {
        let winner = this.game.winner();
        let overMsg = $('<h1>');
        $('li').css('background-color', 'white');
        if (winner === null) {
          //console.log("It's a draw!");
          overMsg.text("It's a draw!");
          this.el.append(overMsg);
          $('li').css('color', 'red');
        } else {
          //console.log(`You win, ${winner}!`);
          overMsg.text(`You win, ${winner}!`);
          this.el.append(overMsg);
          let loser = (winner === 'o' ? 'x' : 'o');
          $(`li:contains(${loser})`).addClass('loser');
          $(`li:contains(${winner})`).css({
            'background-color': 'green',
            'color': 'white'
          })
        }
        $('ul').off();
        $('li').unbind('mouseenter mouseleave');
        $('li');    
      }
      // console.log(this);
      // console.log(e.target);
      // console.log(e.currentTarget);
      // console.log(e.delegateTarget);
    })
  }

  makeMove($square) {
    let pos = $square.attr('data-pos');
    pos = pos.split(',').map(el => {
      return parseInt(el);
    })
    let player = this.game.currentPlayer;
    this.game.playMove(pos);
    $square.unbind('mouseenter mouseleave');
    $square.css('background-color', 'white');
    $square.addClass('mark').text(player);
  }

  setupBoard() {
    for (let y = 0; y < 3; y++) {
      const grid = $('<ul>').css({
        'display': 'flex',
        'flex-wrap': 'wrap',
        'height': '25vh'
      })
      for (let x = 0; x < 3; x++) {
        const list = $('<li>').css({
          'width': '25vw',
          'height': '25vh',
          'background-color': 'grey'
        }).attr('data-pos', [x, y]);
        grid.append(list);
      } 
      this.el.append(grid);
    }
    $('li').css({
      'border-top': '10px solid black',
      'border-left': '10px solid black'
    })
    $('li:last-child').css('border-right', '10px solid black');
    $('ul:last-child li').css('border-bottom', '10px solid black');
    $('li').hover(function() {
      $(this).css('background-color', 'yellow');
    }, function() {
      $(this).css('background-color', 'grey');
    })
  }
}

module.exports = View;