function Person (obj){
    this.name = obj.name;
    this.age = obj.age;
    this.width = obj.width;
    this.height = obj.height;
    this.phone = obj.phone;
    this.say = function (){
        alert('my name is' + this.name);
    };
    this.speak = function (){
        alert('my tlephone number is' + this.phone);
    }
};

Person.prototype = {
    constructor: Person, // 加了这行代码，改变constructor的指针方向
    run: function (){
        console.log('i am run');
    },
    fly: function (){
        console.log('i am fly');
        return 'is fly';
    },
};

var lucyObj = {
    name: 'lucy',
    age: 18,
    height: '167cm',
    phone: '13579'
}
var lucy = new Person(lucyObj);

// console.log(Object.getPrototypeOf(lucy) === Person.prototype);
console.log(lucy.__proto__ === Person.prototype);
console.log(lucy.constructor === Person.prototype.constructor);