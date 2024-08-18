export class ClassA {
  public name: string;
  public c: number;
  public id: number;

  constructor(c: number, name: string = 'OK') {
    this.name = name;
    this.c = c;
    this.id = 0;
  }
}

@Observed
export class ClassB {
  public a: ClassA
  public b: number

  constructor(a: ClassA, b: number) {
    this.a = a;
    this.b = b;
  }
}

@Component
export struct ViewA {
  @ObjectLink b: ClassB;

  build() {
    Row() {
      Button(`ViewA ${this.b.a}, this.a.c= ${this.b.b} +1, this.b.a.c = ${this.b.a.c}`)
        .onClick(() => {
          //属性的改动是被允许的
          this.b.a = new ClassA(5)
          this.b.b = 6

          // ClassA没有被@Observed装饰，其属性的变化观察不到
          this.b.a.c = 5
        })
    }.margin({ top: 10 })
  }
}
