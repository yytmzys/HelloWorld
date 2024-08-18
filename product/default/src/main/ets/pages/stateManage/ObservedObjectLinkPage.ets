import { ClassA, ClassB, ViewA } from './ViewA'

// 2 日期
@Observed
class DateClass extends Date {
  constructor(args: number | string) {
    super(args)
  }
}

@Observed
class ClassDateB {
  public a: DateClass;

  constructor(a: DateClass) {
    this.a = a;
  }
}

@Component
struct ViewDateB {
  label: string = 'date';
  @ObjectLink a: DateClass;

  build() {
    Column() {
      Button(`点击日期加 1`)
        .onClick(() => {
          this.a.setDate(this.a.getDate() + 1);
        })
      DatePicker({
        start: new Date('1970-1-1'),
        end: new Date('2100-1-1'),
        selected: this.a
      })
    }
  }
}

// 3 嵌套对象
// NextID是用来在ForEach循环渲染过程中，为每个数组元素生成一个唯一且持久的键值，用于标识对应的组件。
let NextID: number = 1
@Observed
class Bag {
  public id: number
  public size: number

  constructor(size: number) {
    this.id = NextID++
    this.size = size;
  }
}

@Observed
class User {
  public bag: Bag

  constructor(bag: Bag) {
    this.bag = bag;
  }
}

@Observed
class Book {
  public bookName: BookName

  constructor(bookName: BookName) {
    this.bookName = bookName;
  }
}

@Observed
class BookName extends Bag {
  public nameSize: number

  constructor(nameSize: number) {
    super(nameSize);
    this.nameSize = nameSize;
  }
}

@Component
struct BookView1 {
  label: string = 'BookView1'
  @ObjectLink bag: Bag

  build() {
    Column() {
      Text(`BookView1 [${this.label}] this.bag.size = ${this.bag.size}`)
        .fontColor('#ffffffff')
        .backgroundColor('#ff3d9dba')
        .width(320)
        .height(50)
        .borderRadius(25)
        .margin(10)
        .textAlign(TextAlign.Center)
      Button(`BookView1: this.bag.size add 1`)
        .width(320)
        .backgroundColor('#ff17a98d')
        .margin(10)
        .onClick(() => {
          this.bag.size += 1;
        })
    }
  }
}

@Component
struct BookView2 {
  label: string = 'BookView2';
  @ObjectLink bookName: BookName;

  build() {
    Row() {
      Column() {
        Text(`BookView2 [${this.label}] this.bookName.size = ${this.bookName.size}`)
          .fontColor('#ffffffff')
          .backgroundColor('#ff3d9dba')
          .width(320)
          .height(50)
          .borderRadius(25)
          .margin(10)
          .textAlign(TextAlign.Center)
        Button(`BookView2: this.bookName.size add 1`)
          .width(320)
          .backgroundColor('#ff17a98d')
          .margin(10)
          .onClick(() => {
            this.bookName.size += 1;
            console.log('this.bookName.size:' + this.bookName.size)
          })
      }
      .width(320)
    }
  }
}

@Entry
@Component
struct ObservedObjectLinkPage {
  @State classB: ClassB = new ClassB(new ClassA(0, 'Initial'), 0);
  @State b: ClassDateB = new ClassDateB(new DateClass('2023-1-1'));
  @State user: User = new User(new Bag(0));
  @State child: Book = new Book(new BookName(0));

  build() {
    Column() {
      List() {
        ListItem() {
          // 1 ViewA
          ViewA({ b: this.classB })
        }

        ListItem() {
          Column() {
            // 2 日期
            ViewDateB({ label: 'date', a: this.b.a })
              .margin({top: 20})

            Button(`点击后日期 2023-07-07`)
              .margin({top: 30})
              .onClick(() => {
                this.b.a = new DateClass('2023-07-07');
              })
            Button(`点击后日期 this.b = new ClassB(new DateClass('2023-08-20'))`)
              .margin({top: 10})
              .onClick(() => {
                this.b = new ClassDateB(new DateClass('2023-08-20'));
              })
          }
        }

        ListItem() {
          Column() {
            BookView1({ label: 'BookView1 #1', bag: this.user.bag })
              .width(320)
            BookView2({ label: 'BookView2 #3', bookName: this.child.bookName })
              .width(320)

            Button(`BookView1: this.child.bookName.size add 10`)
              .width(320)
              .backgroundColor('#ff17a98d')
              .margin(10)
              .onClick(() => {
                this.child.bookName.size += 10
                console.log('this.child.bookName.size:' + this.child.bookName.size)
              })
            Button(`BookView1: this.user.bag = new Bag(10)`)
              .width(320)
              .backgroundColor('#ff17a98d')
              .margin(10)
              .onClick(() => {
                this.user.bag = new Bag(10);
              })
            Button(`BookView1: this.user = new User(new Bag(20))`)
              .width(320)
              .backgroundColor('#ff17a98d')
              .margin(10)
              .onClick(() => {
                this.user = new User(new Bag(20));
              })
          }
        }

      }

    }
    .height('100%')
    .width('100%')
  }
}