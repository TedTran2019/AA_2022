class HanoiView {
  constructor(game, $rootel) {
    this.game = game;
    this.$rootel = $rootel;
    this.fromTower = null;
    this.setupTowers();
    this.render();
    this.clickTower();
  }

  setupTowers() {
    for (let i = 0; i < 3; i++) {
      const $ul = $('<ul>');
      $ul.addClass('tower');
      $ul.data('tower', i);
      $ul.data('discs', []);
      if (i === 0) {
        $ul.data('discs').push(3, 2, 1);
      }
      this.$rootel.append($ul);
    }
    const $uls = $('.tower');
    $uls.hover((e) => {
      $(e.currentTarget).addClass('blue');
    }, (e) => {
      $(e.currentTarget).removeClass('blue');
    })
  }

  render() {
    const $uls = $('.tower');
    $uls.each((idx, ul) => {
      const $ul = $(ul);
      const discs = $ul.data('discs');
      $ul.empty();
      discs.forEach(disc => {
        const $li = $('<li>');
        $li.addClass('disc');
        if (disc === 3) {
          $li.css('width', '100%');
        } else if (disc === 2) {
          $li.css('width', '80%');
        } else {
          $li.css('width', '60%');
        }
        $ul.append($li);
      });
    });
  }

  clickTower() {
    const $uls = $('.tower');
    $uls.on('click', (e) => {
      const $tower = $(e.currentTarget);
      if (this.fromTower === null) {
        this.fromTower = $tower
        this.fromTower.toggleClass('selected');
      } else {
        const fromTowerIdx = this.fromTower.data('tower');
        const toTowerIdx = $tower.data('tower');
        if (this.game.move(fromTowerIdx, toTowerIdx)) {
          let from = this.fromTower.data('discs').pop();
          $tower.data('discs').push(from);
          this.render();
        } else {
          alert('Invalid move!');
        }
        this.fromTower.toggleClass('selected');
        this.fromTower = null;
        if (this.game.isWon()) {
          $uls.off('click');
          $uls.off('mouseenter mouseleave');
          $uls.css('border-color', 'black');
          $('.disc').css('background-color', 'green');
          alert('You win!');
        }
      }
    })
  }
};

module.exports = HanoiView;