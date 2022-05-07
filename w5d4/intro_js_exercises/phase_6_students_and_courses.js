class Student {
  constructor(firstName, lastName) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.courses = [];
  }

  name() {
    return this.firstName + ' ' + this.lastName;
  }

  courseLoad() {
    let dict = {};
    this.courses.forEach((course) => {
      if (dict[course.department] === undefined) {
        dict[course.department] = course.credits;
      } else {
        dict[course.department] += course.credits;
      }
    })
    return dict;
  }

  not_enrolled(course_to_enroll) {
    let bool = true;
    this.courses.forEach((course) => {
      if (course.name === course_to_enroll.name && 
         course.department === course_to_enroll.department) {
           bool = false;
           return 0;
         }
    })
    return bool;
  } 

  enroll(course) {
    if ((this.not_enrolled(course)) && (!this.hasConflict(course))) {
      this.courses.push(course);
      course.students.push(this);
    } else {
      console.log("Can't enroll in this course");
    }
  }

  hasConflict(new_course) {
    let conflict = false;
    this.courses.forEach((course) => {
      if (new_course.conflictsWith(course)) {
        conflict = true;
        return 0;
      }
    })
    return conflict;
  }
}

class Course {
  constructor(name, department, credits, day, timeBlock) {
    this.name = name;
    this.department = department;
    this.credits = credits;
    this.students = [];
    this.day = day;
    this.timeBlock = timeBlock;
  }

  addStudent(student) {
    student.enroll(this);
  }

  conflictsWith(course) {
    if (course.day === this.day && course.timeBlock === this.timeBlock) {
      return true;
    }
    return false;
  }
}

a = new Student('Ted', 'Tran');
console.log(a.name());
c1 = new Course('CS', 'Science', 3, 'mon', 4);
c2 = new Course('ART', 'Science', 3, 'mon', 4);
c3 = new Course('ART', 'Science', 3, 'mon', 5);
console.log(a.not_enrolled(c1));
a.enroll(c1);
console.log(a.not_enrolled(c1));
console.log(a.courseLoad());
a.enroll(c1);
a.enroll(c2);
a.enroll(c3);
console.log(a.courseLoad());