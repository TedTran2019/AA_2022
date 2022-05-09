class HumanPlayer {
  constructor(mark) {
    this.mark = mark;
  }

  promptMove(reader, board, callback) {
    board.print();
    console.log(`Hello player ${this.mark}`);
    reader.question('Enter x coordinate: ', x => {
      reader.question('Enter y coordinate: ', y => {
        const pos = [parseInt(x), parseInt(y)];
        callback(pos);
      })
    })
  }
}

module.exports = HumanPlayer;