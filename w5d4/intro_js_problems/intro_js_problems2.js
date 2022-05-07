const printCallback = (titleized_names) => {
  titleized_names.forEach(element => {
    console.log(element);
  });
};

const titleize = (names, callback) => {
  titleized_names = names.map(name => {
    return `Mx. ${name} Jingleheimer Schmidt`;
  });
  callback(titleized_names);
};

titleize(["Mary", "Brian", "Leo"], printCallback);

// Static for class methods
// get/set methods
// Methods inside of 'Class' is shorthand for: etc.prototype.method = function() {};
// Composition vs Inheritance
// Lodash
class Elephant {
  constructor(name, height, tricks) {
    this.name = name;
    this.height = height;
    this.tricks = tricks;
  }

  trumpet() {
    console.log(`${this.name} the elephant goes 'phrRRRRRRRRRRR!!!!!!!'"`);
  }

  grow() {
    this.height += 12;
  }

  addTrick(trick) {
    this.tricks.push(trick);
  }

  play() {
    let random_idx = Math.floor(Math.random() * this.tricks.length);
    return this.tricks[random_idx];
  }
}

a = new Elephant('Dumbo', 60, ['Sing', 'Dance', 'Swim']);
console.log(a);
a.trumpet();
a.grow();
console.log(a.height);
a.addTrick('Fly');
console.log(a.tricks);
console.log(a.play());

let ellie = new Elephant("Ellie", 185, ["giving human friends a ride", "playing hide and seek"]);
let charlie = new Elephant("Charlie", 200, ["painting pictures", "spraying water for a slip and slide"]);
let kate = new Elephant("Kate", 234, ["writing letters", "stealing peanuts"]);
let micah = new Elephant("Micah", 143, ["trotting", "playing tic tac toe", "doing elephant ballet"]);
let herd = [ellie, charlie, kate, micah];

const paradeHelper = (elephant) => {
  console.log(`${elephant.name} is trotting by!`);
}

const parade = (elephant_array, paradeHelper) => {
  elephant_array.forEach(elephant => {
    paradeHelper(elephant);
  })
}

parade(herd, paradeHelper);

const dinerBreakfast = () => {
  let order = "I'd like cheesy scrambled eggs please";

  console.log(order); 

  return (food) => {
    if (!(food === undefined)) {
      order += ` and ${food}`;
    };
    console.log(order);
  };
};

let bfastOrder = dinerBreakfast();
bfastOrder("chocolate chip pancakes");
bfastOrder("grits");
bfastOrder();