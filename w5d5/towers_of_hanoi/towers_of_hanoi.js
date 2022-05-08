class TowersOfHanoi {
  constructor(reader) {
    this.towers = [];
    this.#fillTowers();
    this.reader = reader;
  }

  run(completionCallback) {
    this.promptMove(completionCallback);
  }

  isWon() {
    return (this.towers[1].length === 3 || this.towers[2].length === 3);
  }

  promptMove(completionCallback) {
    this.printTowers();
    this.reader.question('Which tower would you like to move from? Enter by IDX: ', startIdx => {
      this.reader.question('Which tower would you like to move to? Enter by IDX: ', endIdx => {
        let start = parseInt(startIdx);
        let end = parseInt(endIdx);
        if (!this.move(startIdx, endIdx)) { console.log('Invalid move'); }
        if (this.isWon()) {
          console.log('You win!');
          completionCallback();
        } else {
          this.run(completionCallback);
        }
     })
    })
  }

  isValidMove(startIdx, endIdx) {
    if (!this.#withinBounds(startIdx) || !this.#withinBounds(endIdx)) {
      return false;
    }
    if (this.towers[startIdx].length === 0) { return false; }
    if (this.towers[endIdx].length === 0) { return true; }
    let start = this.towers[startIdx]
    let end = this.towers[endIdx]
    return start[start.length - 1] < end[end.length - 1]
  }

  move(startIdx, endIdx) {
    if (this.isValidMove(startIdx, endIdx)) {
      this.towers[endIdx].push(this.towers[startIdx].pop());
      return true;
    }
    return false;
  }

  printTowers() {
    this.towers.forEach((tower) => {
      console.log(tower);
    })
  }

  print() {
    console.log(JSON.stringify(this.towers));
  }

  #fillTowers() {
    this.towers[0] = [3, 2, 1];
    this.towers[1] = [];
    this.towers[2] = [];
  }

  #withinBounds(idx) {
    return idx > -1 && idx < 3
  }
}

module.exports = TowersOfHanoi;