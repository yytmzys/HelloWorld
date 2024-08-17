export class ComplexNumber {
  private real: Number
  private imaginary: Number

  constructor(real: Number, imaginary: Number) {
    this.real = real
    this.imaginary = imaginary
  }

  toString() {
    return '' + this.real + '+' + this.imaginary + 'i'
  }
}

export function Add(numA: number, numB: number) {
  return numA + numB
}